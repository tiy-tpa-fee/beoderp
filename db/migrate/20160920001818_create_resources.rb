class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.json :data, null: false, default: {}

      t.timestamps
    end
  end
end
