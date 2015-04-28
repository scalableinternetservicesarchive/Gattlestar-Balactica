class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @my_documents = Document.where(uploader_id: current_user.id)
  end

  def new
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

  def create
    @doc = Document.new(document_params)
    @doc.uploader_id = current_user.id
    if @doc.save 
      return redirect_to documents_path
    else
      if @doc.errors.any? 
        puts @doc.errors.full_messages
      end
      return redirect_to root_path, flash: {alert: 'Error occured when uploading document'}
    end
  end

  def document_params
    params.require(:document).permit(:quarter, :year, :document, :description)
  end
end
