namespace :db do
  namespace :populate do
    task :clients => :environment do


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

      user = User.create(id: 'ce173771-903e-4110-bfd0-f14123e412ca', username: 'davemcnelis@gmail.com', first_name: 'David', last_name: 'McNelis', dob: '1960-01-01', gender: 1, admin: 1, alpha: 0, beta: 0, banned: 0, tos: 0)
      user.create_credential(password: 'weston')

      david = Client.create(id: 'ce173771-903e-4110-bfd0-f14123e412ca', user_id: user.id, first_name: 'David', last_name: 'McNelis', email: 'davemcnelis@gmail.com', phone: Faker::PhoneNumber.phone_number, status: random_status, notes: Faker::Lorem.paragraph(2))
      jon = Client.create(id: 'd575b57a-6bbd-4347-9d07-498c8b78a3bb', user_id: user.id, first_name: 'Jon', last_name: 'McNelis', email: 'jdmcnelis@gmail.com', phone: Faker::PhoneNumber.phone_number, status: random_status, notes: Faker::Lorem.paragraph(2))
      tori = Client.create(id: '9a3a3ecf-89cc-42a2-9c33-3a5a9269ebf5', user_id: user.id, first_name: 'Tor', last_name: 'McNelis', email: 'vamcnelis@gmail.com', phone: Faker::PhoneNumber.phone_number, status: random_status, notes: Faker::Lorem.paragraph(2))

      # david = Client.find_by_id('ce173771-903e-4110-bfd0-f14123e412ca')
      # david =  user.clients.search('mcnelis').search('david').first
      david.image = File.new(File.join(Rails.root, 'populate/clients/kayaker.jpg'))
      david.save
      # jon = Client.find_by_id('d575b57a-6bbd-4347-9d07-498c8b78a3bb')
      # jon =  user.clients.search('mcnelis').search('jon').first
      jon.image = File.new(File.join(Rails.root, 'populate/clients/jon.jpg'))
      jon.save
      # tori = Client.find_by_id('9a3a3ecf-89cc-42a2-9c33-3a5a9269ebf5')
      # tori =  user.clients.search('mcnelis').search('tori').first
      tori.image = File.new(File.join(Rails.root, 'populate/clients/tori.jpg'))
      tori.save

    end
  end
end
