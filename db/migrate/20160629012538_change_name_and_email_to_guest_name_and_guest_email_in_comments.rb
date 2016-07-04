class ChangeNameAndEmailToGuestNameAndGuestEmailInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :name, :guest_name
    rename_column :comments, :email, :guest_email
  end
end
