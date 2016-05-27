class PagesController < ApplicationController
  def index
  	@topics = Topic.all
	@posts = Post.all
	@comments = Comment.all
	@first_post = Post.first
  end

    def increment_upvote
  	@upvote = Postvote.create(user: current_user, post: Post.find(params[:post]), upvote: true)
  	score
  end

  def increment_downvote
  	@downvote = Postvote.create(user: current_user, post: Post.find(params[:post]), downvote: true)
  	score
  end

  def destroy_upvote
  end

  def destroy_downvote
  end

  def score
  	@post = Post.find(params[:post])
  	upvotes = @post.postvotes.where(upvote: true).count
  	downvotes = @post.postvotes.where(downvote: true).count
  	@score = upvotes - downvotes
  end

end
