class CategoriesController < ApplicationController
  include CategoriesHelper
  
  before_action :fetch_categories, only: [:index]

  def index
  end
end
