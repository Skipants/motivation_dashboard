class DataSet < ActiveRecord::Base
  belongs_to :data_source
  has_many :reports
end
