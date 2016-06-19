class Session < ActiveRecord::Base
  
  belongs_to :user
  
  enum :device_type => {
    :browser => 0,
    :android => 1,
    :ios => 2
  }
  
end
