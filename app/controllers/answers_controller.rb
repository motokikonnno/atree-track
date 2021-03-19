class AnswersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @answer = Answer.new
    if @answer.update(answer_params)
      @post.create_notification_answer!(current_user, @answer.id)
      redirect_to post_path(@post), notice: '成功'
    else
      redirect_to post_path(@post), alert: '失敗'
    end
  end

  def edit
  end

  private
  def answer_params
    params.require(:answer).permit(:content, :post_id, :user_id, :answer_name)
  end
end
