class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, unique: true
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :shortened_urls, :user_id
    add_index :shortened_urls, :short_url, unique: true 
  end

end
