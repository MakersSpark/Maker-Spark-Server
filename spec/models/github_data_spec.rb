describe GithubData do 

	let(:github) { GithubData.new('byverdu') }
	let(:stats)  { double :github_stats }
	
	context "using the GithubStats gem" do

		before do 
			
			GithubStats.stub(:new).and_return(stats)
		end

		it 'can get the current streak of the user' do 
			streak = double :streak
			data = double :data, streak: streak
			allow(stats).to receive(:data).and_return(data)
			expect(streak).to receive(:count)
			github.current_streak
		end
	end
end
