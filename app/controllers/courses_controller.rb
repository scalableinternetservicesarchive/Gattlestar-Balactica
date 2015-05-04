class CoursesController < ApplicationController
  def new
  	@new_course = Course.new
  end

  def create
  	@dep = params[:course][:department]
  	@course_id = params[:course][:course_id]
  	@prof_first = params[:course][:professor_first_name]
  	@prof_last = params[:course][:professor_last_name]
  	if @dep == nil || @dep.empty? || @course_id == nil || @course_id.empty?
  		redirect_to :back, flash: {alert: 'Please enter a valid department and course'}
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

  def remove
  	@departments = Course.distinct.pluck(:department)
  	@courses_ids = Course.distinct.pluck(:course_id)
  	@professor_last_names = Course.distinct.pluck(:professor_last_name)
  	@professor_first_names = Course.distinct.pluck(:professor_first_name)

  end

  def delete
  	@delete_course
  	Course.delete(params[:course])
    redirect_to admin_service_path
  end

  def course_params
    params.require(:course).permit(:department, :course_id, :professor_last_name, :professor_first_name)
  end
end
