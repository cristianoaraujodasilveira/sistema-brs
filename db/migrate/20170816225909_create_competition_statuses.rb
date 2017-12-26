class CreateCompetitionStatuses < ActiveRecord::Migration
	def change
		create_table :competition_statuses do |t|
			t.string :name

			t.timestamps null: false
		end
		CompetitionStatus.create([
			{ name: 'Acompanhamento' },
			{ name: 'Adjudicado' },
			{ name: 'Homologado' },
			{ name: 'Aceito e habilitado' },
			{ name: 'Cancelado / Anulado / Revogado' },
			{ name: 'Desclassificado / Inabilitado' },
			{ name: 'Em aceitação' },
			{ name: 'Fracassado' },
			{ name: 'Suspenso' }
			])
	end
end
