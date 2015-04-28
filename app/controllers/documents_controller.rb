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
    @doc = Document.new
  end

  def create
    @doc = Document.new(document_params)
    @doc.uploader_id = current_user.id
    if @doc.save 
      return redirect_to documents_path
    else
      return redirect_to root_path, flash: {alert: 'Error occured when uploading document'}
    end
  end

  def document_params
    params.require(:document).permit(:quarter_year, :document, :description)
  end
end
