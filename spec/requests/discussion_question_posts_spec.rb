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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>nil,
          "user_type"=>"Student"
        }

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
          expect(data['like_count'].to_i).to eq(1)
        end
      end
    end
  end

  path '/discussion_question_posts/{id}/cancel_rating' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('cancel rating on discussion_question_post') do
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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>5,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>nil,
          "user_type"=>"Student"
        }
        let(:user) do
          u = User.all.sample
          {
            user_id: u.id,
            user_type: u.type
          }
        end
        let(:id) do
          dqp = DiscussionQuestionPost.all.last
          r = DiscussionQuestionPostRating.new(
            discussion_question_post: dqp,
            user_id: user[:user_id],
            user_type: user[:user_type],
            liked: false
          )

          r.save!
          dqp.update(like_count: 5)
          dqp.id
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
          expect(data['like_count'].to_i).to eq(6)
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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>-1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>nil,
          "user_type"=>"Student"
        }
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
          expect(data['like_count'].to_i).to eq(-1)
        end
      end
    end
  end

  path '/discussion_question_posts?hierarchy={hierarchy}' do
    parameter name: 'hierarchy', in: :path, type: :string, description: 'hierarchy'
    let(:hierarchy) { 'tree' }

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
          data = JSON.parse(response.body)
          expect(data.class).to eq(Hash)
        end
      end
    end
  end

  path '/discussion_question_posts?hierarchy={hierarchy}' do
    parameter name: 'hierarchy', in: :path, type: :string, description: 'hierarchy'
    let(:hierarchy) { 'flat' }

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
  end

  path '/discussion_question_posts' do
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
        example 'application/json', :discussion_question_post_no_parent, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>nil,
          "user_type"=>"Student"
        }

        example 'application/json', :discussion_question_post_with_parent, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }

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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }
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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }
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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }
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
        example 'application/json', :discussion_question_post_deleted_at, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>"Sun, 21 Jul 2024 23:59:18.080696000 UTC +00:00",
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }
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
        example 'application/json', :discussion_question_post, {
          "id"=>"48914fd6-5024-4525-a8b2-9e7d4d108d81",
          "course_id"=>"0c8afa68-8cd3-4406-9d8f-6708cedf8f01",
          "user_id"=>"4e803bd5-b0c5-4b95-8f13-4d393842e21b",
          "content"=>
          "Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?",
          "posted_at"=>"Sun, 21 Jul 2024 23:56:18.078392000 UTC +00:00",
          "archived_at"=>nil,
          "deleted_at"=>nil,
          "edited_at"=>nil,
          "state"=>nil,
          "like_count"=>1,
          "discussion_question_id"=>"731b457a-245c-4878-83da-8ca15b812714",
          "created_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "updated_at"=>"Sun, 21 Jul 2024 23:56:18.080696000 UTC +00:00",
          "discussion_question_post_id"=>"587b457a-245a-4878-83da-8ca15b812714",
          "user_type"=>"Student"
        }
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
