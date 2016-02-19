class User < ActiveRecord::Base
  
  has_many :requests, :dependent => :destroy
  has_many :suggestions, :dependent => :destroy
  
  has_many :userLanguages, :dependent => :destroy
  
  has_many :followers, :class_name => 'Follow', :foreign_key => 'followers_id', :dependent => :destroy
  has_many :followeds, :class_name => 'Follow', :foreign_key => 'followed_id', :dependent => :destroy
  
end
