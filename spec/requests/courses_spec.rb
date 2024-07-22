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
