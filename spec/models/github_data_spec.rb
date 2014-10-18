describe GithubData do 

	let(:github) { GithubData.new('byverdu') }
	let(:stats)  { double :github_stats }
	let(:streak) { double :streak }
	let(:longest_streak) { double :longest_streak }
	let(:max) { double :max }
	let(:data) { double :data, streak: streak, longest_streak: longest_streak, max: max }
	
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
	end
end
