class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.references :library_category, index: true, foreign_key: true
      t.string :title
      t.string :author_name
      t.string :edition
      t.string :year_publication
      t.string :publishing_company
      t.string :isbn
      t.string :link
      t.datetime :sanctioned_date
      t.string :court
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.string :document_name
      t.string :process_number
      t.datetime :process_date
      t.string :legislative_reference
      t.text :description

      t.timestamps null: false
    end

    add_reference :words_keys, :library, index: true, foreign_key: true

  end
end
