class PostsController < ApplicationController
  
  def create
    @post = Post.new(post_params)
    redirect_to "/posts/#{@post.id}"
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @complete_haiku = @post.complete_haiku
  end

  private
  def post_params
     params.require(:post).permit(:name)
  end
end
