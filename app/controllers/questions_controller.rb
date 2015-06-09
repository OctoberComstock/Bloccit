class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end
  
  def update
    @question = Question.update
  end
  
  def destroy
    @question = Question.destroy
  end
  
  def create
   @question = Question
    .new(params.require(:question)
    .permit(:title, :body))
   if @question.save
    flash[:notice] = "Question was submitted."
    redirect_to @question
    
   else
    flash[:error] = "There was an error submitting the question. Please try again."
    render :new
   end
  end

  def edit
  end
end
