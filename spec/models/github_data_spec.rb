describe GithubData do 

	let(:github) { GithubData.new('byverdu') }
	let(:stats)  { double :github_stats }
	let(:streak) { double :streak,  count: 4567 } 
	let(:longest_streak) { double :longest_streak,  count: 666 } 
	let(:max) { double :max, score: 999, date: "05/05/2014" }
	let(:data) { double :data, streak: streak, longest_streak: longest_streak, max: max, today: 89 }
	

	context "requiring contributions from the GithubStats gem" do

		before do 
			expect(GithubStats).to receive(:new).and_return(stats)
		end

		it 'can get the current streak of the user' do 
			allow(stats).to receive(:data).and_return(data)
			expect(streak).to receive(:count)
			github.current_streak
		end

		it 'can get the longest_streak of the user' do 
			allow(stats).to receive(:data).and_return(data)
			expect(longest_streak).to receive(:count)
			github.longest_streak
		end

		it 'can get the score of today' do 
			allow(stats).to receive(:data).and_return(data)
			expect(data).to receive(:today)
			github.score_today
		end

		it 'can get highscore' do 
			allow(stats).to receive(:data).and_return(data)
			allow(data).to receive(:max).and_return(max)
			expect(max).to receive(:score)
			expect(max).to receive(:date)
			github.highscore
		end
	

	

		it 'can get git hub data as a json' do
			allow(stats).to receive(:data).and_return(data)
			allow(stats).to receive(:name).and_return("ben")
			expect(github.json).to eq [
				{ format: "BOLD", text: "byverdu's GitHub Stats:"},
				{ format: "TEXT", text: "Score today: 89"},
				{ format: "TEXT", text: "Current streak: 4567"},
				{ format: "TEXT", text: "Longest streak: 666"},
				{ format: "TEXT", text: "High score: 999 on 05/05/2014"}
			]
		end
	end
end



# allow(stats).to receive(:score_today).and_return(89)
# 			allow(stats).to receive(:score_today).and_return(89)
# 			allow(stats).to receive(:name).and_return("ben")
# 			allow(stats).to receive(:current_streak).and_return(4567)
# 			allow(stats).to receive(:longest_streak).and_return(4567)
# 			allow(stats).to receive(:highscore).and_return(["999", "05/05/2014"])

















