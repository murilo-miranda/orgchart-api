require "rails_helper"

RSpec.describe Mutations::Companies::CreateCompany, type: :request do
  describe '.resolve' do
    let(:query) {
      <<-GRAPHQL
        mutation {
          createCompany(input: {name: "#{company_name}"}) {
            company {
              id
              name
            }
            errors {
              message
              path
            }
          }
        }
      GRAPHQL
    }

    subject { post "/graphql", params: { query: query } }

    context 'when valid' do
      let(:company_name) { "Uol" }

      it 'creates a company' do
        expect { subject }.to change(Company, :count).by(1)
      end

      it 'returns a created company' do
        subject
        json = JSON.parse(response.body)
        data = json["data"]["createCompany"]["company"]

        expect(data["name"]).to eq("Uol")
      end
    end

    context 'when not valid' do
      let(:company_name) { "" }

      it 'do not creates a company' do
        expect { subject }.not_to change(Company, :count)
      end

      it 'returns errors message' do
        subject
        json = JSON.parse(response.body)
        data = json["data"]["createCompany"]["errors"]

        expect(data[0]["message"]).to include("can't be blank")
      end
    end
  end
end
