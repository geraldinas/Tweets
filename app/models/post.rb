class Post < ActiveRecord::Base

  def self.get_kevin_tweets
    @top_tweets ||= {}
    $client.search("to:@BarackObama").take(500).each do |tweet| 
      @top_tweets[tweet.user.screen_name] = tweet.text
    end
  end

  def self.find_mean_tweets
    get_kevin_tweets  
    analyzer = SentimentLib::Analyzer.new
    @top_tweets.select do |user, tweet|      
      tweet if analyzer.analyze(tweet) < 0
    end
  end


end
