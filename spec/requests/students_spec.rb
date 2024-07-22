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
          expect(data['id']).to eq(id)
        end
      end
    end
  end
end
