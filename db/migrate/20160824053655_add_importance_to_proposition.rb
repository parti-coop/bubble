class AddImportanceToProposition < ActiveRecord::Migration
  def change
    add_column :propositions, :importance, :int
  end
end
