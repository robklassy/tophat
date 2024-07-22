require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'discussion_questions', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/discussion_questions' do

    get('list discussion_questions') do
      response(200, 'successful') do
        example 'application/json', :discussion_questions, [
          {
            "id"=>"6feaeacc-0627-4b1e-bcc8-e829d6005a79",
            "course_id"=>"27ae8e85-f74c-48c2-bd10-13dd55291f6e",
            "user_id"=>"39e52233-51c8-4f9a-b237-5c886edf43c5",
            "title"=>"How is the weather",
            "content"=>"Hey everyone, since we are all over the world, let's talk about how the local weather",
            "posted_at"=>"2024-07-21T23:56:17.969Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:17.989Z",
            "updated_at"=>"2024-07-21T23:56:17.989Z",
            "user_type"=>"Professor"},
          {
            "id"=>"99c99c2c-f063-4de7-9218-4adc3eaa0ef0",
            "course_id"=>"9c00b0ae-4710-4d5d-8c21-1f1bf8a2edad",
            "user_id"=>"b8b7fb53-6c42-400d-be71-ac7450114cd9",
            "title"=>"Chicken/sauce ratio questions here",
            "content"=>"This is the discussion to help each other with the chicken/sauce ratio calculations questions",
            "posted_at"=>"2024-07-21T23:56:18.038Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:18.040Z",
            "updated_at"=>"2024-07-21T23:56:18.040Z",
            "user_type"=>"Professor"},
          {
            "id"=>"731b457a-245c-4878-83da-8ca15b812714",
            "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
            "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
            "title"=>"elder wand questions",
            "content"=>
            "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
            "posted_at"=>"2024-07-21T23:56:18.074Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:18.076Z",
            "updated_at"=>"2024-07-21T23:56:18.076Z",
            "user_type"=>"Professor"}
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = DiscussionQuestion.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end

    post('create discussion_question') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :discussion_question, in: :body, schema: {
        type: :object,
        properties: {
          course_id: { type: :string },
          user_id: { type: :string },
          user_type: { type: :string },
          title: { type: :string },
          content: { type: :string }
        }
      }

      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }

        let(:discussion_question) do
          course_id = Course.all.first.id
          user = (CourseStudent.where(course_id: course_id).all + CourseProfessor.where(course_id: course_id).all).sample

          { course_id: course_id,
            user_id: user.user_id,
            user_type: user.user_type,
            title: 'Discussion for examp prep!!',
            content: "There are three midterms coming up, so let's collaborate here, post any questions you have or topics you are unclear about"
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to_not be(nil)
          expect(data['title']).to eq(discussion_question[:title])
          expect(data['content']).to eq(discussion_question[:content])
        end
      end
    end
  end

  path '/discussion_questions/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show discussion_question') do
      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }
        let(:id) { DiscussionQuestion.all.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
        end
      end
    end

    patch('update discussion_question') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :discussion_question, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        }
      }

      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }
        let(:id) { DiscussionQuestion.all.last.id }
        let(:discussion_question) do
          {
            title: 'This is a better title than whatever was there before',
            content: 'This content is also way better than whatever was there before'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['title']).to eq(discussion_question[:title])
          expect(data['content']).to eq(discussion_question[:content])
        end
      end
    end

    put('update discussion_question') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :discussion_question, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        }
      }

      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }
        let(:id) { DiscussionQuestion.all.first.id }
        let(:discussion_question) do
          {
            title: 'This is a better title than whatever was there before',
            content: 'This content is also way better than whatever was there before'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['title']).to eq(discussion_question[:title])
          expect(data['content']).to eq(discussion_question[:content])
        end
      end
    end

    delete('delete discussion_question') do
      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>"2024-07-21T23:59:18.076Z",
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }
        let(:id) { DiscussionQuestion.all.first.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['deleted_at']).to_not be(nil)
        end
      end
    end
  end

  path '/courses/{course_id}/discussion_questions' do
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('list discussion_questions') do
      response(200, 'successful') do
        example 'application/json', :discussion_questions, [
          {
            "id"=>"6feaeacc-0627-4b1e-bcc8-e829d6005a79",
            "course_id"=>"27ae8e85-f74c-48c2-bd10-13dd55291f6e",
            "user_id"=>"39e52233-51c8-4f9a-b237-5c886edf43c5",
            "title"=>"How is the weather",
            "content"=>"Hey everyone, since we are all over the world, let's talk about how the local weather",
            "posted_at"=>"2024-07-21T23:56:17.969Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:17.989Z",
            "updated_at"=>"2024-07-21T23:56:17.989Z",
            "user_type"=>"Professor"},
          {
            "id"=>"99c99c2c-f063-4de7-9218-4adc3eaa0ef0",
            "course_id"=>"27ae8e85-f74c-48c2-bd10-13dd55291f6e",
            "user_id"=>"b8b7fb53-6c42-400d-be71-ac7450114cd9",
            "title"=>"Chicken/sauce ratio questions here",
            "content"=>"This is the discussion to help each other with the chicken/sauce ratio calculations questions",
            "posted_at"=>"2024-07-21T23:56:18.038Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:18.040Z",
            "updated_at"=>"2024-07-21T23:56:18.040Z",
            "user_type"=>"Professor"},
          {
            "id"=>"731b457a-245c-4878-83da-8ca15b812714",
            "course_id"=>"27ae8e85-f74c-48c2-bd10-13dd55291f6e",
            "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
            "title"=>"elder wand questions",
            "content"=>
            "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
            "posted_at"=>"2024-07-21T23:56:18.074Z",
            "archived_at"=>nil,
            "deleted_at"=>nil,
            "edited_at"=>nil,
            "state"=>"posted",
            "created_at"=>"2024-07-21T23:56:18.076Z",
            "updated_at"=>"2024-07-21T23:56:18.076Z",
            "user_type"=>"Professor"}
        ]
        let(:course_id) { Course.all.first.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = DiscussionQuestion.where(course_id: course_id).all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/courses/{course_id}/discussion_questions/{id}' do
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show discussion_question') do
      response(200, 'successful') do
        example 'application/json', :discussion_question, {
          "id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"2cb09736-556c-42c3-b69c-8b5312ae9218",
          "title"=>"elder wand questions",
          "content"=>
          "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
          "posted_at"=>"2024-07-21T23:56:18.074Z",
          "archived_at"=>nil,
          "deleted_at"=>"2024-07-21T23:59:18.076Z",
          "edited_at"=>nil,
          "state"=>"posted",
          "created_at"=>"2024-07-21T23:56:18.076Z",
          "updated_at"=>"2024-07-21T23:56:18.076Z",
          "user_type"=>"Professor"
        }
        let(:course_id) { Course.all.first.id }
        let(:id) { DiscussionQuestion.where(course_id: course_id).first.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['course_id']).to eq(course_id)
        end
      end
    end
  end
end
