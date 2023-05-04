# spec/controllers/urls_controller_spec.rb

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  before { allow(controller).to receive(:redirect_to).and_call_original }
  
  describe "GET #show" do
    let(:url) { create(:url) }

    it "increments visit_count and redirects to the original_url" do
        expect {
        get :show, params: { short_code: url.short_url }
        }.to change { url.reload.visit_count }.by(1)
        expect(response).to redirect_to(url.original_url)
    end

    it "returns a 404 status when the short URL is not found" do
      get :show, params: { short_code: "invalid" }
      expect(response.status).to eq(404)
    end
  end

  describe "POST #create" do
    let(:valid_url) { build(:url) }

    it "creates a new short URL" do
      expect {
        post :create, params: { url: { original_url: valid_url.original_url } }
      }.to change(Url, :count).by(1)
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)["short_code"]).to be_present
    end

    it "returns errors when unable to create the short URL" do
      post :create, params: { url: { original_url: "invalid-url" } }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["errors"]).to be_present
    end
  end
end


