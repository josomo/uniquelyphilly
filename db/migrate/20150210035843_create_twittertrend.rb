class CreateTwittertrend < ActiveRecord::Migration
  def change
    create_table :twittertrends do |t|
      t.belongs_to :woe, index: true
      t.string :name

      t.timestamps
    end
  end
end
