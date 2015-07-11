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
  
  def destroy?
    @topic = Topic.find(params[:post_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    
  authorize @comment
  if @comment.destroy?
    flash[:notice] = "Comment was removed."
    redirect_to [@topic, @post]
  
  else
    flash[:error] = "Comment couldn't be deleted. Please try again."
    redirect_to [@topic, @post]
  end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
