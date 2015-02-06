class CreateTwittertrend < ActiveRecord::Migration
  def change
    create_table :twittertrends do |t|
      t.string :trend 
    
      t.timestamps
    end

  end
end
