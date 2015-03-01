class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|
      t.string :name
      t.string :string
      t.string :founded
      t.string :integer
      t.string :city
      t.string :string

      t.timestamps null: false
    end
  end
end
