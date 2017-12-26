class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :recovery_token
      t.datetime :last_access
      t.string :zipcode
      t.string :address
      t.string :district
      t.string :number
      t.string :complement
      t.string :office
      t.string :department
      t.string :rg
      t.string :cpf
      t.date :birth_date
      t.string :whatsapp
      t.string :skype
      t.boolean :is_blocked
      t.string :password_to_save
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :office_state, references: :states
      t.references :office_city, references: :cities
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    User.create([
      {name: 'Administrador', email: 'admin@admin.com', password: '123mudar', profile_id: 1, seed: true},
      {name: 'Testes', email: 'teste@admin.com', password: 'teste', profile_id: 2, seed: true}
      ])
  end
end
