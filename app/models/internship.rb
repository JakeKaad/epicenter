class Internship < ActiveRecord::Base
  belongs_to :company
  belongs_to :cohort
  validates_presence_of :description, :ideal_intern, :company_id, :cohort_id
end
