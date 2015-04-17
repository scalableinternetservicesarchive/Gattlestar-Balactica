require 'rails_helper'

RSpec.describe SearchResultsController, :type => :controller do
  describe 'POST search' do 
    it 'should redirect to root_path if department parameter is nil' do 
      post :search

      expect(response).to redirect_to :root
    end

    it 'should redirect to root_path if department parameter is empty' do 
      post :search, {
        :dpm_name => ''
      }

      expect(response).to redirect_to :root
    end

    it 'should redirect to show_department path if course parameter is nil' do
      post :search, {
        :dpm_name => 'Department'
      }

      expect(response).to redirect_to search_dpm_path(:dpm => 'Department')
    end

    it 'should redirect to show_course path if department and course are not empty' do
      post :search, {
        :dpm_name => 'Department',
        :course_name => 'Course'
      }

      expect(response).to redirect_to search_course_path(:dpm => 'Department', :course => 'Course')
    end
  end

  describe 'GET show_department' do
    it 'should return success' do
      # sample route params, change when page is implemented
      route_params = {
        :dpm => 'Department'
      }

      get :show_department, route_params

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET show_course' do
    it 'should return success' do
      # sample route params, change when page is implemented
      route_params = {
        :dpm => 'Department',
        :course => 'Course'
      }

      get :show_course, route_params

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
