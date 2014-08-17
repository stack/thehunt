class BroadcastController < SecuredController

  def index
    @teams = Team.order :name
  end

  def send_broadcast
    # Ensure there's a message
    if params[:message].blank?
      redirect_to broadcast_index_path, :notice => 'A message is required'
      return
    end

    # Get the people
    if params[:id] == 'all'
      people = Person.all
    else
      people = Person.where(team_id: params[:id])
    end

    # Send the message
    client = Twilio::REST::Client.new APP_CONFIG['twilio_account_sid'], APP_CONFIG['twilio_account_token']
    people.each do |person|
      client.account.messages.create(from: APP_CONFIG['twilio_number'], to: person.number, body: params[:message])
    end

    redirect_to broadcast_index_path, :notice => 'You message was sent'
  end


end
