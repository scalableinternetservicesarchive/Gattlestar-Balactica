require 'file_size_validator'

class Document < ActiveRecord::Base
  mount_uploader :document, DocumentUploader

  validates :document, :presence => true, :file_size => {
    :maximum => 0.5.megabytes.to_i
  }


  # to get path to uploaded file for @doc do @doc.document.current_path
  # to get file extension for uploaded file do @doc.document.file.extension.downcase

  def display_test

  end

  def format_quarter_year
  end
end
