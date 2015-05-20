require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET add_new_course' do
    it 'should redirect to sign in page if not logged in' do 
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'should return success if logged in' do
      sign_in user
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST create_course' do
    before(:each) do
      sign_in user
      request.env['HTTP_REFERER'] = add_new_course_path
    end

    it 'should redirect back if course is nil' do
      post :create, {}
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Please enter a valid department and course')
    end

    it 'should redirect back if department is nil' do
      post :create, {
        course: {
          department: nil,
          course_id: 1
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Please enter a valid department and course')
    end

    it 'should redirect back if department is empty' do
      post :create, {
        course: {
          department: '',
          course_id: 1
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Please enter a valid department and course')
    end

    it 'should redirect back if course id is nil' do
      post :create, {
        course: {
          department: 'Computer Science',
          course_id: nil 
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Please enter a valid department and course')
    end

    it 'should redirect back if course id is empty' do
      post :create, {
        course: {
          department: 'Computer Science',
          course_id: ''
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Please enter a valid department and course')
    end

    it 'should redirect back if course already exists' do
      @course = FactoryGirl.create(:course)
      @course.save

      post :create, {
        course: {
          department: @course.department,
          course_id: @course.course_id,
          professor_first_name: @course.professor_first_name,
          professor_last_name: @course.professor_last_name
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:alert]).to eq('Class already in database')

      @course.delete
    end

    it 'should properly create course' do
      post :create, {
        course: {
          department: 'Computer Science',
          course_id: '181',
          professor_first_name: 'Alexander',
          professor_last_name: 'Sherstov'
        }
      }
      expect(response).to redirect_to add_new_course_path
      expect(flash[:notice]).to eq('Successfully Created New Course')
    end
  end

  describe 'DELETE delete_course' do
    it 'should not delete course when not signed in' do
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '32')
      delete :delete, {
        department: 'Computer Science',
        course_id: '32'
      }
      expect(response).to redirect_to new_user_session_path
      expect(Course.all.length).to eq(1)

      Course.delete_all
    end

    it 'should not delete courses with the same department but with different course id' do
      sign_in user
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '181')
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '32')

      delete :delete, {
        department: 'Computer Science',
        course_id: '32'
      }

      expect(response).to redirect_to root_path
      expect(Course.all.length).to eq(1)
      expect(Course.first.course_id).to eq('181')

      Course.delete_all
    end

    it 'should not delete courses with the same course id but with different departments' do
      sign_in user
      FactoryGirl.create(:course, department: 'Computer Science', course_id: '181')
      FactoryGirl.create(:course, department: 'Biology', course_id: '181')

      delete :delete, {
        department: 'Computer Science',
        course_id: '181'
      }

      expect(response).to redirect_to root_path
      expect(Course.all.length).to eq(1)
      expect(Course.first.department).to eq('Biology')

      Course.delete_all
    end

    it 'should delete all courses with same course id and department regardless of professor' do
      sign_in user
      course1 = FactoryGirl.create(:course, department: 'Computer Science', course_id: '181')
      course2 = FactoryGirl.create(:course, department: 'Computer Science', course_id: '181')
      course3 = FactoryGirl.create(:course, department: 'Computer Science', course_id: '181')

      expect(course1.professor_first_name).not_to eq(course2.professor_first_name)
      expect(course2.professor_first_name).not_to eq(course3.professor_first_name)

      delete :delete, {
        department: 'Computer Science',
        course_id: '181'
      }

      expect(response).to redirect_to root_path
      expect(Course.all.length).to eq(0)
    end
  end

end
