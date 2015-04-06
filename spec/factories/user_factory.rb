# spec/factories/user_factory.rb

FactoryGirl.define do

  factory :user, class: 'User' do

#["dob", "gender"

		username { "#{first_name.downcase}.#{last_name.downcase}@example.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    admin { false }
    alpha { false }
    beta { false }
    banned { false }
    tos { true }

    credential

    trait :admin_user do
      admin { true }
    end

    trait :alpha_user do
      alpha { true }
    end

    trait :beta_user do
      beta { true }
    end

    trait :banned_user do
      banned { true }
    end

    trait :tos_accepted do
      tos { true }
    end

    trait :tos_not_accepted do
      tos { false }
    end

  end

end
