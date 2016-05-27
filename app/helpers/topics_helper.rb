module TopicsHelper

	def calculate_score post
  		upvotes = post.postvotes.where(upvote: true).count
  		downvotes = post.postvotes.where(downvote: true).count
  		score = upvotes - downvotes
	end

	def change_arrow_color post 
		'class=upvoted_post' if post.voted_up
		'class=downvoted_post' if post.voted_down
	end

end
