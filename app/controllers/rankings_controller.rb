class RankingsController < ApplicationController
  before_action :logged_in_user

  def index
  end
  
  
  def have
    @ranking = Have.group(:item_id).order('count_id desc').count(:id)
  end
  
  def want
    @ranking = Want.group(:item_id).order('count_id desc').count(:id)
  end
  
end