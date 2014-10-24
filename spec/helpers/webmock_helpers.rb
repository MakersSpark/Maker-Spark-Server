def stub_afternoon_message(github_object)
      stub_weather
      # expect(a_http_request("CENTREBIG"," Good Afternoon benjamintillett!")).to have_been_made
      stub_printer("CENTREBIG","~")
      stub_printer("CENTRE","Partly cloudy for the hour.")
      stub_printer("CENTREBIG"," Good Afternoon benjamintillett!")
      stub_printer("CENTREBIG","~")
      stub_printer("CENTREBIG","~")
      stub_printer("CENTREBIG","~")
      stub_printer("TEXT","")
      stub_printer("BOLD","#{github_object.name}'s GitHub Stats:")
      stub_printer("TEXT","Score today: #{github_object.score_today} commits")
      stub_printer("TEXT","Current streak: #{github_object.current_streak} days")
      stub_printer("TEXT","Longest streak: #{github_object.longest_streak} days")
      stub_printer("TEXT","High score: #{github_object.highscore[0]} on #{github_object.highscore[1]}")
  end

  def expect_afternoon_message_to_have_been_made
      expect(a_http_request("CENTREBIG"," Good Afternoon benjamintillett!")).to have_been_made
      expect(a_http_request("CENTREBIG","~")).to have_been_made.times(4)
      expect(a_http_request("CENTRE","Partly cloudy for the hour.")).to have_been_made
  end

  def stub_tiny_url
    stub_request(:get, "http://tinyurl.com/api-create.php?url=http://spark-print-staging.herokuapp.com/users/sign_up_with/41d21cd")
  end

  def stub_printer(format,text)
    stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
        with(:body => { access_token: ENV['SPARK_TOKEN'], args: "#{format}=#{text}/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
  end

  def stub_offline_printer(format,text)
    stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
        with(:body => { access_token: ENV['SPARK_TOKEN'], args: "#{format}=#{text}/" }).to_return(:body => "{\n  \"ok\": false,\n  \"error\": \"Timed out.\"\n}")
  end

  def stub_weather
    stub_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")
      .to_return(body: FORECAST_IO_JSON_RESPONE, status: 200)
  end

  def stub_news
      stub_request(:get, "http://content.guardianapis.com/search?api-key=test&order-by=newest&section=uk-news").to_return(body: GUARDIANNEWS_JSON_RESPONSE, status: 200)
  end

  def stub_directions
      stub_request(:get, "http://maps.googleapis.com/maps/api/js/DirectionsService.Route?4b0&5m4&1m3&1m2&1d51.523137&2d-0.087035&5m2&1m1&2sTottenham%20Court%20Road&6e1&12sen-GB&100b0&102b0&callback=_xdc_._zia1l2&token=5147").to_return(body: GOOGLEDIRECTIONS_JSON_RESPONSE, status: 200)
  end

  def stub_github(username)
    stub_request(:get, "https://github.com/users/#{username}/contributions")
  end

  def a_http_request(format, text)
    a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "#{format}=#{text}/" })
  end

  def stub_print_for_controller(format,text)
    stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
                 with(:body => {"access_token"=>"e91e5a05963c1bf996298213f0b892a8e33741e1", "args"=>"CENTREBIG=Good Afternoon/"},
                  :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'api.spark.io', 'User-Agent'=>'Ruby'}).
              to_return(:status => 200, :body => "", :headers => {})
  end