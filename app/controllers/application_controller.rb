class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?

protected
  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:plan_id, :cohort_id, :name, :email, :password, :password_confirmation) }
  end

  def after_sign_in_path_for(student)
    if student.primary_payment_method.present?
      payments_path
    elsif student.bank_accounts.first.present?
      edit_verification_path
    else
      new_payment_method_path
    end
  end
end
