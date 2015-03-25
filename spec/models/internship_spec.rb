describe Internship do
  it { should belong_to :company }
  it { should belong_to :cohort }
  it { should validate_presence_of :description }
  it { should validate_presence_of :ideal_intern }


end
