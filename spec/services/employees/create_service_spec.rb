require 'rails_helper'

RSpec.describe Employees::CreateService do
  subject { described_class.call(name: name, email: email, picture: picture) }

  describe '.call' do
    context 'when valid' do
      let(:name) { "Murilo" }
      let(:email) { "murilo@email" }
      let(:picture) { nil }

      it 'creates a employee' do
        expect { subject }.to change(Employee, :count).by(1)
      end

      it 'returns a created employee' do
        result = subject

        expect(result[:employee].name).to eq(name)
      end
    end

    context 'when not valid' do
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
          { message: "can't be blank", path: [ "attributes", "email" ] }
        )
      end
    end
  end
end
