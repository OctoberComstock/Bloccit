FactoryGirl.define do
   factory :user do
     name "Douglas Adams"
     sequence(:email, 100) { |n| "person#{n}@example.com" }
     password "helloworld"
     password_confirmation "helloworld"
     confirmed_at Time.now

    # after(:build) { :user_with_post_and_comment }
     
     factory :user_with_post_and_comment do
        # association :user, factory: :user
        posts { build_list :post, 20 }
        comments { build_list :comment, 20 }
     end
    
    end
end