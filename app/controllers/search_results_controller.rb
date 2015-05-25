class SearchResultsController < ApplicationController
  def typeahead_department
    q = params[:query]
    puts render json: Course.select(:department).distinct.where('department LIKE ?', "#{q}%")
  end

  def typeahead_course_id
    q = params[:query]
    puts render json: Course.select(:course_id).distinct.where('course_id LIKE ?', "#{q}%")
  end


  def search
    @department = params[:dpm_name]
    if @department == nil || @department.empty?
      return redirect_to root_path, flash: {alert: 'Please Enter A Valid Department Name'}
    end

    @course = params[:course_name]
    if @course == nil || @course.empty?
      return redirect_to search_dpm_path(@department)
    else
      return redirect_to search_course_path(@department, @course)
    end
  end

  def show_department
    @department = params[:dpm]
    @all_courses = Course.search_by_dept(@department)

    if @all_courses == nil || @all_courses.empty?
      return redirect_to root_path, flash: {alert: 'There are no courses that have this department!'}
    end

    @course_ids = @all_courses.uniq.pluck(:course_id)
  end

  def show_course
    @department = params[:dpm].titleize
    @course_id = params[:course]
    @query_results = Course.search_by_course(@department, @course_id)
  end

  def show_specific_course
    @specific_course_id = params[:course_id]
    @course = Course.find(@specific_course_id)
    @documents = Document.where(course_id: @specific_course_id)

    begin
      respond_to do |format|
        format.js
      end
    rescue
      redirect_to error_403_path
    end
  end

  def report_spam
    @doc = Document.find(params[:document_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def document_spam
    @desc = params[:description]
    @document_id = params[:document_id]
    @reporter = params[:reporter]
    SpamMailer.spam_email(@desc, @document_id, @reporter).deliver

    render :nothing => true
  end

end
