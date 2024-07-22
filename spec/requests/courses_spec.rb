require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'courses', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/courses' do

    get('list courses') do
      response(200, 'successful') do
        example 'application/json', :courses, [
          {
            "id"=>"bcfbc77c-323b-45b2-9321-37bbdd45a434",
            "course_code"=>"SOHN101",
            "name"=>"Hard Knocks 101",
            "school_id"=>"d5169068-6adf-4163-a3ed-9adec9502a12",
            "faculty_id"=>"5b886a1c-9cdb-43b3-b4eb-05af6a96c6e4",
            "created_at"=>"2024-07-21T20:11:21.155Z",
            "updated_at"=>"2024-07-21T20:34:36.539Z"},
          {
            "id"=>"27ae8e85-f74c-48c2-bd10-13dd55291f6e",
            "course_code"=>"AIR101",
            "name"=>"Air Guitar Intro",
            "school_id"=>"e598af11-634c-4cc0-85ad-7aee9bc4ef4d",
            "faculty_id"=>"150fff19-8bf4-4a53-b13b-bf389c479246",
            "created_at"=>"2024-07-21T23:56:17.907Z",
            "updated_at"=>"2024-07-21T23:56:17.907Z"},
          {
            "id"=>"9c00b0ae-4710-4d5d-8c21-1f1bf8a2edad",
            "course_code"=>"KFC101",
            "name"=>"Chicken Basics",
            "school_id"=>"8ebcdc02-d0d1-4b6c-a1ff-546df0969ec3",
            "faculty_id"=>"4ccdd9d8-53fa-4a21-b76f-1a2256a631fb",
            "created_at"=>"2024-07-21T23:56:18.025Z",
            "updated_at"=>"2024-07-21T23:56:18.025Z"},
          {
            "id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
            "course_code"=>"SHH101",
            "name"=>"He Who Shall Not Be Named Intro",
            "school_id"=>"2b9087be-b623-4634-bf8c-e1fb0175c0dd",
            "faculty_id"=>"bae34083-2164-4978-94df-f25b0f2a1968",
            "created_at"=>"2024-07-21T23:56:18.059Z",
            "updated_at"=>"2024-07-21T23:56:18.059Z"}
          ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = Course.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show course') do
      response(200, 'successful') do
        example 'application/json', :course, {
          "id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "course_code"=>"SHH101",
          "name"=>"He Who Shall Not Be Named Intro",
          "school_id"=>"2b9087be-b623-4634-bf8c-e1fb0175c0dd",
          "faculty_id"=>"bae34083-2164-4978-94df-f25b0f2a1968",
          "created_at"=>"2024-07-21T23:56:18.059Z",
          "updated_at"=>"2024-07-21T23:56:18.059Z"
        }
        let(:id) { Course.all.first.id }

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
