class Admin::PostsController < Admin::ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		if params[:search].present? && !params[:search].nil?
			@posts = Post.where(
				"title like ? OR content like ?", "%#{params[:search]}%", "%#{params[:search]}%").page params[:page]
		else
			@posts = Post.all.order(id: :desc).page params[:page]
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			flash[:notice] = "Post created successfully"
			redirect_to admin_posts_url
		else
			flash[:alert] = "There was a problem creating Post"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update

		if @post.update(post_params)
			flash[:notice] = "Post updated successfully"
			redirect_to admin_posts_url
		else
			flash[:alert] = "There was a problem updating Post"
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		flash[:notice] = "Post deleted successfully"
		redirect_to :back
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:id, :title, :content, :publish, :moderator_id, tag_ids: [])
	end
end
