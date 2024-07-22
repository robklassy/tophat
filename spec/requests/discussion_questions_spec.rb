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
