require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'faculties', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/faculties' do

    get('list faculties') do
      response(200, 'successful') do
        example 'application/json', :faculties, [
          {
            "id"=>"5b886a1c-9cdb-43b3-b4eb-05af6a96c6e4",
            "name"=>"School Of Hard Knocks",
            "school_id"=>"d5169068-6adf-4163-a3ed-9adec9502a12",
            "created_at"=>"2024-07-21T20:02:29.007Z",
            "updated_at"=>"2024-07-21T20:02:29.007Z"},
          {
            "id"=>"150fff19-8bf4-4a53-b13b-bf389c479246",
            "name"=>"School Of Air Guitar",
            "school_id"=>"e598af11-634c-4cc0-85ad-7aee9bc4ef4d",
            "created_at"=>"2024-07-21T23:56:17.831Z",
            "updated_at"=>"2024-07-21T23:56:17.831Z"},
          {
            "id"=>"4ccdd9d8-53fa-4a21-b76f-1a2256a631fb",
            "name"=>"Faculty Of KFC",
            "school_id"=>"8ebcdc02-d0d1-4b6c-a1ff-546df0969ec3",
            "created_at"=>"2024-07-21T23:56:18.015Z",
            "updated_at"=>"2024-07-21T23:56:18.015Z"},
          {
            "id"=>"bae34083-2164-4978-94df-f25b0f2a1968",
            "name"=>"School of Voldemort",
            "school_id"=>"2b9087be-b623-4634-bf8c-e1fb0175c0dd",
            "created_at"=>"2024-07-21T23:56:18.049Z",
            "updated_at"=>"2024-07-21T23:56:18.049Z"}
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = Faculty.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/faculties/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show faculty') do
      response(200, 'successful') do
        example 'application/json', :faculty, {
          "id"=>"4ccdd9d8-53fa-4a21-b76f-1a2256a631fb",
          "name"=>"Faculty Of KFC",
          "school_id"=>"8ebcdc02-d0d1-4b6c-a1ff-546df0969ec3",
          "created_at"=>"2024-07-21T23:56:18.015Z",
          "updated_at"=>"2024-07-21T23:56:18.015Z"
        }

        let(:id) { Faculty.all.first.id }

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
