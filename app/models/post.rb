class Post < ActiveRecord::Base
    
    # after_create :create_vote
    
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :favorites, dependent: :destroy
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
  
    default_scope { order('rank DESC') }
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
   
   def markdown_title
     markdown_to_html(title)  
   end
   
   def markdown_body
     markdown_to_html(body)
   end
   
   def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
     new_rank = points + age_in_days
 
     update_attribute(:rank, new_rank)
   end
   
   def create_vote
    user.votes.create(value: 1, post: self)
   end
   
   
    def save_with_initial_vote
      Post.transaction do
        create_vote
        self.save!
      end
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



