require 'swagger_helper'

RSpec.describe "Api::V1::Examples", type: :request do
  path '/api/v1/examples' do
    get 'Retrieve examples' do
      tags 'Examples'
      produces 'application/json'

      response '200', 'successful response' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: ['message']

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('This is the index action')
        end
      end
    end
  end
end
