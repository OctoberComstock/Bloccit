class CommentsController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was posted."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end
    redirect_to [@post.topic, @post]
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Please try again."
    end
    
     respond_to do |format|
       format.html
       format.js
     end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
