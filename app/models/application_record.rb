class ApplicationRecord < ActiveRecord::Base
  attr_protected
  self.abstract_class = true
end
