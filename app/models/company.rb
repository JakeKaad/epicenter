class Company < ActiveRecord::Base
  validates_presence_of :name, :contact_phone, :contact_email
  validates_uniqueness_of :name

  has_many :internships

  def last_company?
    self == Company.last
  end
end
