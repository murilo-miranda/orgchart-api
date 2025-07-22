require 'rails_helper'

RSpec.describe Employees::CreateService do
  subject { described_class.call(company_id: company_id, name: name, email: email, picture: picture) }
  let!(:company) { create(:company) }

  describe '.call' do
    context 'when valid' do
      let(:company_id) { company.id }
      let(:name) { "Murilo" }
      let(:email) { "murilo@email" }
      let(:picture) { nil }

      it 'creates a employee in a company' do
        expect { subject }.to change(Employee, :count).by(1)
        expect(Employee.last.company.id).to eq(company.id)
        expect(Employee.last.company.name).to eq(company.name)
      end

      it 'returns a created employee' do
        result = subject

        expect(result[:employee].name).to eq(name)
      end
    end

    context 'when not valid' do
      let(:company_id) { "" }
      let(:name) { "" }
      let(:email) { "" }
      let(:picture) { "" }

      it 'do not creates a employee' do
        expect { subject }.not_to change(Employee, :count)
      end

      it 'returns errors message' do
        result = subject

        expect(result[:errors]).to include(
          { message: "can't be blank", path: [ "attributes", "name" ] },
          { message: "can't be blank", path: [ "attributes", "email" ] },
          { message: "must exist", path: [ "attributes", "company" ] }
        )
      end
    end
  end
end
