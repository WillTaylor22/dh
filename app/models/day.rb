class Day < ActiveRecord::Base
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :users
end
