class CreateReddittrend < ActiveRecord::Migration
  def change
    create_table :reddittrends do |t|
      t.string :title
      t.string :link
      t.string :tinyurl
      t.string :page
      t.boolean :philly_link

      t.timestamps
    end
  end
end
