class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    belongs_to :user
    belongs_to :topic
    has_one :summary
  
  
    mount_uploader :image , ImageUploader
    
    def up_votes
     votes.where(value: 1).count
    end
    
    def down_votes
     votes.where(value: -1).count    
    end
    
    def points
     votes.sum :value    
    end
  
    default_scope { order('created_at DESC') }
    
    # validates :title, length: { minimum: 5 }, presence: true
    # validates :body, length: { minimum: 20 }, presence: true
    # validates :topic, presence: true
    # validates :user, presence: true
   
   def markdown_title
     markdown_to_html(title)  
   end
   
   def markdown_body
     markdown_to_html(body)
   end
   
   private
   
   def post_params
     params.require(:post).permit(:title, :image)
   end
   
   def markdown_to_html(markdown)
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
     (redcarpet.render markdown).html_safe
   end
end



