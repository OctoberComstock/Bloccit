class SummariesController < ApplicationController
  
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary = Summary.new
    # authorize @summary
  end
 
  def show
#   @post = Post.find(params[:post_id])
#   @topic = Topic.find(params[:topic_id])
   @summary = Summary.find(params[:id])
#   authorize @summary
  end

  def create
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    @summary = Summary.new(summary_params)
    @summary.post = @post 
    # authorize @summary
    if @post.save
      flash[:notice] = "Summary was saved."
      redirect_to [@topic, @post, @summary]
   else
    flash[:error] = "There was an error saving the summary. Please try again."
    render :new
    end
  end
  
  def edit
    @summary = Summary.find(params[:id])
  end
  
  def update
    @summary = Summary.find(params[:id])
    
    if @summary.update_attributes(summary_params)
      redirect_to @summary, notice: "Summary updated!"
    else
      render :edit
    end
  end
  
  def destroy
    @summary = Summary.find(params[:id])
    
    if @summary.destroy
      redirect_to topics_path
    else
      render :show
    end
  end
  
  private #all methods below private are only accessible to the specified file
  
  def summary_params
    params.require(:summary).permit(:description)
  end
end
