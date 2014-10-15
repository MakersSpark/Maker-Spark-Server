# require 'githubstats'

class GithubData
	include GithubStats

	attr_reader :account

	# file('../../spec/githubstats.yml')

	def initialize(account_name)
		@account = GithubStats.new(account_name)
	end


	def get_current_streak
		@account.data.streak.score.count
	end

	def get_longest_streak
		@account.data.longest_streak.score.count	
	end

	def get_highscore
		@account.data.max.score
	end
end

