require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to have_one_attached(:picture) }
    it { is_expected.to belong_to(:company) }
  end
end
