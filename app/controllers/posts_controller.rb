class PostsController < ApplicationController

#   after_create :create_vote

  def show
   @post = Post.find(params[:id])
   @topic = Topic.find(params[:topic_id])
   @comments = @post.comments 
   authorize @post
  end

  def new
   @post = Post.new
   @topic = Topic.find(params[:topic_id])
   authorize @post
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
    if @post.save
       @post.create_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    
   else
    flash[:error] = "There was an error saving the post. Please try again."
    render :new
    end
  end

  def edit
   @topic = Topic.find(params[:topic_id])  
   @post = Post.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:topic_id])  
    @post = Post.find(params[:id])
    authorize @post
   if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
       redirect_to @topic
   else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
   end
  end
  
  def destroy
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     authorize @post
 
     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
  end
  
  
  private

  def post_params
      params
        .require(:post)
        .permit(:title, :body, :image, :topic_id)
  end
  
#   def create_vote
#      @vote.create!(post: @post, user: current_user, value: 1)
#   end
end
