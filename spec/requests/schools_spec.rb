require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'schools', type: :request do

  path '/schools' do

    get('list schools') do
      response(200, 'successful') do
        example 'application/json', :schools, [
          {"id"=>"d5169068-6adf-4163-a3ed-9adec9502a12",
            "name"=>"Charles Xavier's School For Gifted Youngsters",
            "created_at"=>"2024-07-21T19:58:06.919Z",
            "updated_at"=>"2024-07-21T19:58:06.919Z"},
          {
            "id"=>"e598af11-634c-4cc0-85ad-7aee9bc4ef4d",
            "name"=>"University of the Mountains",
            "created_at"=>"2024-07-21T23:56:17.821Z",
            "updated_at"=>"2024-07-21T23:56:17.821Z"},
          {
            "id"=>"8ebcdc02-d0d1-4b6c-a1ff-546df0969ec3",
            "name"=>"University of Colorado Boulder",
            "created_at"=>"2024-07-21T23:56:18.013Z",
            "updated_at"=>"2024-07-21T23:56:18.013Z"},
          {
            "id"=>"2b9087be-b623-4634-bf8c-e1fb0175c0dd",
            "name"=>"Hogwarts",
            "created_at"=>"2024-07-21T23:56:18.047Z",
            "updated_at"=>"2024-07-21T23:56:18.047Z"}
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = School.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/schools/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show school') do
      response(200, 'successful') do
        example 'application/json', :school, {
          "id"=>"e598af11-634c-4cc0-85ad-7aee9bc4ef4d",
          "name"=>"University of the Mountains",
          "created_at"=>"2024-07-21T23:56:17.821Z",
          "updated_at"=>"2024-07-21T23:56:17.821Z"
        }

        let(:id) { School.all.first.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(id).not_to eq(nil)
          expect(data['id']).not_to eq(nil)
          expect(data['id']).to eq(id)
        end
      end
    end
  end
end
