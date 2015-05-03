class PostsController < ApplicationController
  
  def index
    @tweets = Post.get_obama_tweets
    @splitwords = Post.split_word
    @filter_words = Post.filter_words
    @randomizer = Post.word_randomizer
    @syllabizer = Post.syllable_count
    @five_sentence = Post.get_list_five_syllables()
    @seven_sentence = Post.get_list_seven_syllables(1)
  end
end
