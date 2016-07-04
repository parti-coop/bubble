class ChangeNullableNameInComments < ActiveRecord::Migration
  def change
    change_column_null :comments, :name, true
  end
end
