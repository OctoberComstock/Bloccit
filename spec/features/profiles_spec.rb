 require 'rails_helper'
 
 include Warden::Test::Helpers
 Warden.test_mode!
 
 describe "Visiting profiles" do
 
 include TestFactories

   describe "not signed in" do
    before do
      @user = authenticated_user
      @post = associated_post(user: @user)
      @comment = Comment.new(user: @user, post: @post, body: "A Comment")
        allow(@comment).to receive(:send_favorite_emails)
      @comment.save!
    end
 
     it "shows profile" do
       visit user_path(@user)
       expect(current_path).to eq(user_path(@user))
       
       expect( page ).to have_content(@user.name)
       expect( page ).to have_content(@post.title)
       expect( page ).to have_content(@comment.body)
     end
   end
 
 
 
 # describe "User visiting own profile" do
   
  # before do
  #  user = FactoryGirl.create(:user)
  #  login_as(user, :scope => :user)
  # end
  
  # before do
  #    @user = user
  #    @post = associated_post(user: @user)
  #    @comment = Comment.new(user: @user, post: @post, body: "A Comment")
  #    allow(@comment).to receive(:send_favorite_emails)
  #    @comment.save!
  # end
   
    
    describe "signed in " do
     before do
      @user = authenticated_user
      @user.skip_confirmation!
      @user.save
      login_as(@user, :scope => :user)
      @post = associated_post(user: @user)
      @comment = Comment.new(user: @user, post: @post, body: "some comment here")
      allow(@comment).to receive(:send_favorite_emails)
      @comment.save!
     end
     
     after do
      Warden.test_reset!
     end
     
     it "shows own profile to user" do
       
       visit user_path(@user)
       expect(current_path).to eq(user_path(@user))
       
       expect( page ).to have_content(@user.name)
       expect( page ).to have_content(@post.title)
       expect( page ).to have_content(@comment.body)
      end
     end
    end