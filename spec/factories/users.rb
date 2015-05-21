FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "testuser#{n}@ucla.edu"
    end

    sequence :first_name do |n|
      "firstname#{n}"
    end

    sequence :last_name do |n|
      "lastname#{n}"
    end

    admin true
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end
end
