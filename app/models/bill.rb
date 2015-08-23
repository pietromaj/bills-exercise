class Bill < ActiveRecord::Base
  has_many :encounters
end
