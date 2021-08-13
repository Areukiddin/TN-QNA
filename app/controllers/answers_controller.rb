class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[show destroy]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params.merge(author: current_user))

    if @answer.save
      redirect_to question_path(@answer.question), notice: t('user_actions.successfully_created', resource: @answer.class)
    else
      render :new
    end
  end

  def destroy
    if @answer.author.eql?(current_user)
      @answer.destroy
      flash[:notice] = t('user_actions.successfully_deleted', resource: @answer.class)
    else
      flash[:notice] = t('user_actions.delete_rejected', resource: @answer.class.to_s.downcase)
    end

    redirect_to question_path(@answer.question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
