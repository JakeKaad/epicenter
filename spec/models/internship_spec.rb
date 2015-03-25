describe Internship do
  it { should belong_to :company }
  it { should belong_to :cohort }
  it { should validate_presence_of :description }
  it { should validate_presence_of :ideal_intern }
  it { should validate_presence_of :cohort_id }
  it { should validate_presence_of :company_id }

  describe '#last_internship?' do
    # let!(:company) { FactoryGirl.create(:company) }
    let!(:cohort) { FactoryGirl.create(:cohort) }
    let!(:internship) { FactoryGirl.create(:internship, cohort_id: cohort.id) }
    let!(:internship_two) { FactoryGirl.create(:internship, cohort_id: cohort.id) }

    it "returns true if it is the last internship" do
      expect(internship_two.last_internship?).to be_truthy
    end

    it "returns false if it isn't the last internship" do
       expect(internship.last_internship?).to be_falsey
    end

  end
end
