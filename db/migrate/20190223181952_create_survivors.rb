class CreateSurvivors < ActiveRecord::Migration[5.2]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :latitude
      t.string :longitude
      t.integer :infected
      t.integer :water
      t.integer :food
      t.integer :medication
      t.integer :ammunition

      t.timestamps
    end
  end
end
