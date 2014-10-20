class TwitterData

	include Twitter

	TWITTER_CONFIG ={ consumer_key:  "ymoMOzQlG4OBX4bfSwX3gHSDa",
             consumer_secret: "Q1uKAKTsuZLcbiufBT1R28UsJNkTfw8ixE9BwZDzqAHinQcAGX",
             access_token: "223114717-b85z1pHpiB9Eg9raxUBRClQHJjYthslMhI3o8UWh",
             access_token_secret: "I3E20lo6bnZHlCsNiljByM60MMmPEyKvrkfTsCaTM0dqU"
           }

	attr_accessor :client

	def initialize
		@client = Twitter::REST::Client.new(TWITTER_CONFIG)
	end

	def search_popular_tweets(search_term="programming")
		client.search(search_term,options={result_type: 'popular'})
	end

	def grab_top3_tweets(search_term="programming")
		search_result = []
		search_popular_tweets(search_term).each do |tweet|
			search_result << Hash[:name, tweet.user.name , :tweet , tweet.text]
		end
		search_result[0..2]
	end

end