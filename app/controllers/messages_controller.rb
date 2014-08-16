require 'twilio-ruby'

class MessagesController < ApplicationController
  include Webhookable

  after_filter :set_header, only: :create
  skip_before_action :verify_authenticity_token, only: :create

  def create
    # Extract the body
    body = params['Body'].strip.downcase

    if body =~ /team ([a-z0-9]+)/
      response = process_team($1)
    else
      # Ensure the user is authorized
      person = Person.find_by number: params['From']

      if person.nil?
        response = makeResponse 'You must be registered to answer questions.'
      elsif !person.team.started?
        response = makeResponse 'Your team has not been started. Contact the administrator for help.'
      else
        if body == '?'
          response = process_help(body, person)
        else
          response = process_checkpoint(body, person)
        end
      end
    end

    render_twiml response
  end

  private

  def makeResponse(message)
    return Twilio::TwiML::Response.new do |r|
      r.Message message
    end
  end

  def process_help(body, person)
    # Get the team position
    position = person.team.position

    # Get the current checkpoint
    checkpoint = Checkpoint.find_by order: position

    # Send back the response
    makeResponse checkpoint.response
  end

  def process_checkpoint(body, person)
    # Get the team position
    position = person.team.position

    # Get the next checkpoint
    checkpoint = Checkpoint.find_by order: position + 1

    # The end?
    if checkpoint.nil?
      return makeResponse "You're already done. Congratulations. Again."
    end

    # Did it match?
    if /#{checkpoint.message}/ =~ body
      # Move to the next position
      person.team.update_attribute :position, checkpoint.order

      # Log it
      log = Log.new
      log.checkpoint = checkpoint
      log.person = person
      log.team = person.team
      log.save

      return makeResponse checkpoint.success_message
    else
      return makeResponse 'Nope.'
    end
  end

  def process_team(code)
    # Look for an existing user
    person = Person.find_by number: params['From']
    if !person.nil?
      return makeResponse 'This number is already associated with a team. Contact the administrator for help.'
    end

    # Look for the team
    team = Team.where('lower(code) = ?', code).first
    if team.nil?
      return makeResponse 'Could not find the team. Please try again.'
    end

    # Create the person
    person = team.people.build number: params['From']
    if person.save
      return makeResponse "You have been registered on Team #{team.name}."
    else
      return makeResponse 'An error occurred during registration. Contact the administrator for help.'
    end
  end

end

