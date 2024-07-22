require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'students', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/students' do

    get('list students') do
      response(200, 'successful') do
        example 'application/json', :students, [
          {
            "id"=>"c0a27d5b-37b6-45a7-9086-5ea0013ef6be",
            "first_name"=>"Bob",
            "last_name"=>"Derp",
            "created_at"=>"2024-07-21T19:53:50.010Z",
            "updated_at"=>"2024-07-21T19:53:50.010Z"},
          {
            "id"=>"d37e3674-c611-4388-862b-cd9f019d92d9",
            "first_name"=>"Stan",
            "last_name"=>"Marsh",
            "created_at"=>"2024-07-21T23:56:17.928Z",
            "updated_at"=>"2024-07-21T23:56:17.928Z"},
          {
            "id"=>"2a7ee8ed-a626-4e21-b4d6-f18518b6477b",
            "first_name"=>"Eric",
            "last_name"=>"Cartman",
            "created_at"=>"2024-07-21T23:56:18.029Z",
            "updated_at"=>"2024-07-21T23:56:18.029Z"},
          {
            "id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
            "first_name"=>"Harry",
            "last_name"=>"Potter",
            "created_at"=>"2024-07-21T23:56:18.063Z",
            "updated_at"=>"2024-07-21T23:56:18.063Z"}
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = Student.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/students/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show student') do
      response(200, 'successful') do
        example 'application/json', :student, {
          "id"=>"2a7ee8ed-a626-4e21-b4d6-f18518b6477b",
          "first_name"=>"Eric",
          "last_name"=>"Cartman",
          "created_at"=>"2024-07-21T23:56:18.029Z",
          "updated_at"=>"2024-07-21T23:56:18.029Z"
        }
        let(:id) { Student.all.first.id }

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
