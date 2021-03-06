class TweetsController < ApplicationController
  load_and_authorize_resource 

  # GET /tweets
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
        # @tweet.delay(queue: "Tweets", priority: 10, run_at: 1.minutes.from_now).destroy
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #POST /tweets/1
  def add_like
    @already_liked = TweetLike.find_by(tweet_id: @tweet.id, liked_by_user: current_user.id)
    if !@already_liked.present? || @already_liked == nil
      TweetLike.create(tweet_id: @tweet.id, liked_by_user: current_user.id)
      respond_to do |format|    
          if @tweet.update(likes_count: @tweet.likes_count + 1)
            format.html { redirect_to '/' }
            format.json { head :no_content}
          end   
      end
    else
      respond_to do |format|  
        format.html {redirect_to '/', notice: 'You Already Liked this tweet' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end        
    end 
  end

  private

  def cover_picture_format
    return unless cover_picture.attached?
    return if cover_picture.blob.content_type.start_with? 'image/'
    cover_picture.purge_later
    errors.add(:cover_picture, 'needs to be an image')
  end
 # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:tweet_title, :tweet_content, :cover_picture)
    end
end
