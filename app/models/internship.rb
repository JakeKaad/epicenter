class Internship < ActiveRecord::Base
  belongs_to :company
  belongs_to :cohort
  validates_presence_of :description, :ideal_intern, :company_id, :cohort_id

  delegate :name, to: :company

  def last_internship?
    self == self.cohort.internships.last
  end

end
