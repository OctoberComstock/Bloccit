require 'rails_helper'
 
describe Vote do
  
  include TestFactories
  
  before do
    @upvote = Vote.new(value: 1)
    @downvote = Vote.new(value: -1)
  end
  
  describe "validations" do
    describe "value validation" do
      it "allows 1 as value" do
        expect( @upvote.value ).to eq(1)
      end
       it "allows -1 value" do
        expect( @downvote.value ).to eq(-1)
       down_vote = Vote.new(value: -1)
         expect(down_vote.valid?).to eq(true)

         invalid_vote = Vote.new(value: 2)
         expect(invalid_vote.valid?).to eq(false)
       end
     end
   end

   describe 'after_save' do
     it "calls `Post#update_rank` after save" do
       post = associated_post
       vote = Vote.new(value: 1, post: post)
       expect(post).to receive(:update_rank)
       vote.save
     end
   end
 end
 
  # def associated_post(options={})
  # post_options = {
  #   title: 'Post title',
  #   body: 'Post bodies must be pretty long.',
  #   topic: Topic.create(name: 'Topic name'),
  #   user: authenticated_user
  # }.merge(options)
   
  # Post.create(post_options)
  # end
 
# def authenticated_user(options={})
#     user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
#     user = User.new(user_options)
#     user.skip_confirmation!
#     user.save
#     user
# end