module Api
  class AuthenticationDoc < ApplicationDoc
    resource_description do
      description 'Authentication'
    end

    doc_for :authenticate do
      api :POST, '/authentication/authenticate', 'User login'

      description 'method description'
      formats ['json']
      meta 'Authorization header is not required.'


      error code: 401, desc: 'Unauthorized'
      error code: 404, desc: 'Not Found', meta: 'user not found'

      param :user, Hash, desc: 'User credentials', required: true do
        param :email, String, desc: 'User email for login', required: true
        param :password, String, desc: 'Password for login', required: true
      end

      example "
        'meta': {
          'auth_token': 'eyJhbGciOiJIUzI1NiJ9'
        },
        'data': {
          'user': {
              'id': 57,
              'email': 'vk2@test.com',
              'role': 'member'
          }
        }
        "
    end

    doc_for :create do
      api :POST, '/authentication', 'User register'

      description 'method description'
      formats ['json']
      meta 'Authorization header is not required.'

      error code: 401, desc: 'Unauthorized'
      error code: 404, desc: 'Not Found'

      param :user, Hash, desc: 'User credentials', required: true do
        param :email, String, desc: 'User email for sign up', required: true
        param :password, String, desc: 'Password for sign up', required: true
        param :password_confirmation, String, desc: 'Password Confirmation', required: true
      end
      example "
        'meta': {
          'auth_token': 'eyJhbGciOiJIUzI1NiJ9'
        },
        'data': {
          'user': {
              'id': 57,
              'email': 'vk2@test.com',
              'role': 'member'
          }
        }
        "
    end

    doc_for :logout do
      api :DELETE, '/authentication/logout', 'User logout'
      description 'method description'
      formats ['json']

      meta 'Authorization header is required. Format: Authorization Bearer qwerty'

      example " { 'message': 'Sign out successfully!' }"
    end
  end
end