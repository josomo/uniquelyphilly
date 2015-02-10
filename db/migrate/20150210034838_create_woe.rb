class CreateWoe < ActiveRecord::Migration
  def change
    create_table :woes, id: false do |t|
      t.primary_key :id
      t.string :name

      t.timestamps
    end
  end
end
