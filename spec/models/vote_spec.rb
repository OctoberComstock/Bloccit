require 'rails_helper'
 
describe Vote do
  
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
      end
    end
  end
end