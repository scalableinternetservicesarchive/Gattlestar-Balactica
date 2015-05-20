class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @my_documents = Document.where(uploader_id: current_user.id)
    @courses = @my_documents.map do |document| 
      Course.find(document.course_id)
    end
    puts @courses
  end

  def preview
    @doc = Document.find(params[:document_id])
    if @doc == nil 
      return redirect_to root_path, flash: {alert: 'Document does not exist'}
    end
    @has_thumbnail = File.exists?(@doc.document.thumb.current_path)
    @can_download = user_signed_in? && (current_user.credits > 0 || @doc.uploader_id.to_i == current_user.id)
  end

  def view
    @doc = Document.find(params[:document_id])
    if @doc == nil 
      return redirect_to root_path, flash: {alert: 'Document does not exist'}
    end
    if @doc.uploader_id.to_i != current_user.id
      @credits = User.find(current_user.id).credits
      if @credits == 0
        return redirect_to root_path, flash: {alert: 'Not enough credits'}
      end
      current_user.update_attribute("credits", @credits - 1) 
    end
    return redirect_to @doc.document.url
  end

  def new
    @course_id = params[:course_id]
    if @course_id == nil || @course_id.empty?
      return redirect_to root_path, flash: {alert: 'You need to specify a course'}
    else
      @quarters = [
        ['Fall', 'Fall'],
        ['Winter', 'Winter'],
        ['Spring', 'Spring'],
        ['Summer', 'Summer']
      ]

      @years = []
      (Time.now.year).downto(1960).each do |year|
        @years.push([year, year])
      end

      @document_type = [
        ['Midterm', 'Midterm'],
        ['Final', 'Final'],
        ['Homework', 'Homework'],
        ['Other', 'Other']
      ]
      @doc = Document.new
    end
  end

  def create
    @docs_uploaded_today = User.find(current_user.id).docs_uploaded_today
    if @docs_uploaded_today >= 3
      return redirect_to :back, flash: {alert: 'You can only upload up to 3 documents a day'}
    end
    @course_id = params[:course_id]
    if @course_id == nil || @course_id.empty?
      return redirect_to root_path, flash: {alert: 'You need to specify a course'}
    else
      @description = params[:document][:description]
      if @description == nil || @description.empty?
        return redirect_to :back, flash: {alert: 'Description cannot be empty'}
      end
      @doc = Document.new(document_params)
      @doc.uploader_id = current_user.id
      @doc.course_id = @course_id
      if @doc.save 
        @credits = User.find(current_user.id).credits
        current_user.update_attribute("credits", @credits + 1) 
        current_user.update_attribute("docs_uploaded_today", @docs_uploaded_today + 1) 
        return redirect_to documents_path
      else
        if @doc.errors.any? 
          puts @doc.errors.full_messages
        end
        return redirect_to root_path, flash: {alert: 'Error occured when uploading document'}
      end
    end
  end

  def delete
    @doc = Document.find(params[:document_id])
    if @doc != nil 
      document_id = @doc.id
      if File.exist?(@doc.document.current_path) # delete main document url if exists
        File.delete(@doc.document.current_path) 
      end
      if File.exist?(@doc.document.thumb.current_path) # delete thumbnail url if exists
        File.delete(@doc.document.thumb.current_path) 
      end

      @doc.delete # delete document record
      FileUtils.remove_dir("#{Rails.root}/public/uploads/document/document/#{document_id}") # remove document folder

      redirect_to documents_path
    else
      redirect_to root_path, flash: {alert: 'Document does not exist'}
    end
  end

  def document_params
    params.require(:document).permit(:quarter, :year, :document, :document_type, :description)
  end
end
