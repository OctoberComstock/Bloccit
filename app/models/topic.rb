class Topic < ActiveRecord::Base
  has_many :posts
  
  
  self.per_page = 50

  
  WillPaginate.per_page = 50
  validates :name, length: { minimum: 5 }, presence: true
end