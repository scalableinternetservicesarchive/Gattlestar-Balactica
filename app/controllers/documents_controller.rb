class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if user_signed_in?
      @my_documents = Document.where(uploader_id: current_user.id)
    else
    end
  end
end
