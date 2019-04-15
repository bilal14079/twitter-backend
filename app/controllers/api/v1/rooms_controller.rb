class Api::V1::RoomsController < Api::V1::ApplicationController

  def show
    @messages = Message.all
  end
end
