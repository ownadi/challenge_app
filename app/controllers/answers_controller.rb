class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_answer, except: [:create]

  def create
    redirect_to question_path(@question) if @question.has_accepted_answer? #there's already accepted answer - redirect to question

    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      Thread.new do
        begin
          QuestionMailer.new_answer(@question.user, @question).deliver
        ensure
          ActiveRecord::Base.connection.close
        end
      end
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def like
    if current_user.likes? @answer
      redirect_to question_path(@question) #already liked!!
    else
      @like = Like.new
      @like.user = current_user
      @like.answer = @answer

      @like.save
      @answer.user.add_points(5)
      respond_to :js
      #render 'like.js'
    end
  end

  def accept
    if current_user.author_of? @question and not @question.has_accepted_answer?
      @answer.accepted = true
      @answer.save
      @answer.user.add_points(25)
      Thread.new do
        begin
          AnswerMailer.accepted(@answer.user, @answer.question).deliver
        ensure
          ActiveRecord::Base.connection.close
        end
      end
    end
      redirect_to question_path(@question)
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = Answer.find(params[:answer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end
end
