require "rails_helper"

RSpec.describe "Home Requests", type: :request do
    
  it "GET home#index" do
    get "/"
    expect(response).to render_template(:index)
  end
  
end