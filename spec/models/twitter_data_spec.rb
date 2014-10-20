describe TwitterData do

	include Twitter

 stub_request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=byverdu").
 with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'OAuth oauth_consumer_key="ymoMOzQlG4OBX4bfSwX3gHSDa", oauth_nonce="45224b5499e9786d1fb874f2ac0bcb8d", oauth_signature="aOOzEFygRvfmSbalrCRtXY1zv%2BQ%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1414078260", oauth_token="223114717-b85z1pHpiB9Eg9raxUBRClQHJjYthslMhI3o8UWh", oauth_version="1.0"', 'User-Agent'=>'Twitter Ruby Gem 5.11.0'}).
 to_return(:status => 200, :body => "", :headers => {})
 let(:search_term) { "programming"  }
 let(:user1) { double :user, name: "Albertino"}
 let(:user2) { double :user, name: "BenjaminoTilleto"}
 let(:user3) { double :user, name: "vinzenzo"}
 let(:search_result1) { double :search_result, text: "Programming is shit", user: user1}
 let(:search_result2) { double :search_result, text: "Programming is super cool", user: user2}
 let(:search_result3) { double :search_result, text: "Albert, the programmer, should get well soon!", user: user3}
 let(:search_result4) { double :search_result, text: "Albert, the programmer, is going home soon", user: user3}
 let(:search_results) { [search_result1,search_result2,search_result3, search_result4] }
 let(:hashtag1) { double :hashtag, name: '#albertissick' }
 let(:hashtag2) { double :hashtag, name: '#graduween' }
 let(:hashtag3) { double :hashtag, name: '#angulariscrazy' }
 let(:hashtags) { [hashtag1,hashtag2,hashtag3] }


 let(:client) { double :twitter_rest_client } 
 let(:config)  	{{ consumer_key:  "ymoMOzQlG4OBX4bfSwX3gHSDa",
             consumer_secret: "Q1uKAKTsuZLcbiufBT1R28UsJNkTfw8ixE9BwZDzqAHinQcAGX",
             access_token: "223114717-b85z1pHpiB9Eg9raxUBRClQHJjYthslMhI3o8UWh",
             access_token_secret: "I3E20lo6bnZHlCsNiljByM60MMmPEyKvrkfTsCaTM0dqU"
           }}


  let(:twitter_data) { TwitterData.new }


	it "creates a client" do 
		expect(Twitter::REST::Client).to receive(:new).with(config)
		TwitterData.new
	end

	context "searching popular tweets" do 
		before do 
			allow(Twitter::REST::Client).to receive(:new).with(config)
	 		allow(twitter_data).to receive(:client).and_return(client)
		end


	  it "can find the most popular tweets for a specific search term" do 
	 		expect(client).to receive(:search).with(search_term,options={result_type: 'popular'}).and_return(search_results)
	 		twitter_data.search_popular_tweets("programming")
	  end

	  it "can grab the first 3 most popular tweets and put them in a hash" do
	  	allow(client).to receive(:search).with(search_term,options={result_type: 'popular'}).and_return(search_results)
	  	expect(twitter_data.grab_top3_tweets()).to eq [{name: user1.name ,tweet: search_result1.text}, {name: user2.name ,tweet: search_result2.text},{name: user3.name ,tweet: search_result3.text}]	
	  end

	  # it "can lookup most trending hashtag for a specified WOEID" do 
	  # 		expect(client).to receive(:trends).with(id=44418).and_return(hashtags)
	  # 		twitter_data.search_trending_hashtags
	  # end

	end





end