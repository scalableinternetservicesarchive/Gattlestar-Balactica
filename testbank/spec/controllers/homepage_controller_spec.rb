require 'rails_helper'

RSpec.describe HomepageController, :type => :controller do
  describe 'GET index' do
    it 'should return success' do 
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'should put the stuff in major_abr.yml into @department' do
      get :index

      DEPARTMENTS = YAML.load_file('config/major_abr.yml')

      expect(assigns(:department)).to eq(DEPARTMENTS)
    end
  end

  describe 'GET about' do
    it 'should return success' do
      get :about

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET contact' do
    it 'should return success' do
      get :contact

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
