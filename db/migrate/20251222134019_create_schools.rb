class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.references :school_admin, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
