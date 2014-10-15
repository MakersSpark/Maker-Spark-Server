describe GithubData do 

	let(:github) { GithubData.new('byverdu') }

	
	context "using the GithubStats gem" do

		before do 
			stub_request(:get, "https://github.com/users/byverdu/contributions").
         		to_return(:body => "")
         		# before { GithubData.file('../spec/githubstats.yml') } 
		end

		it 'it is initialized with the account name' do
			expect(github.respond_to? :account).to eq true
		end 

		it 'sends a get request to github' do
			github.account.data
			expect(a_request(:get, "https://github.com/users/byverdu/contributions")).to have_been_made
		end

		xit 'can get the current streak of the user' do 
			expect(github.current_streak).to match Integer
		end
	end
end
