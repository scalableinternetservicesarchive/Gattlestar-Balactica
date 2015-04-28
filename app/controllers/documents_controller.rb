class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if user_signed_in?
      @my_documents = Document.where(uploader_id: current_user.id)
    else
    end
  end

  def new
    @doc = Document.new
  end

  def create
    if user_signed_in?
      @doc = Document.new(document_params)
      @doc.uploader_id = current_user.id
      if @doc.save 
        return redirect_to documents_path
      else
        return redirect_to root_path, flash: {alert: 'Error occured when uploading document'}
      end
    else
      return redirect_to root_path, flash: {alert: 'You have to be logged in to upload documents!'}
    end
  end

  def document_params
    params.require(:document).permit(:doc_type, :quarter_year, :document, :description)
  end
end
