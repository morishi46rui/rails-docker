# spec/requests/examples_spec.rb
require 'swagger_helper'

RSpec.describe 'Examples API', type: :request do
  path '/examples' do
    get 'Retrieves examples' do
      tags 'Examples'
      produces 'application/json'

      response '200', 'examples found' do
        run_test!
      end
    end
  end
end
