class ReactionsController < ApplicationController
  before_action :set_reaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @reactions = Reaction.all
  end

  def show
  end

  def new
    answer = Answer.find(params[:answer_id])
    @reaction = answer.reactions.build(user_id: current_user.id)
  end

  def edit
  end

  def create
    answer = Answer.find(params[:answer_id])
    @reaction = answer.reactions.build(reaction_params)
    @post = @reaction.answer.post

    respond_to do |format|
      if @reaction.save
        @post.create_notification_reaction!(current_user, @reaction.id)
        format.html { redirect_to answer.post, notice: "Reaction was successfully created." }
        format.json { render :show, status: :created, location: @reaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reaction.update(reaction_params)
        format.html { redirect_to　@reaction, notice: "Reaction was successfully updated." }
        format.json { render :show, status: :ok, location: @reaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reaction.destroy
    respond_to do |format|
      format.html { redirect_to reactions_url, notice: "Reaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_reaction
      @reaction = Reaction.find(params[:id])
    end

    def reaction_params
      params.require(:reaction).permit(:user_id, :answer_id, :body)
    end
end
