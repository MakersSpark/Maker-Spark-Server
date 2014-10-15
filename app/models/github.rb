# require 'githubstats'

class GithubData
	include GithubStats

	attr_reader :account

	def initialize(account_name)
		@account = GithubStats.new(account_name)
	end


	def get_commit_streak

	end
end