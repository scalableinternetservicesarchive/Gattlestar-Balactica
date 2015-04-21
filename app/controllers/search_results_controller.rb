class SearchResultsController < ApplicationController
	def search
		@department = params[:dpm_name]
		if @department == nil || @department.empty?
			return redirect_to root_path, flash: {error: 'Please Enter A Valid Department Name'}
		end

		@course = params[:course_name]
		if @course == nil || @course.empty?
			return redirect_to search_dpm_path(@department)
		else
			return redirect_to search_course_path(@department, @course)
		end
	end
	
	def show_department
		@department = params[:dpm].titleize
		@query_results = Course.search_by_dept(@department)
		@course_ids = @query_results.uniq.pluck(:course_id)
	end

	def show_course
		@department = params[:dpm].titleize
		@course_id = params[:course]
		@query_results = Course.search_by_course(@department, @course_id)
	end
end
