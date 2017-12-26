class CreatePriceOffers < ActiveRecord::Migration
	def change
		create_table :price_offers do |t|
			t.string :name

			t.timestamps null: false
		end
		PriceOffer.create([
			{ name: 'Menor preço por Item' },
			{ name: 'Menor preço por Lote Unitário' },
			{ name: 'Menor preço por Lote Global' },
			{ name: 'Menor preço por Grupo' },
			{ name: 'Menor taxa de administração' },
			{ name: 'Maior Desconto na tabela' },
			{ name: 'Maior lance' },
			{ name: 'Melhor técnica' },
			{ name: 'Melhor técnica e preço' },
			{ name: 'Outros' },
			])
	end
end
