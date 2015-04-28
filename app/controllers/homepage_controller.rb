class HomepageController < ApplicationController
  DEPARTMENTS = YAML.load_file('config/major_abr.yml')

  def index 
    @department = DEPARTMENTS
  end

  def log_in
  end

  def sign_up
  end

  def about
  end

  def contact
  end
end
