class Post < ActiveRecord::Base

  def self.get_obama_tweets
    @tweetarray ||= []
    $client.user_timeline("barackobama").each do |tweet|
      @tweetarray << tweet
    end
    @tweetarray
  end

  def self.filter_words
    regex_words = []
    @tweetarray.each do |word_array|
      @tweetdupe = word_array.text.dup
      regex_words << @tweetdupe.gsub(/#(.*)/, "").gsub(/http(.*)/, "").gsub(/@(.*)/, "").gsub(/RT/,"").gsub(".","")
    end
    regex_words
  end

  def self.split_word
    @words = []
    filter_words.each do |tweet|
      @words << tweet.split(' ')
    end
    @words.flatten
  end


  def self.word_randomizer
    @randomized = split_word.sample(140)
  end

  def self.syllable_count
    word_randomizer.each_with_object(Hash.new('')) do |word, hash|
        #hash.each do |key, value|
        hash[word.count_syllables] += word
      end
    binding.pry
  end

end
