class PostsController < ApplicationController
  
  def index
    @tweets = Post.get_obama_tweets
    @splitwords = Post.split_word
    @filter_words = Post.filter_words
    @randomizer = Post.word_randomizer
    @syllabizer = Post.syllable_count
  end
end
