class PostsController < ApplicationController

	def show
		load_show_content
	end

	def create_comment
		@comment = Comment.new(comment_params)
		@post = Post.find params[:id]
		@comment.user = current_user
		@comment.update(user: current_user, post: @post)
		load_and_render_show
	end

	def delete_comment
		@comment = Comment.find params[:task]
     		@comment.destroy!
     		load_and_render_show
	end

	def submit_comment
		load_show_content
	end

	private

	def topic_params
		params.require(:topic).permit(:name, :description)
	end

	def post_params
		params.require(:post).permit(:title, :description)
	end

	def comment_params
		params.require(:comment).permit(:description)
	end

	def load_and_render_show
		load_show_content
		redirect_to action: :show
	end

	def load_show_content
		@posts = Post.find params[:id]
		@topic = @posts.topic
		@comments = @posts.comments
		puts "#{Topic.find cookies[:topic]} $$$$$$"
	end
end
