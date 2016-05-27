class TopicsController < ApplicationController
  before_action :authenticate_user!

	def index
		@topics = Topic.all
		@posts = Post.all
	end

	def new
		@topic = Topic.new
	end

	def show
		load_show_content
		cookies[:topic] = @topic.id
	end

	def create
		@topic = Topic.new(topic_params)
		if @topic.save!
			current_user.people.create topic: @topic
			@topic.update(creator: current_user)
			flash[:success] = "Topic created successfully"
			@id = @topic.id
			redirect_to action: :index
		else
			flash[:error] = @topic.errors.full_messages
			redirect_to new_topic_path
		end
	end

	def edit
		@topic = Topic.find params[:id]
	end

	def destroy
		@topic = Topic.find params[:id]
		@topic.destroy!
		redirect_to topics_path
	end

	def submit
		@topic = Topic.find params[:id]
	end

	def create_post
		@post = Post.new(post_params)
		@topic = Topic.find params[:id]
		@post.user = current_user
		@post.update(user: current_user, topic: @topic)
		load_and_render_show
	end

	def delete_post
		@post = Post.find params[:post]
     		@post.destroy!
     		load_and_render_show
	end

  def increment_upvote
  	@upvote = Postvote.create(user: current_user, post: Post.find(params[:post]), upvote: true)
  	score
  end

  def increment_downvote
  	@downvote = Postvote.create(user: current_user, post: Post.find(params[:post]), downvote: true)
  	score
  end

  def voted_up
  	@postvote.update_attribute(:upvote, true)
  	@postvote.save!
  	@postvotes = Postvote.all
  end

  def voted_down
  	@postvote.update_attribute(:downvote, true)
  	@postvote.save!
  	@postvotes = Postvote.all
  end

  def score
  	@post = Post.find(params[:post])
  	upvotes = @post.postvotes.where(upvote: true).count
  	downvotes = @post.postvotes.where(downvote: true).count
  	@score = upvotes - downvotes
  end


	private

	def topic_params
		params.require(:topic).permit(:name, :description)
	end

	def post_params
		params.require(:post).permit(:title, :description, :rating)
	end

	def load_and_render_show
		load_show_content
		redirect_to action: :show
	end

	def load_show_content
		@topic = Topic.find params[:id]
		@posts = @topic.posts
	end

	def upvote_params
  		params.require(:postvote).permit(:user, :upvote)
  	end

  	def downvote_params
  		 params.require(:postvote).permit(:user, :downvote)
  	end

end
