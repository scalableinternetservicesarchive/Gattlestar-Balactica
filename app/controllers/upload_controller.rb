class UploadController < ApplicationController
  def index
    @doc = Document.new
  end

  def upload
    @doc = Document.new(document_params)
    if @doc.save 
    else
      return redirect_to root_path, flash: {alert: 'You have to be logged in to upload documents!'}
    end
  end

  def document_params
    params.require(:document).permit(:doc_type, :quarter_year, :document)
  end
end
