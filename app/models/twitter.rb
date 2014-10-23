class TwitterData

	include Twitter

	TWITTER_CONFIG ={ consumer_key:  "ymoMOzQlG4OBX4bfSwX3gHSDa",
             consumer_secret: "Q1uKAKTsuZLcbiufBT1R28UsJNkTfw8ixE9BwZDzqAHinQcAGX",
             access_token: "223114717-b85z1pHpiB9Eg9raxUBRClQHJjYthslMhI3o8UWh",
             access_token_secret: "I3E20lo6bnZHlCsNiljByM60MMmPEyKvrkfTsCaTM0dqU"
           }

	attr_accessor :client, :search_term

	def initialize(search_term = "news")
		@search_term = search_term
		@client = Twitter::REST::Client.new(TWITTER_CONFIG)
	end

	def search_popular_tweets(search_term)
		client.search(search_term,options={result_type: 'popular'})
	end

	def grab_top3_tweets
		tweets = search_popular_tweets(search_term).map do |tweet|
			Hash[:name, tweet.user.name , :tweet , tweet.text]
		end
		tweets[0..2]
	end

	def json
		grab_top3_tweets.map do |tweet|
			Hash[:format, "TEXT", :text, "#{tweet[:tweet]} - by @#{tweet[:name]}"]
		end
	end
end