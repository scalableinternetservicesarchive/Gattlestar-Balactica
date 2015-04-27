class UploadController < ApplicationController
  def index
    @doc = Document.new
  end

  def upload
    if user_signed_in?
      @doc = Document.new(document_params)
      @doc.uploader_id = current_user.id
      if @doc.save 
        return redirect_to documents_index_path
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
