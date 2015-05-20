require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let(:user) { FactoryGirl.create(:user, courses_taken: 'Computer Science 181,Physics 1C,Math 32A') }

  describe 'GET show' do
    it 'should redirect to sign in page if not logged in' do
      get :show, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'should set instance variables' do
      sign_in user
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
      expect(assigns(:courses_string)).to eq(['Computer Science 181', 'Physics 1C', 'Math 32A'])
    end
  end

  describe 'GET add_course_taken' do
    it 'should redirect to sign in page if not logged in' do
      get :add_course_taken
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'should return success if logged in' do
      sign_in user
      get :add_course_taken
      expect(response).to be_success
    end
  end

  describe 'POST add_course_taken_post' do
    let(:user) { FactoryGirl.create(:user, courses_taken: 'Math 32,Computer Science 180') }
    before(:each) do
      sign_in user
      request.env['HTTP_REFERER'] = add_course_taken_path
    end

    it 'should redirect back if department is nil' do
      post :add_course_taken_post, {
        dep_name: nil,
        crse_name: '32'
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Please Enter A Valid Department Name')
    end

    it 'should redirect back if department is empty' do
      post :add_course_taken_post, {
        dep_name: '',
        crse_name: '32'
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Please Enter A Valid Department Name')
    end

    it 'should redirect back if course is nil' do
      post :add_course_taken_post, {
        dep_name: 'Computer Science',
        crse_name: nil
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Please Enter A Valid Course Name')
    end

    it 'should redirect back if course is empty' do
      post :add_course_taken_post, {
        dep_name: 'Computer Science',
        crse_name: ''
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Please Enter A Valid Course Name')
    end

    it 'should redirect back if course does not exist' do
      post :add_course_taken_post, {
        dep_name: 'Computer Science',
        crse_name: '233'
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Please Enter a Valid Course Name')
    end

    it 'should redirect back if course was already added' do
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '180')
      post :add_course_taken_post, {
        dep_name: 'Computer Science',
        crse_name: '180'
      }
      expect(response).to redirect_to(add_course_taken_path)
      expect(flash[:alert]).to eq('Class Already Added')
    end

    it 'should successfully add couse' do
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '33')
      post  :add_course_taken_post, {
        dep_name: 'Computer Science',
        crse_name: '33'
      }
      expect(response).to redirect_to(user_path(id: user.id))
      expect(flash[:notice]).to eq('Successfully Added Course to Courses Taken')
    end
  end

  describe 'DELETE remove_course_taken' do
    it 'should remove course from course string' do
      user = FactoryGirl.create(:user, courses_taken: 'Computer Science 32,Computer Science 181,Biology 181')
      sign_in user
      delete :remove_course_taken, {
        department: 'Computer Science',
        course_id: '181'
      }
      user = User.find(user.id)
      expect(user.courses_taken.split(',')).to eq(['Computer Science 32', 'Biology 181'])
      User.delete_all
    end
  end

end
