class UsersController < ApplicationController
  #before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @courses_string = @user.courses_taken.split(",")

    @courses_string.each do |course|
      course_id_start = course.rindex(' ')
      if course_id_start != nil 
        @dpm_name = course.slice(0, course_id_start)
        @course_id = course[course_id_start + 1..-1]
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def add_course
  end

  def add_course_post
     @department = params[:dep_name]
    if @department == nil || @department.empty?
       return redirect_to root_path, flash: {alert: 'Please Enter A Valid Department Name'}
    end

    @course = params[:crse_name]
    if @course == nil || @course.empty?
      return redirect_to root_path, flash: {alert: 'Please Enter A Valid Course Name'}
    else
      @courses_taken = User.find(current_user.id).courses_taken
      if current_user.update_attribute("courses_taken", @courses_taken + ", #{@department} #{@course}")
           redirect_to current_user, :notice  => "Successfully Added Course"
      else
      end
    end
  end
end
