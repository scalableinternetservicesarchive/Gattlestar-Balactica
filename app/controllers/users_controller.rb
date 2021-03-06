class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @courses_string = @user.courses_taken.split(",")
  end

  def add_course_taken
  end

  def check_duplicate(dept, crse)
    @courses_string = current_user.courses_taken.split(",")

    @courses_string.each do |course|
      course_id_start = course.rindex(' ')
      if course_id_start != nil 
        @dpm_name = course.slice(0, course_id_start)
        @course_id = course[course_id_start + 1..-1]
        if @dpm_name == dept && @course_id == crse
          return true
        end
      end
    end
    return false
  end

  def add_course_taken_post
    @department = params[:dep_name]
    @course = params[:crse_name]

    if @department == nil || @department.empty?
       return redirect_to :back, flash: {alert: 'Please Enter A Valid Department Name'}
    end

    if @course == nil || @course.empty?
      return redirect_to :back, flash: {alert: 'Please Enter A Valid Course Name'}
    end

    #check if class in database
    @query_results = Course.search_by_course(@department, @course)
    if @query_results == nil || @query_results.empty?
      return redirect_to :back, flash: {alert: 'Please Enter a Valid Course Name'}
    end

    #check if already added class
    if check_duplicate(@department, @course)
      return redirect_to :back, flash: {alert: 'Class Already Added'}
    else
      @courses_taken = User.find(current_user.id).courses_taken
      if current_user.update_attribute("courses_taken", @courses_taken + ",#{@department} #{@course}")
        return redirect_to current_user, :notice  => "Successfully Added Course to Courses Taken"
      end
    end
  end

  def admin_service
  end

  def remove_course_taken
    @department = params[:department]
    @course_id = params[:course_id]

    @courses_string = current_user.courses_taken.split(",")

    @courses_string.each do |course|
      course_id_start = course.rindex(' ')
      if course_id_start != nil 
        @dpm_string_name = course.slice(0, course_id_start)
        @course_string_id = course[course_id_start + 1..-1]
        if @dpm_string_name == @department && @course_string_id == @course_id
          @courses_string.delete(@department + " " + @course_id)
        end
      end
    end
    if current_user.update_attribute("courses_taken", @courses_string.join(","))
        return redirect_to current_user, :notice  => "Successfully Removed Course to Courses Taken"
    end
  end
end
