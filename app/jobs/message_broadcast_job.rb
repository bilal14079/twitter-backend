class MessageBroadcastJob < ApplicationJob
  queue_as :default

  #to perform something later
  def perform(message) 
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end

#New feature in Rails 5 is that you can render templates out of the scope of a controller, using the renderer of the ApplicationController
#Like here we do not have a MessageController defined but we can use its templates through this feature.