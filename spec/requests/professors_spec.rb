require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'professors', type: :request do

  path '/professors' do

    get('list professors') do
      response(200, 'successful') do
        example 'application/json', :professors, [
          {
            "id"=>"aab11918-6cd6-4b34-9803-d71007624a6c",
            "first_name"=>"Charles",
            "last_name"=>"Xavier",
            "created_at"=>"2024-07-21T20:15:12.359Z",
            "updated_at"=>"2024-07-21T20:15:12.359Z"},
          {
            "id"=>"39e52233-51c8-4f9a-b237-5c886edf43c5",
            "first_name"=>"Randy",
            "last_name"=>"Marsh",
            "created_at"=>"2024-07-21T23:56:17.845Z",
            "updated_at"=>"2024-07-21T23:56:17.845Z"},
          {
            "id"=>"b8b7fb53-6c42-400d-be71-ac7450114cd9",
            "first_name"=>"Herbert",
            "last_name"=>"Garrison",
            "created_at"=>"2024-07-21T23:56:18.017Z",
            "updated_at"=>"2024-07-21T23:56:18.017Z"},
          {
            "id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
            "first_name"=>"Albus",
            "last_name"=>"Dumbledore",
            "created_at"=>"2024-07-21T23:56:18.050Z",
            "updated_at"=>"2024-07-21T23:56:18.050Z"}
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = Professor.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/professors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show professor') do
      response(200, 'successful') do
        example 'application/json', :professor, {
          "id"=>"39e52233-51c8-4f9a-b237-5c886edf43c5",
          "first_name"=>"Randy",
          "last_name"=>"Marsh",
          "created_at"=>"2024-07-21T23:56:17.845Z",
          "updated_at"=>"2024-07-21T23:56:17.845Z"
        }
        let(:id) { Professor.all.first.id }

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
