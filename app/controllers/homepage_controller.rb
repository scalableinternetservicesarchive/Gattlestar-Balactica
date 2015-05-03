class HomepageController < ApplicationController
	def index 
		@course_hash= Course.find_all_courses
	end

  def log_in
  end

  def sign_up
  end

  def about
  end

  def contact
  end

  def search_test
  end
end
