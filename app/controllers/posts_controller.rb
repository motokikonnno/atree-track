class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page])
  end

  def answered
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page])
  end

  def show
    @answer = Answer.new
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def edit
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      @post.user_id = current_user.id
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    @user = current_user.id
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:video, :content, :user_id, :best_answer_id, {:tag_ids => []})
    end
end
