class CreateWordsKeys < ActiveRecord::Migration
  def change
    create_table :words_keys do |t|
      t.string :word
	  t.references :client_segment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
