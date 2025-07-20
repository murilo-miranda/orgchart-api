require 'rails_helper'

RSpec.describe Companies::CreateService do
  subject { described_class.call(name: company_name) }

  describe '.call' do
    context 'when valid' do
      let(:company_name) { "Uol" }

      it 'creates a company' do
        expect { subject }.to change(Company, :count).by(1)
      end

      it 'returns a created company' do
        result = subject

        expect(result[:company].name).to eq("Uol")
      end
    end

    context 'when not valid' do
      let(:company_name) { "" }

      it 'do not creates a company' do
        expect { subject }.not_to change(Company, :count)
      end

      it 'returns errors message' do
        result = subject

        expect(result[:errors].each { |error| error[:message] }).to eq([ { message: "can't be blank", path: [ "attributes", "name" ] } ])
      end
    end
  end
end
