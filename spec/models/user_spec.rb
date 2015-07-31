 require 'rails_helper'
 
 describe User do
   describe "#favorited(post)" do
    
    include TestFactories
   
     before :each do
       @post = FactoryGirl.create(:post)
       @favorite_post = FactoryGirl.create(:post)
       #@user = authenticated_user
       @user = FactoryGirl.create(:user_with_post_and_comment)
       @user.favorites.create(post: @favorite_post)
     end
     
     it "returns `nil` if the user has not favorited the post" do
      expect( @user.favorited(@post) ).to eq(nil)
     end
 
     it "returns the appropriate favorite if it exists" do
      expect( @user.favorited(@favorite_post) ).to_not eq(nil)
     end
   end
 end