require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'discussion_question_posts', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/discussion_question_posts/{id}/like' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('like discussion_question_post') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string },
          user_type: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.first.id }

        let(:user) do
          u = User.all.sample
          {
            user_id: u.id,
            user_type: u.type
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
          expect(data['like_count'].to_i).to eq(2)
        end
      end
    end
  end

  path '/discussion_question_posts/{id}/dislike' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('dislike discussion_question_post') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string },
          user_type: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.last.id }
        let(:user) do
          u = User.all.sample
          {
            user_id: u.id,
            user_type: u.type
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
          expect(data['like_count'].to_i).to eq(0)
        end
      end
    end
  end

  path '/discussion_question_posts' do

    get('list discussion_question_posts') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = DiscussionQuestionPost.all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end

    post('create discussion_question_post') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :discussion_question_post, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string },
          user_type: { type: :string },
          course_id: { type: :string },
          content: { type: :string },
          discussion_question_id: { type: :string },
          discussion_question_topic_id: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:discussion_question_post) do
          c = Course.all.first
          cu = CourseStudent.where(course_id: c.id).sample
          user_id = cu.user_id
          user_type = cu.user_type
          dq = c.discussion_questions.sample
          dqp = dq.discussion_question_posts.first
          {
            user_id: user_id,
            user_type: user_type,
            course_id: c.id,
            content: 'this is the worst post I have ever seen',
            discussion_question_id: dq.id,
            discussion_question_topic_id: dqp.id
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
          expect(data['id']).to_not eq(nil)
          expect(data['content']).to eq(discussion_question_post[:content])
        end
      end
    end
  end

  path '/discussion_question_posts/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show discussion_question_post') do
      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.first.id }

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

    patch('update discussion_question_post') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :discussion_question_post, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string },
        }
      }

      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.first.id }
        let(:discussion_question_post) do
          { content: 'This edit is the most amazing edit ever' }
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
          expect(data['content']).to eq(discussion_question_post[:content])
        end
      end
    end

    put('update discussion_question_post') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :discussion_question_post, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string },
        }
      }

      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.last.id }
        let(:discussion_question_post) do
          { content: 'This edit is the most amazing edit ever' }
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
          expect(data['content']).to eq(discussion_question_post[:content])
        end
      end
    end

    delete('delete discussion_question_post') do
      response(200, 'successful') do
        let(:id) { DiscussionQuestionPost.all.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['deleted_at']).to_not be(nil)
        end
      end
    end
  end

  path '/courses/{course_id}/discussion_questions/{discussion_question_id}/discussion_question_posts' do
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'
    parameter name: 'discussion_question_id', in: :path, type: :string, description: 'discussion_question_id'

    get('list discussion_question_posts') do
      response(200, 'successful') do
        let(:course_id) { Course.all.last.id }
        let(:discussion_question_id) do
          DiscussionQuestion.where(course_id: course_id).first.id
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          db_ids = DiscussionQuestionPost.where(course_id: course_id).all.map(&:id).sort
          expect(db_ids.count).to be > 0
          data = JSON.parse(response.body)
          res_ids = data.collect { |s| s['id'] }
          expect(db_ids).to eq(res_ids.sort)
        end
      end
    end
  end

  path '/courses/{course_id}/discussion_questions/{discussion_question_id}/discussion_question_posts/{id}' do
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'
    parameter name: 'discussion_question_id', in: :path, type: :string, description: 'discussion_question_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show discussion_question_post') do
      response(200, 'successful') do
        let(:course_id) { Course.all.first.id }
        let(:discussion_question_id) do
          DiscussionQuestion.where(course_id: course_id).first.id
        end
        let(:id) { DiscussionQuestionPost.where(discussion_question_id: discussion_question_id).first.id }

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
          expect(data['discussion_question_id']).to eq(discussion_question_id)
        end
      end
    end
  end
end
