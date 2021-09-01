class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show update destroy add_attachment delete_attachment]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to @question, notice: t('user_actions.successfully_created', resource: @question.class)
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = t('user_actions.successfully_deleted', resource: @question.class)
    else
      flash[:notice] = t('user_actions.delete_rejected', resource: @question.class.to_s.downcase)
    end

    redirect_to questions_path
  end

  def add_attachment
    @question.files.attach(params.require(:question).require(:files))
  end

  def delete_attachment
    @file = @question.files.find(params[:file_id])
    @file.purge
  end

  private

  def set_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end
end
