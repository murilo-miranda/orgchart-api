require 'rails_helper'

RSpec.describe "Queries::Companies", type: :request do
  let!(:company1) { create(:company) }
  let!(:company2) { create(:company) }

  subject { post "/graphql", params: { query: query } }

  context 'when query companies' do
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

    it 'returns all companies' do
      subject
      json = JSON.parse(response.body)
      data = json["data"]["companies"]
      expect(data.size).to eq 2
      expect(data.map { |company| company["name"] }).to contain_exactly(company1.name, company2.name)
    end
  end

  context 'when query a company' do
    let(:query) {
      <<-GRAPHQL
      {
        company(id: "#{id}") {
          id
          name
        }
      }
      GRAPHQL
    }

    context 'when resource exists' do
      let(:id) { company2.id }

      it 'returns company' do
        subject
        json = JSON.parse(response.body)
        data = json["data"]["company"]
        expect(data["name"]).to eq company2.name
      end
    end

    context 'when resource does not exist' do
      let(:id) { 3 }

      it 'returns errors message' do
        subject
        json = JSON.parse(response.body)
        data = json["errors"][0]
        expect(data["message"]).to eq "Couldn't find Company with 'id'=#{id}"
      end
    end
  end
end
