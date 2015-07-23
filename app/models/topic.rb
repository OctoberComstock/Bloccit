class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

scope :visible_to, -> (user) { user ? all : where(public: true) }

 
  
  def self.publicly_viewable
    where(public: true)
  end
  
  
  def self.privately_viewable
    where(public: false)
  end
  
  self.per_page = 50

  
  WillPaginate.per_page = 50
  
  validates :name, length: { minimum: 5 }, presence: true
end
