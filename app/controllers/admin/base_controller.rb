class Admin::BaseController < ApplicationController
  before_action :admin_only

  def download_emails
    @emails = User.all.select { |u| u.email.present? }.map { |u| {email: u.email, name: u.name, provider: u.provider} }.uniq { |u| u[:email] }
    respond_to do |format|
      format.xlsx
    end
  end

  private

  def admin_only
    redirect_to root_path if !user_signed_in? or !current_user.admin?
  end
end
