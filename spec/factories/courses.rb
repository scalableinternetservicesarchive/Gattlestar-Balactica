FactoryGirl.define do
  factory :course do
    sequence :department do |n|
      "department#{n}"
    end

    sequence :course_id do |n|
      n
    end

    sequence :professor_first_name do |n|
      "firstname#{n}"
    end

    sequence :professor_last_name do |n|
      "lastname#{n}"
    end
  end
end
