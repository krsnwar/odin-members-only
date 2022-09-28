class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
    @users = User.all
  end

  def new
    @post = Post.new
  end

  def create
    # Long version
    # @post = Post.new(post_params)
    # @post.user_id = current_user.id

    # Short Version
    @post = current_user.posts.create(post_params)


    if @post.save
        redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
