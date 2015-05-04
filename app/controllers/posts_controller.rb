class PostsController < ApplicationController
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to "/posts/#{@post.id}"
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @complete_haiku = @post.complete_haiku
    #@five_sentence = @post.get_list_five_syllables(2)
    #@seven_sentence = @post.get_list_seven_syllables(1)
  end

  private
  def post_params
     params.require(:post).permit(:name)
  end
end
