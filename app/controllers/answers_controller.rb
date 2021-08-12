class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[show destroy]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

  def destroy
    if @answer.author.eql?(current_user)
      @answer.destroy
      flash[:notice] = "Answer was successfully deleted."
    else
      flash[:notice] = "You can't delete this answer, because you are not an author."
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
