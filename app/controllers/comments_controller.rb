class CommentsController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was posted."
      redirect_to [@post.topic, @post]
    
   else
    flash[:error] = "There was an error saving the comment. Please try again."
    render :new
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
