class Admin::BaseController < ApplicationController
  before_action :admin_only

  def download_emails
    @emails = User.all.select { |u| u.email.present? }.map { |u| {email: u.email, name: u.name, provider: u.provider} }.uniq { |u| u[:email] }
    respond_to do |format|
      format.xlsx
    end
  end

  def download_suggestions
    kikiki = '움하'
    @suggestions = Post.where("board_slug = '#{params[:type]}'").map do |p|
      name = p.user_id.present? ? p.user.name : p.guest_name
      {name: name, guest_email: p.guest_email, title: p.title, body: p.body, created_at: p.created_at.to_formatted_s(:db)}
    end
    respond_to do |format|
      format.xlsx
    end
  end

  private

  def admin_only
    redirect_to root_path if !user_signed_in? or !current_user.admin?
  end
end
