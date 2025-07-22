require "rails_helper"

RSpec.describe Mutations::Employees::CreateEmployee, type: :request do
  describe '.resolve' do
    let!(:employee) { create(:employee) }
    let(:query) {
      <<-GRAPHQL
        mutation {
          deleteEmployee(input: { id: "#{id}"}) {
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
      let(:id) { employee.id }

      it 'deletes a employee' do
        expect { subject }.to change(Employee, :count).by(-1)
      end

      it 'returns deleted employee info' do
        subject
        json = JSON.parse(response.body)
        data = json["data"]["deleteEmployee"]["employee"]

        expect(data["name"]).to eq(employee.name)
        expect(data["email"]).to eq(employee.email)
        expect(data["company"]["id"]).to eq(employee.company.id.to_s)
        expect(data["company"]["name"]).to eq(employee.company.name)
      end
    end
  end
end
