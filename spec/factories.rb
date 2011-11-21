FactoryGirl.define do
  factory :user do
    email "chris@chrismar035.com"
    password "thisisatest"
  end

  factory :guest do
    id 1
    name "Chris Marshall"
    count 1
  end
end
