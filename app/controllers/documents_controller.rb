class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @my_documents = Document.where(uploader_id: current_user.id)
    @courses = @my_documents.map do |document| 
      Course.find(document.course_id)
    end
    puts @courses
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
      @doc = Document.new
    end
  end

  def create
    @course_id = params[:course_id]
    if @course_id == nil || @course_id.empty?
      return redirect_to root_path, flash: {alert: 'You need to specify a course'}
    else
      @doc = Document.new(document_params)
      @doc.uploader_id = current_user.id
      @doc.course_id = @course_id
      if @doc.save 
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
    Document.delete(params[:document_id])
    redirect_to documents_path
  end

  def document_params
    params.require(:document).permit(:quarter, :year, :document, :description)
  end
end
