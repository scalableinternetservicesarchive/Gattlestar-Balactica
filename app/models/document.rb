require 'file_size_validator'

class Document < ActiveRecord::Base
  mount_uploader :document, DocumentUploader

  validates :document, :presence => true, :file_size => {
    :maximum => 0.5.megabytes.to_i
  }

  has_reputation :votes, source: :user, aggregated_by: :sum
  # to get path to uploaded file for @doc do @doc.document.current_path
  # to get file extension for uploaded file do @doc.document.file.extension.downcase

  def self.search_test(test_id)
    begin
      Document.find(test_id)
    rescue
      # if there is no test_id in the database
      []
    end
  end

  def display_test

  end

  def format_quarter_year
    raise
  end
end
