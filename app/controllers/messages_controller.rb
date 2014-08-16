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
      response = Twilio::TwiML::Response.new
    end

    render_twiml response
  end

  private

  def process_team(code)
    # Look for an existing user
    person = Person.find_by number: params['From']
    if !person.nil?
      return Twilio::TwiML::Response.new do |r|
        r.Message 'This number is already associated with a team. Contact the administrator for help.'
      end
    end

    # Look for the team
    team = Team.where('lower(code) = ?', code).first
    if team.nil?
      return Twilio::TwiML::Response.new do |r|
        r.Message 'Could not find the team. Please try again.'
      end
    end

    # Create the person
    person = team.people.build number: params['From']
    if person.save
      return Twilio::TwiML::Response.new do |r|
        r.Message "You have been registered on Team #{team.name}."
      end
    else
      return Twilio::TwiML::Response.new do |r|
        r.Message 'An error occurred during registration. Contact the administrator for help.'
      end
    end
  end

end
