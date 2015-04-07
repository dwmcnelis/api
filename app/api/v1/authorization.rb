# app/api/v1/authorization.rb

# Authorization API
#

module V1

  class Authorization < API

    version 'v1', using: :path, vendor: 'clientbuzz'#, cascade: false
    prefix 'api'
    format :json

    namespace '' do

      # POST /api/v1/authorize
      desc 'Obtain authorization by username/password' do
        detail <<EOS
This entry point is used to obtain authorization by username/password.
EOS
      end
      params do
        requires :username, type: String, desc: 'Username.'
        requires :password, type: String, desc: 'Password.'
      end
      post :authorize do
        benchmark do
          @user = User.find_by_username_password(params[:username],params[:password])
          if @user
            {'token' => @user.generate_token(expires: Token.expires(TOKEN_DURATION)).to_s}
          else
            error!({error: 'Unauthorized',
                    detail: 'Invalid username or password',
                    status: '401'},
                   401)
          end
        end
      end

      # POST /api/v1/verify
      desc 'Verify authorization' do
        detail <<EOS
This entry point is used to verify authorization by token.
EOS
      end
      params do
        requires :token, type: String, desc: 'Authorization token.'
      end
      post :verify do
        benchmark do
          @authorization_token = params[:token]
          details = {}
          details['token'] = authorization_token
          details['valid'] = token.valid?
          details['expires'] = token.expires?
          if token.expires?
            details['expired'] = token.expired?
            details['duration'] = token.duration
          end
          if token.fetch("uid")
            details['uid'] = token.fetch("uid")
            details['username'] = current_user.try(:username)
          end
          details
        end
      end


      # POST /api/v1/refresh
      desc 'Refresh authorization' do
        detail <<EOS
This entry point is used to refresh authorization token.
EOS
      end
      params do
        requires :token, type: String, desc: 'Authorization token.'
      end
      post :refresh do
        benchmark do
          @authorization_token = params[:token]
          if token.valid? && current_user
            if token.expires?
              {'token' => current_user.generate_token(expires: Token.expires(TOKEN_DURATION)).to_s}
            else
              {'token' => authorization_token}
            end
          else
            error!({error:  'Unauthorized',
                    detail: 'Invalid token',
                    status: '401'},
                   401)
          end
        end
      end


    end # namespace

  end # Authorization

end # V1

