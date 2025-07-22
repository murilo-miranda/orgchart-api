require "rails_helper"

RSpec.describe Mutations::Employees::CreateEmployee, type: :request do
  describe '.resolve' do
    let!(:company) { create(:company) }
    let(:query) {
      <<-GRAPHQL
        mutation {
          createEmployee(input: { companyId: "#{company_id}", name: "#{name}", email: "#{email}"}) {
            employee {
              id
              name
              email
              company {
                id
                name
              }
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
      let(:name) { "Murilo" }
      let(:email) { "murilo@email.com" }
      let(:company_id) { company.id }

      it 'creates a employee' do
        expect { subject }.to change(Employee, :count).by(1)
      end

      it 'returns a created employee' do
        subject
        json = JSON.parse(response.body)
        data = json["data"]["createEmployee"]["employee"]

        expect(data["name"]).to eq("Murilo")
        expect(data["email"]).to eq("murilo@email.com")
        expect(data["company"]["id"]).to eq(company.id.to_s)
        expect(data["company"]["name"]).to eq(company.name)
      end
    end

    context 'when not valid' do
      let(:name) { "" }
      let(:email) { "" }
      let(:company_id) { "" }

      it 'do not creates a employee' do
        expect { subject }.not_to change(Employee, :count)
      end

      it 'returns errors message' do
        subject
        json = JSON.parse(response.body)
        errors = json["data"]["createEmployee"]["errors"]

        expect(errors).to include(
          { "message" => "can't be blank", "path" => [ "attributes", "name" ] },
          { "message" => "can't be blank", "path" => [ "attributes", "email" ] },
          { "message" => "must exist", "path" => [ "attributes", "company" ] }
        )
      end
    end
  end
end
