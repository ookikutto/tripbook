class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def class_name
    self.class.name.demodulize
  end
end
