require 'rails_helper'

RSpec.describe Employees::DeleteService do
  subject { described_class.call(id: id) }

  describe '.call' do
    context 'when valid' do
      let!(:employee) { create(:employee) }
      let(:id) { employee.id }

      it 'delete a employee' do
        expect { subject }.to change(Employee, :count).by(-1)
      end
    end
  end
end
