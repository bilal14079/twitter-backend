class NotificationsController < InheritedResources::Base

  before_action :set_notifications

  def index
  end

  def update
    @notification = Notification.find_by(id: params[:id])
    if @notification.present?
      @notification.update(read_at: DateTime.now)
      redirect_to '/notifications'
    end
  end
  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user).unread
    @notifications = @notifications.includes(:actor, :recipient, :notifiable) #includes is for eager loading
  end

  def notification_params
    params.require(:notification).permit(:recipient_id, :actor_id, :read_at, :action, :notifiable_id, :notifiable_type)
  end
end

