class PostsController < ApplicationController
  def index
   @posts = Post.all
  end

  def show
   @post = Post.find(params[:id])
  end

  def new
   @post = Post.new
  end
  
  def create
   @post = Post.new(params.require(:post).permit(:title, :body))
   if @post.save
    flash[:notice] = "Post was saved."
    redirect_to @post
    
   else
    flash[:error] = "There was an error saving the post. Please try again."
    render :new
   end
  end

  def edit
   @post = Post.edit_post(params.require(:question).permit(:title, :body))
   if @question.save
    flash[:notice] = "Question was submitted."
    redirect_to @question
    
   else
    flash[:error] = "There was an error submitting the question. Please try again."
    render :new
   end
  end
end
