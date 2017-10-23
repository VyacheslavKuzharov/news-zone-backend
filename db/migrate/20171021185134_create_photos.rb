class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :news_id
      t.string :photo

      t.timestamps
    end
  end
end
