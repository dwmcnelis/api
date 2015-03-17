namespace :db do
  namespace :populate do
    task :many_clients => :environment do


      def random_status
        ['new', 'verified', 'qualified', 'disqualified', 'inactive', 'active'].sample
      end

      def random_level
        [1, 2, 3].sample
      end

      def random_rank
        rand(1...100)
      end

      def random_buzzes(level=1)
        return rand(101...200) if level == 1
        return rand(51...100) if level == 2
        return rand(11...50) if level == 3
        rand(1...10)
      end


      count = ENV['COUNT'] || 200;

      user = User.create(
        username: 'davemcnelis@many.com',
        first_name: 'David',
        last_name: 'McNelis',
        dob: '1960-01-01',
        gender: 1,
        admin: 0,
        alpha: 0,
        beta: 0,
        banned: 0,
        tos: 0,
      )

      user.create_credential(
        password: 'weston'
      )

      user = User.find_by_username('davemcnelis@many.com')

      count.times do
        Client.create(
          user_id: user.id,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          phone: Faker::PhoneNumber.phone_number,
          status: random_status,
          level: random_level,
          rank: random_rank,
          buzzes: random_buzzes,
          notes: Faker::Lorem.paragraph([1, 2].sample)
        )
      end

    end
  end
end
