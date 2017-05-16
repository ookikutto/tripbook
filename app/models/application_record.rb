class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def class_name
    self.class.name.demodulize
  end

  def is_user?
    self.class.name.demodulize == "User"
  end

  def is_place?
    self.class.name.demodulize == "Place"
  end
end
