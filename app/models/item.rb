class Item < ActiveRecord::Base
  serialize :raw_info , Hash

  has_many :ownerships  , foreign_key: "item_id" , dependent: :destroy
  has_many :users , through: :ownerships
  
  has_many :wants, class_name: "Want" , foreign_key: "item_id", dependent: :destroy
  has_many :want_users , through: :wants, source: :user
  
  has_many :haves, class_name: "Have" , foreign_key: "item_id", dependent: :destroy
  has_many :have_users , through: :haves, source: :user
  
  
  #wantする
  def want(item)
    wants.find_or_create_by(asin: item.asin)
  end
  
  def want?(item)
    want_users.include?(item)
  end
  
  #want解除する
  def unwant(item)
    want_user = wants.find_by(item_id: item.id)
    want_user.destroy if want_user
  end
  
  #have
  def have(item)
    haves.find_or_create_by(item_id: item.id)
  end
  
  def have?(item)
    have_users.include?(item)
  end
  
  def unhave(item)
    have_user = haves.find_by(item_id: item.id)
    have_user.destroy if have_user
  end
  
  
end
