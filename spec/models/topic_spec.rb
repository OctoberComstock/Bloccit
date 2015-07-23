require 'rails_helper'

describe Topic do
   describe "scopes" do
     
     
     before do
       @public_topic = Topic.create(name: 'My Public Title') #default is public
       @private_topic = Topic.create(public: false, name: 'My Private Title')
     end
 
     describe "publicly_viewable" do
      it "returns a relation of all public topics" do
         expect(Topic.publicly_viewable).to eq( [@public_topic] )
      end
     end
 
     describe "privately_viewable" do
       it "returns a relation of all private topics" do
         expect(Topic.privately_viewable).to eq( [@private_topic] )
       end
     end
 
     describe "visible_to(user)" do
       it "returns all topics if the user is present" do
         user = User.new
         expect(Topic.visible_to(user) )
       end
         user = User.new
 
       it "returns only public topics if user is nil" do
         expect( Topic.visible_to(user.nil?) ).to eq([@public_topic])
       end
     end
   end
 end