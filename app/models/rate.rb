class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  before_save :authenticate
  #attr_accessible :rate, :dimension

  private

  def authenticate
  	unless signed_in?
  		
  	end
  end

end