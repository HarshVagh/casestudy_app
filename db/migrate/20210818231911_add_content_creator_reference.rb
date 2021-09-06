class AddContentCreatorReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :casestudies, :contentcreator, null: false, index: true, foreign_key: {to_table: :users}
  end
end
