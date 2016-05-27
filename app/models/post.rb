class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic
	has_many :comments
	has_many :postvotes, dependent: :destroy

	def score
		postvotes.sum(:score)
	end

end
