# Abstract superclass for table-less models
#
# credits: https://gist.github.com/ahoward/1888250

class Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  def model_name
    self < Model ? self.name.gsub('Model::', '') : super
  end
  
  def initialize(attributes = {})
    unless attributes.blank?
      attributes.each{|name, value| send("#{ name }=", value)}
    end
  end
  
  def persisted?
    false
  end
end
