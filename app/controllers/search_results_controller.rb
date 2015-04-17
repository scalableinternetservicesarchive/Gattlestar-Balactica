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
		Document.initialize(params[:dpm_name])
	end

	def show_course
	end
end
