class HomeController < ApplicationController

  #can only get here if authorized right now...
  def index
  	 respond_to do |format|
      if @account.present? && @account.id.present?  && @account.id > 0
        format.html { render :index, status: :ok, location: @account }
        format.json { render :index, status: :ok, location: @account }
      end
    end
  end
end
