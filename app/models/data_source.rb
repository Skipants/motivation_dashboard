class DataSource < ActiveRecord::Base
  belongs_to :user
  has_many :data_sets
  
end