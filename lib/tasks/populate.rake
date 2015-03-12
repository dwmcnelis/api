namespace :db do
  task populate: :environment do

    Client.delete_all

    def random_status
      ['new', 'in progress', 'closed', 'bad'].sample
    end

    20.times do
      Client.create(
        user_id: 'cddeda64-3f26-4a09-b976-492f9e0f22f2',
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        status: random_status,
        notes: Faker::Lorem.paragraph(2)
      )
    end

  end
end
