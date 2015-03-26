  task token: :environment do

    def duration   
      15*60*1000  # Fifteen minutes in milliseconds
    end

    def username
      ENV['USERNAME'] || 'davemcnelis@gmail.com'
    end

    def user
      User.find_by_username(username)
    end

    def token
      user.generate_token(expires: Token.expires(duration)).to_s
    end

    #puts token
    puts "curl -v -X GET -H \"Accept: application/json\" -H \"Authorization: Bearer #{token}\" http://localhost:3002/api/v1/clients"

  end
