class Animal < ActiveRecord::Base
  belongs_to :species
  belongs_to :owner
  attr_accessible :gender, :name
end
