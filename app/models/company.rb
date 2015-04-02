class Company < ActiveRecord::Base
  validates_presence_of :name, :contact_phone, :contact_email
  validates_uniqueness_of :name

<<<<<<< HEAD
  has_many :internships

=======
>>>>>>> ac36d2c6e16a79134f95c36d0cc757bf8f7c4911
  def last_company?
    self == Company.last
  end
end
