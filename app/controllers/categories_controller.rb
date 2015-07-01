class CategoriesController < ApplicationController
  include CategoriesHelper
  
  before_action :fetch_categories, only: [:index]

  def index
  end

  def search

  	search = Category.search do 
			   fulltext params[:search].downcase do
			   		fields(:name)
			   end
			 end

	categories = search.results		

  	respond_to do |format|
  		format.json { render json: categories, status: :created }
  	end
  end

end
