class AddChoiceToOpinions < ActiveRecord::Migration
  def change
    add_column :opinions, :choice, :string, null: false
  end
end
