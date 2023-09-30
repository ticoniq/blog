class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_path(current_user), notice: 'Post was successfully created.'
    else
      puts @post.errors.full_messages
      render :new
    end
  end

  def like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @like = @post.likes.new
    @like.author = current_user

    if @like.save
      flash[:notice] = 'Post liked successfully.'
    else
      flash[:alert] = 'Failed to like the post.'
    end

    redirect_to user_post_path(@user, @post)
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end
end
