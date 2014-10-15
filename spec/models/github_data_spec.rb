describe GithubData do 

	let(:github) { GithubData.new('byverdu') }

	context "using the GithubStats gem" do\

		before do 
			stub_request(:get, "https://github.com/users/byverdu/contributions").
         		to_return(:body => "'Contributions from byverdu'") 
		end

		it 'it is initialized with the account name' do
			expect(github.respond_to? :account).to eq true
		end 

		it 'sends a get request to github for the data of contributions of the specified account' do
			github.account.data
			expect(a_request(:get, "https://github.com/users/byverdu/contributions")).to have_been_made
		end
	end
end
