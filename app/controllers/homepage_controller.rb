class HomepageController < ApplicationController
  def index 
    @course_hash= Course.find_all_courses

    ExampleMailer.sample_email.deliver

    current_page = params[:page].to_i
    if current_page == 0
      current_page = 1
    end
    per_page = params[:per_page] || 20
    total = params[:total_entries] || @course_hash.length

    @paginated_courses = WillPaginate::Collection.create(current_page, per_page, total) do |pager|
      start = (current_page-1)*per_page # assuming current_page is 1 based.
      pager.replace(@course_hash.keys[start, per_page])
    end
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
