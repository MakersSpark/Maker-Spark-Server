class GithubData
	include GithubStats

	attr_reader :account, :name

	def initialize(account_name)
		@account = GithubStats.new(account_name)
		@name = account_name
	end

	def score_today
		@account.data.today
	end

	def current_streak
		@account.data.streak.count
	end

	def longest_streak
		@account.data.longest_streak.count	
	end

	def highscore
		[@account.data.max.score, @account.data.max.date]
	end
end

