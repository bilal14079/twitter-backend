class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
    # ActionCable.server.broadcast "notifications_#{current_user.id}", message: 'new notification message'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #It will be used to receive data from its client-side representation.
  # def speak(data)
  #   # ActionCable.server.broadcast "room_channel", message: data['message']
  #   Message.create! content: data['message']
  # end
end
