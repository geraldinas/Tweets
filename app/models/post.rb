class Post < ActiveRecord::Base

  def get_tweets
    @tweetarray = []
    $client.user_timeline(self.name, count: 5000).each do |tweet|
      @tweetarray << tweet
    end
    @tweetarray
  end

  def filter_words
    @tweetarray = get_tweets
    regex_words = []
    @tweetarray.each do |word_array|
      @tweetdupe = word_array.text.dup
      regex_words << @tweetdupe.gsub(/#(.*)|http(.*)|@(.*)|RT|\.|\W|\d/, " ")#.gsub(/http(.*)/, "").gsub(/@(.*)/, "").gsub(/RT/,"").gsub(".","")
    end
    regex_words
  end

  def split_word
    @words = []
    filter_words.each do |tweet|
      @words << tweet.split(' ')
    end
    @words.flatten
  end


  def word_randomizer
    @randomized = split_word.shuffle
  end

  def syllable_count
    word_randomizer.each_with_object(Hash.new('')) do |word, combos|
        combos[word] = word.count_syllables
    end
  end

  def five_syllable_combo_maker
    sum = 0
    words = []

    syllable_count.each do |word, syl_value|
      if (sum + syl_value) <= 5
        words << word 
        sum += syl_value
      end 
    end
    words
  end

  def seven_syllable_combo_maker
    sum = 0
    words = []

    syllable_count.each do |word, syl_value|
      if (sum + syl_value) <= 7
        words << word 
        sum += syl_value
      end 
    end
    words
  end

  def get_list_five_syllables(n = 10)
    syllables = []
    n.times do 
      syllables << five_syllable_combo_maker
    end
    syllables
  end

  def get_list_seven_syllables(n = 10)
    syllables = []
    n.times do 
      syllables << seven_syllable_combo_maker
    end
    syllables
  end

  def complete_haiku
    get_list_five_syllables.first.each do |word|
      word.capitalize
    end
    get_list_seven_syllables.first.each do |word|
      word.capitalize
    end
    get_list_five_syllables.second.each do |word|
      word.capitalize
    end
  end
end
