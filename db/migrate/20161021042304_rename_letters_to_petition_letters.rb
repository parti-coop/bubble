class RenameLettersToPetitionLetters < ActiveRecord::Migration
  def change
    rename_table :letters, :petition_letters
  end
end
