class Encounter < ActiveRecord::Base
    has_many :services
    belongs_to :bill
end
