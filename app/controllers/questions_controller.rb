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
    @question = Question.find(params[:id])
     #allows title & body to edited by a form
     if @question.update_attributes(
      params
       .require(:question)
       .permit(:title, :body, :resolved)
     )
       flash[:notice] = "Question was updated."
       redirect_to @question
     else
       flash[:error] = "There was an error saving the change. Please try again."
       render :edit
       #render takes me back to the edit page
     end
  end
  
def destroy
    @question = Question.find(params[:id])
  if @question.destroy
    redirect_to questions_path
  else
    render :show
  end
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
    @question = Question.find(params[:id])
  end
end
