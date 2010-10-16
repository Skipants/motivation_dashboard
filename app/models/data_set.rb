class DataSet < ActiveRecord::Base
  belongs_to :data_source
  has_many :widget
  
  def config=(opts)
    write_attribute(:config, opts.to_yaml)
  end

  def config
    YAML::load(read_attribute(:config))
  end
end