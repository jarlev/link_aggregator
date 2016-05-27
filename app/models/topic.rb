class Topic < ActiveRecord::Base
	has_many :people
	has_many :users, through: :people
	has_many :posts
	belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
end

