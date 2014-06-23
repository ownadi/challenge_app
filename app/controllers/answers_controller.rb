class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    redirect_to question_path(@question) if @question.answers.where(accepted: true).any? #there's already accepted answer - redirect to question

    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      QuestionMailer.new_answer(@question.user, @question).deliver
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def like
    @answer = Answer.find(params[:answer_id])

    if Like.where(user_id: current_user.id, answer_id: @answer.id).any?
      redirect_to question_path(@question)
    else
      @like = Like.new
      @like.user = current_user
      @like.answer = @answer

      @like.save
      @answer.user.update(points: @answer.user.points + 5)
      redirect_to question_path(@question)
    end
  end

  def accept
    if @question.user = current_user and @question.answers.where(accepted: true).empty?
      @answer = Answer.find(params[:answer_id])
      @answer.accepted = true
      @answer.save
      @answer.user.update(points: @answer.user.points + 25)
      AnswerMailer.accepted(@answer.user, @answer.question).deliver
    end
      redirect_to question_path(@question)
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end
end
