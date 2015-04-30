class PostsController < ApplicationController
  
  def index
    @mean_tweets = Post.find_mean_tweets
  end
end
