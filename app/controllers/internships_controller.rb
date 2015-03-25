class InternshipsController < ApplicationController

  def index
    @cohort = Cohort.find(params[:cohort_id])
    @internships = @cohort.internships
  end
end
