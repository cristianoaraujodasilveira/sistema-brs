class CreateScales < ActiveRecord::Migration
  def change
    create_table :scales do |t|
      t.string :name

      t.timestamps null: false
    end

    Scale.create([
			{name: 'ME - até 10 fun./ R$ 480.000,00 '},
			{name: 'EPP - até 19fun./R$ 4.800.00,00'},
			{name: 'OE - acima 20 fun./ R$ 4.800.000,00'}
			])
	
  end
end
