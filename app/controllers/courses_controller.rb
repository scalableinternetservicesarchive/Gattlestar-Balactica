class CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to root_path unless current_user && current_user.admin?
  end

  def new
    @new_course = Course.new
  end

  def create
    @course = params[:course]
    if @course == nil 
      return redirect_to :back, flash: {alert: 'Please enter a valid department and course'}
    end

    @dep = @course[:department]
    @course_id = @course[:course_id]
    @prof_first = @course[:professor_first_name]
    @prof_last = @course[:professor_last_name]

    if @dep == nil || @dep.empty? || @course_id == nil || @course_id.empty?
      return redirect_to :back, flash: {alert: 'Please enter a valid department and course'}
    end

    #check if class in database
    @query_results = Course.search_by_course_and_professor(@dep, @course_id, @prof_last, @prof_first)
    if @query_results != nil && !@query_results.empty?
      return redirect_to :back, flash: {alert: 'Class already in database'}
    end

    @new_course = Course.new(course_params)

    if @new_course.save
      return redirect_to :back, :notice  => "Successfully Created New Course"
    else
      if @new_course.errors.any? 
        puts @doc.errors.full_messages
      end
    end
    return redirect_to admin_service_path, flash: {alert: 'Error occured when creating course'}
  end

  def delete
  	Course.where(:department => params[:department], :course_id => params[:course_id]).destroy_all
    redirect_to root_path
  end

  def course_params
    params.require(:course).permit(:department, :course_id, :professor_last_name, :professor_first_name)
  end
end
