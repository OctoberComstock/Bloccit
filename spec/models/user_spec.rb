 require 'rails_helper'
 
 describe User do
   describe "#favorited(post)" do
    
    include TestFactories
   
     before :each do
     @post = associated_post
     @user = authenticated_user
     end
     
     it "returns `nil` if the user has not favorited the post" do
      # user = authenticated_user
      expect( @user.favorited(@post) ).to eq(nil)
     end
 
     it "returns the appropriate favorite if it exists" do
      # user = authenticated_user
      expect( @user.favorited(@post) )
     end
   end
 end