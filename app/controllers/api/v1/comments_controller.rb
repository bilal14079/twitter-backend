class Api::V1::CommentsController < Api::V1::ApplicationController
  respond_to :json
  after_action :create_notifications, only: [:create]

  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    if @tweet.present?
      @tweet_comment = @tweet.comments.create(comment_body: params[:comment_body], user_id: @current_user.id)     
      if @tweet_comment.present?
        render status: 200, json: { msg: "Comment added succesfully" }
      end   
    else
      render status: 400, json: { msg: "Invalid Tweet ID found" }
    end 
  end

  def edit
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      if @comment.update(comment_body: params[:comment])
        format.html { redirect_to request.referrer, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment=Comment.find_by(id: params[:id])
    if @comment.present?
      respond_to do |format|
        @comment.destroy
        format.html { redirect_to request.referrer, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end 
  end

  def create_notifications
    @recipient = @tweet.user
    if @current_user != @recipient
      Notification.create(recipient: @recipient, actor: @current_user, action: 'posted', notifiable: @tweet_comment)
      ActionCable.server.broadcast "notifications_#{@recipient.id}",
                                 type: 'New Comment',
                                 message: 'You got new comment on your tweet'
    end
  end


end
