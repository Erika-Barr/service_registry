require 'acceptance_helper'

resource "Service Registry" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  let(:sr) { FactoryBot.create(:service_registry) }
  it 'test' do
    expect(sr).not_to eq(nil)
  end
end
