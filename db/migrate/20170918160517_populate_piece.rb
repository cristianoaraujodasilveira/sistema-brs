class PopulatePiece < ActiveRecord::Migration
	def change
		PieceSituation.create([
			{name: 'Em andamento'},
			{name: 'Vencido'},
			{name: 'Finalizada'},
			{name: 'Declinado'}
			])

		PieceName.create([
			{name: 'Aditivo contratual'},
			{name: 'Aplicação penalidade'},
			{name: 'Cautelar'},
			{name: 'Cobrança'},
			{name: 'Contrarrazão'},
			{name: 'Contratos/ Aditivos'},
			{name: 'Defesa'},
			{name: 'Denúncia / Representação'},
			{name: 'Esclarecimentos'},
			{name: 'Estudo de caso'},
			{name: 'Liminar'},
			{name: 'Mandado de segurança'},
			{name: 'Notificação'},
			{name: 'Ocorrências impeditivas'},
			{name: 'Ofício'},
			{name: 'Parecer'},
			{name: 'Reajuste'},
			{name: 'Realinhamento'},
			{name: 'Recurso'},
			{name: 'Reequilíbrio'},
			{name: 'Rescisão'},
			{name: 'Outros'},
			])

		JudicialType.create([
			{name: 'Civil'},
			{name: 'Administrativo'},
			{name: 'Ambiental'},
			{name: 'Constitucional'},
			{name: 'Empresarial'},
			{name: 'Penal'},
			{name: 'Previdenciário'},
			{name: 'Trabalhista'},
			{name: 'Tributário'}
			])

		PieceResult.create([
			{name: 'Deferido'},
			{name: 'Deferido Parcialmente'},
			{name: 'Indeferido'},
			{name: 'Indeferido Parcialmente'},
			{name: 'Não apreciado'}
			])

		ShippingType.create([
			{name: 'Anexar ao sistema'},
			{name: 'Correios'},
			{name: 'E-mail'},
			{name: 'Pessoalmente'}
			])

	end
end
