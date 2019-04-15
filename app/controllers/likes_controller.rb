class LikesController < InheritedResources::Base

  def create
    @tweet=Tweet.find_by(id: params[:tweet_id])
    if !@tweet.likes.find_by(user: current_user).present? 
      @tweet_like = @tweet.likes.create(user_id: current_user.id)
      respond_to do |format|    
          if @tweet_like.present?
            format.html { redirect_to request.referrer}
            format.json { head :no_content}
          end   
      end
    else
      @tweet.likes.find_by(user: current_user).destroy
      respond_to do |format|  
        format.html {redirect_to request.referrer}
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end        
    end 
  end
  
  private

    def like_params
      params.require(:like).permit(:user_id, :tweet_id)
    end
end

