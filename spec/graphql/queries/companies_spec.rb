require 'rails_helper'

RSpec.describe "Queries::Companies", type: :request do
  let!(:company1) { create(:company) }
  let!(:company2) { create(:company) }
  let(:query) {
    <<-GRAPHQL
    {
      companies {
        id
        name
      }
    }
    GRAPHQL
  }

  subject { post "/graphql", params: { query: query } }

  it 'returns all companies' do
    subject
    json = JSON.parse(response.body)
    data = json["data"]["companies"]
    expect(data.size).to eq 2
  end
end
