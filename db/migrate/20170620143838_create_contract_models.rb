class CreateContractModels < ActiveRecord::Migration
	def change
		create_table :contract_models do |t|
			t.text :draft_contact, :limit => 4294967295\

			t.timestamps null: false
		end

		ContractModel.create([
			{draft_contact: '<div style="background-color:white;">
				<img src="http://download.harmisweb.com.br/images/logo-brs.jpg" alt="Logo BR" style="margin: 0;padding: 0px 63px;" />
				<h2 style="text-align: center;padding: 0 0 25px;font-size: 28px;"><u>MINUTA CONTRATUAL DE PRESTAÇÃO DE SERVIÇO DE ASSESSORIA EM LICITAÇÃO</u></h2>
				<div style="text-align: justify;padding: 0px 63px;">
				<p>Pelo presente instrumento particular e na melhor forma de direito, de um lado <strong>BRS CONSULTORIA LTDA - ME</strong>, inscrita sob CNPJ de nº. <strong>18.675.831/0001–29</strong>, sediada na <strong>Avenida Nossa Senhora de Fátima</strong>, <strong>nº: 2.576</strong>, <strong>bairro Carlos Prates</strong> em <strong>Belo Horizonte, Minas Gerais</strong>, <strong>CEP: 30.710–020</strong>, neste ato representado por <strong>LUCIMAR PEREIRA XAVIER RIBEIRO</strong>, brasileira, viúva, empresária, inscrita no CPF sob o nº. <strong>584.910.826–20</strong>, e portadora da carteira de identidade <strong>MG–2.568.487</strong>, com mesmo endereço profissional, doravante denominada de <strong>CONTRATADA</strong>, e do outro lado a empresa <strong>[CLIENTE_NOME_EMPRESA]</strong> inscrito sob CNPJ de nº. <strong>[CLIENTE_CNPJ]</strong>, sediada na <strong>[CLIENTE_ENDERECO_LOGRADOURO]</strong>, nº. <strong>[CLIENTE_ENDERECO_NUMERO]</strong> – complemento: [CLIENTE_ENDERECO_COMPLEMENTO], bairro [CLIENTE_ENDERECO_BAIRRO], no município de [CLIENTE_ENDERECO_CIDADE], estado de <strong>[CLIENTE_ENDERECO_ESTADO]</strong>, CEP: <strong>[CLIENTE_ENDERECO_CEP]</strong> neste ato representado por seu(s) sócio(s) proprietário o Sr. <strong>[CLIENTE_REPRESENTANTE_NOME_COMPLETO]</strong>, <strong>[CLIENTE_REPRESENTANTE_NACIONALIDADE]</strong>, <strong>[CLIENTE_REPRESENTANTE_PROFISSAO]</strong>, <strong>[CLIENTE_REPRESENTANTE_ESTADO_CIVIL]</strong> inscrito no CPF sob o nº: <strong>[CLIENTE_REPRESENTANTE_CPF]</strong>, e portador da carteira de identidade <strong>[CLIENTE_REPRESENTANTE_RG]</strong>, residente e domiciliado a <strong>[CLIENTE_REPRESENTANTE_ENDERECO_LOGRADOURO]</strong>, nº: <strong>[CLIENTE_REPRESENTANTE_ENDERECO_NUMERO]</strong>, bairro <strong>[CLIENTE_REPRESENTANTE_ENDERECO_BAIRRO]</strong>, no município de <strong>[CLIENTE_REPRESENTANTE_ENDERECO_CIDADE]</strong> no estado de <strong>[CLIENTE_REPRESENTANTE_ENDERECO_ESTADO]</strong>, CEP: <strong>[CLIENTE_REPRESENTANTE_ENDERECO_CEP]</strong>, doravante denominado de <strong>CONTRATANTE</strong>, ajustam e acordam entre si, o presente Contrato de Prestação de Serviços, que se regerá pelas seguintes cláusulas e condições:</p>

					<h3>Cláusula Primeira – DO OBJETO</h3>

					<p><strong>1.1</strong> - O presente contrato tem por objeto a prestação de serviços de assessoria em Licitações Públicas em <strong>âmbito [CLIENTE_AMBITO]</strong>. Por assessoria compreende-se: conferência e análise de documentos necessários, cadastramento e atualização de documentos junto aos órgãos, captura e análise dos instrumentos convocatórios, recursos administrativos, participação nas modalidades licitatórias eletrônicas e presenciais, acompanhamento dos certames e ações correlatas em estrita conformidade com os princípios éticos e previstos em leis.</p>

					<h3>CLÁUSULA SEGUNDA – DO PRAZO</h3>

					<p><strong>2.1</strong> - O prazo de vigência do presente contrato é de [CLIENTE_PRAZO_NUMERO] meses, iniciando-se a sua contagem na data da assinatura deste instrumento, renovando-se, expressa ou tacitamente, após o decurso de tal prazo, pelo período indeterminado. </p>

						<p><strong>2.2</strong> - Caso uma das partes não tenha o interesse em dar continuidade aos serviços ora contratados, deverá proceder à comunicação por escrito à outra parte, observando-se o previsto na cláusula décima <strong>SÉTIMA</strong>.</p>

						<h3>CLÁUSULA TERCEIRA – DA MENSALIDADE E PAGAMENTO</h3>

						<p><strong>3.1</strong> – Como parte do serviço prestado, será cobrado da Contratante o valor mensal de R$[CLIENTE_PRECO_NUMERO], com data de vencimento fixada no dia [CLIENTE_PRECO_DATA_NUMERO] de cada mês, referentes à assessoria mensal, através de boleto bancário.</p>

							<p><strong>3.2</strong> - A cobrança do valor fixo mensal, correspondente à primeira mensalidade, será realizada no ato da assinatura deste instrumento.</p>

								<h3>CLÁUSULA QUARTA – DA COMISSÃO</h3>

								<p><strong>4.1</strong> – Fica acordado com a <strong>CONTRATANTE</strong> o repasse no percentual de <strong>[CLIENTE_PRECO_PERCENTUAL_NUMERO]% ([CLIENTE_PRECO_PERCENTUAL_EXTENSO] por cento) do valor das licitações favoráveis à CONTRATADA</strong>, assim, compreendidas aquelas declaradas empenhadas, adjudicadas e/ou homologadas pelos órgãos públicos, incluindo o somatório dos valores das licitações favoráveis no respectivo mês, bem como a valores provenientes das prorrogações do contrato com o órgão, caronas nas atas de registros de preço, reforços, aditivos contratuais, reajustes e realinhamentos de preço, além de quaisquer outras situações que aumentem o valor dos contratos firmados com a Administração Pública.</p>

									<p><strong>4.2</strong> – Os valores referentes ao percentual firmado no item acima serão pagos após o recebimento do <strong>CONTRATANTE</strong> realizado pelo órgão, repassados a <strong>CONTRATADA</strong> conforme a data do pagamento previsto na <strong>CLÁUSULA TERCEIRA</strong>.</p>

										<p><strong>4.3</strong> – Caso ocorra atraso no fornecimento ou execução do contrato com a administração em razão de culpa ou dolo da <strong>CONTRATANTE</strong>, fica a <strong>CONTRATADA</strong> autorizada a proceder à cobrança do valor da comissão no prazo de 48 horas confirmado o pagamento realizado à <strong>CONTRATANTE</strong>.</p>

											<p><strong>4.4</strong> - Caso as partes decidam pela rescisão contratual, fica assegurado a <strong>CONTRATADA</strong> o recebimento dos processos que tenha realizado intervenção, nas condições deste contrato, com repasse em até 48hs após confirmado o pagamento pelo órgão/instituição.</p>

											<h3>CLÁUSULA QUINTA – DAS OBRIGAÇÕES DA CONTRATADA</h3>

											<p><strong>5</strong> - A <strong>CONTRATADA</strong> obriga-se a:</p>

											<p>Manter o mais absoluto sigilo e confidencialidade, não somente quanto ao que tange aos serviços objetos deste contrato, como também sobre quaisquer informações ou documentos a que tenha acesso em razão do pactuado neste instrumento;</p>

												<p>Garantir a qualidade dos serviços contratados, em conformidade com as especificações técnicas, cumprindo o manual de ética e conduta do respectivo Conselho de classe a que pertencer;</p>

													<p>Responsabilizar-se por quaisquer atos inadequados na consecução dos serviços, especialmente aos que sejam contrários às especificações técnicas do contrato a ser firmado;</p>

														<p>Ressarcir à <strong>CONTRATANTE</strong> quaisquer prejuízos que porventura possam lhe ser ocasionados, em razão de erros relativos às atividades praticadas e de responsabilidade da <strong>CONTRATADA</strong>.</p>

														<h3>CLÁUSULA SEXTA – OBRIGAÇÕES DA CONTRATANTE</h3>

														<p><strong>6</strong> - A <strong>CONTRATANTE</strong> obriga-se a:</p>

														<p>I. Remunerar a <strong>CONTRATADA</strong> pontualmente pelos serviços prestados, nos moldes do previsto nas cláusulas <strong>TERCEIRA</strong> e <strong>QUARTA</strong> deste instrumento;</p>

															<p>II. Fornecer à <strong>CONTRATADA</strong>, prontamente, todos os documentos e meios necessários para a consecução de seus objetivos, a fim de possibilitar uma maior eficiência em suas atividades;</p>
															

															<p>III. Respeitar a todas as normas contidas na legislação, no edital de licitação e nas Autorizações de Fornecimento;</p>

															<p>IV. Dirimir, esclarecer, responder e orientar sobre quaisquer questões referentes ao objeto ofertado ao Órgão Público, em momento indicado pela <strong>CONTRATADA</strong> e sempre que se fizer necessário;</p>

															<p>V. Substabelecer poderes para sua representação legal, firmando procuração à pessoa designada pela <strong>CONTRATADA</strong>, a fim de que esta tenha legitimidade para atuar nos processos licitatórios presenciais e eletrônicos em nome da <strong>CONTRATANTE</strong>;</p>

															<p>VI. Responsabilizar-se pelo pagamento de, diligências, emolumentos, fotocópias de processos, correios, cartórios, motoboy, entre outros, sempre que se fizer necessário, mediante comprovante do gasto;</p>

																<p>VII. Fornecer, à <strong>CONTRATADA</strong>, todo e qualquer cópia dos documentos referentes às autorizações de fornecimento, empenhos, ordens de serviço, contratos, notas fiscais de fornecimento, atas, bem como outros documentos relativos aos processos, fornecimentos e recebimentos e ao cumprimento do firmado em sede da contratação licitatória em que a <strong>CONTRATADA</strong> tenha atuado no prazo de até 03 (três) dias, e ainda para os documentos solicitados pela Administração no prazo estabelecido pelo órgão.</p>

																	<p>VIII. Ressarcir à <strong>CONTRATADA</strong> sempre que, independentemente de dolo ou culpa, pratique atos relativos ao ora contratado que, por ação ou omissão, importem em manifestos prejuízos para esta.</p>

																	<h3>Cláusula SÉTIMA – DA PARTICIPAÇÃO NOS PROCESSOS ELETRÔNICOS</h3>

																	<p><strong>7.1</strong> – A <strong>CONTRATADA</strong> representará a <strong>CONTRATANTE</strong> através de procuração particular, Chave de Acesso, Login, Senha ou outra condição que seja necessário para se Logar junto ao sistema eletrônico.</p>

																	<p><strong>7.2</strong> - A empresa <strong>CONTRATADA</strong> deverá enviar à <strong>CONTRATANTE</strong>, por meio de correio eletrônico (e-mail), os instrumentos convocatórios, com a devida antecedência de até 6 (seis) dias a contar a data de abertura da sessão, para que seja possível sua efetiva participação no certame.</p>

																	<p><strong>7.3</strong> – Em havendo a necessidade de se interpor impugnações a instrumento convocatório, em razão de apontamentos técnicos, a CONTRATANTE comunicará à <strong>CONTRATADA</strong> com antecedência mínima de 3 (três) dias úteis da data fixada para a abertura das propostas, a fim de que haja tempo hábil para que sejam feitas as manifestações acerca do tema.</p>

																		<p><strong>7.4</strong> - A <strong>CONTRATANTE</strong> deverá formular e enviar as propostas referentes aos itens, lotes, grupos, etc, conforme especificados em edital, sempre observando o termo de referência, projeto básico aos processos que se manifestar favoravelmente à sua participação.</p>

																		<p><strong>7.5</strong> - A <strong>CONTRATANTE</strong> deverá esclarecer quaisquer dúvidas técnicas à CONTRATADA ou ao Órgão interessado, mediante solicitação destes. </p>

																		<p><strong>7.6</strong> - As propostas realizadas para a participação nos certames deverão ser enviadas via correio eletrônico (e-mail) à <strong>CONTRATADA</strong>, com antecedência mínima de 04 (quatro) dias da data prevista para sua abertura ou em prazo pré-determinado, quando for o caso. </p>
																		
																		<h3>Cláusula OITAVA – DA PARTICIPAÇÃO NOS PROCESSOS PRESENCIAIS</h3>

																		<p><strong>8.1</strong> - Fica acordado que a empresa <strong>CONTRATADA</strong> participará dos processos licitatórios presenciais sempre que as propostas forem devidamente enviadas. </p>

																		<p><strong>8.2</strong> - A <strong>CONTRATADA</strong> representará a <strong>CONTRATANTE</strong> através de procuração particular, ou, ainda, de acordo com o modelo anexo ao Edital. </p>

																		<p><strong>8.3</strong> - As custas referentes ao deslocamento para a participação da licitação, correrão as expensas da <strong>CONTRATANTE</strong>, mediante acordo prévio. </p>

																		<p><strong>PARÁGRAFO ÚNICO</strong>: O pagamento dos custos constantes nesta cláusula será realizado pela <strong>CONTRATANTE</strong> via depósito bancário, em conta corrente indicada pela <strong>CONTRATADA</strong>, com antecedência mínima de 48hs úteis da data prevista para a realização do certame.</p>

																			<h3>CLÁUSULA NONA – DAS DESPESAS EXTRAORDINÁRIAS</h3>

																			<p><strong>9</strong> - A <strong>CONTRATADA</strong> não se responsabilizará pelo pagamento de despesas extraordinárias, em especial:</p>

																			<p>I. Imposto sobre Notas Fiscais emitidas pela Contratante;</p>

																			<p>II. Despesas notariais, envio de correspondências, diligências, diárias de viagens, estacionamento, reprografia, passagens aéreas e rodoviárias, pedágios e serviços terceirizados de transporte;</p>

																			<p>III. Pagamentos de impostos, custas de entregas e despesas com terceiros, advertências, multas e penalidades, oriundas do não cumprimento das obrigações editalícias por parte da Contratante;</p>

																				<p>IV. Quaisquer outras despesas para com a Administração Pública, terceiros e gastos necessários a execução dos serviços, assim como despesas referentes às custas processuais e aos honorárias advocatícios em qualquer instância.</p>

																				<h3>CLÁUSULA DÉCIMA – DA MORA E DA MULTA</h3>

																				<p><strong>10.1</strong> - A ausência de quitação do valor devido à <strong>CONTRATADA</strong> na sua data de vencimento, conforme determinado pelas cláusulas terceira e quarta do presente instrumento, sujeitará a Contratante, de forma cumulativa, independentemente de aviso ou interpelação judicial, à incidência de atualização monetária, com base no Índice Geral de Preços de Mercado (IGPM) ou outro índice que vier a substituí-lo, aos juros de mora, no importe de 1% (um por cento) ao mês, com incidência de juros compostos até a data da liquidação integral do débito, além de multa no percentual de 10% (dez por cento) sobre o valor reajustado da parcela não quitada.</p>

																					<p><strong>10.2</strong> – Considerar-se-á multa por descumprimento de cláusulas contratuais, o valor de R$ 2.000,00 (dois mil reais), salvo se outro valor for expressamente estabelecido por este contrato.</p>

																					<p><strong>PARÁGRAFO ÚNICO</strong>: A aplicação da penalidade de multa não desonera o infrator ao pagamento do previsto no item 10.1.</p>

																						<p><strong>10.3</strong> – Fica assegurado a <strong>CONTRATADA</strong> a inclusão da CONTRATANTE nos órgão de defesa de proteção ao crédito após atraso de 10 dias do vencimento, sem prejuízo do título ser protestado.</p>

																							<h3>CLÁUSULA DÉCIMA PRIMEIRA – DA CONFIDENCIALIDADE</h3>

																							<p><strong>11.1</strong> - As partes se obrigam a manterem o mais absoluto sigilo com relação a toda e qualquer informação, conforme abaixo definida, que venha a ser fornecida em razão do contrato, devendo ser tratada como informação sigilosa.</p>

																								<p><strong>11.2</strong> - Deverá ser considerada como informação confidencial, toda e qualquer informação escrita ou oral revelada entre as partes, independentemente de tê-la sido conferida o título de “CONFIDENCIAL”. </p>

																								<p><strong>11.3</strong> - O termo “Informação” abrangerá toda informação escrita, verbal ou de qualquer outro modo apresentada, tangível ou intangível, podendo incluir, mas não se limitando a tal, os seguintes termos: know-how, estratégias comerciais, campanhas de marketing, work shop, treinamentos, técnicas, designs, especificações, marcas, jingles, home pages, logomarca, desenhos, cópias, diagramas, fórmulas, modelos, amostras, fluxogramas, croquis, fotografias, plantas, programas de computador, CD, DVD, discos, disquetes, fitas de vídeo, filmagem, microfilmagem, arquivo de áudio, contratos, planos de negócios, processos, projetos, conceitos de produto, especificações, amostras de ideia, clientes, nomes de revendedores e/ou distribuidores, preços e custos, definições e informações mercadológicas, invenções e ideias, outras informações técnicas, financeiras ou comerciais, a que, diretamente ou através de seus diretores, empregados e/ou prepostos, venham às partes a terem acesso, conhecimento, ou as que lhes sejam confiadas durante o contrato. </p>

																								<p><strong>11.4</strong> - Comprometem-se as partes a não revelar, reproduzir, utilizar ou dar conhecimento, em hipótese alguma, a terceiros, bem como a não permitir que nenhum de seus diretores, empregados e/ou prepostos façam uso dessas <strong>INFORMAÇÕES CONFIDENCIAIS</strong> de forma diversa a de executar o Contrato Principal.</p>

																								<p><strong>11.5</strong> - As partes deverão cuidar para que as <strong>INFORMAÇÕES CONFIDENCIAIS</strong> fiquem restritas ao conhecimento dos diretores, empregados e/ou prepostos que estejam diretamente envolvidos nas discussões, análises, reuniões e negócios, devendo cientificá-los da existência deste Termo e da natureza confidencial das informações neste instrumento contidas.</p>

																								<p><strong>11.6</strong> - A partir da data de assinatura do presente <strong>CONTRATO</strong>, fica vedado a qualquer das partes revelarem, divulgar ou de qualquer outra forma tornar conhecidas quaisquer informações confidenciais da outra parte, divulgadas por qualquer meio, sejam estas informações técnicas, financeiras, contábeis, dentre outras, bem como quaisquer documentos, tecnologias, projetos, arquivos, programas, registros, amostras, dentre outros, de que a outra parte venha a ter conhecimento ou acesso, direta ou indiretamente, em razão do presente <strong>CONTRATO</strong>.</p>

																									<p><strong>11.7</strong> - O dever de confidencialidade, a que se refere esta cláusula, não se baseará em prazo, devendo ser perpetuo após a rescisão do contrato. Frisando-se que a inobservância deste ônus implicará em multa por descumprimento contratual, sem prejuízo as medidas judiciais cabíveis.</p>

																										<h3>Cláusula DÉCIMA SEGUNDA – Inexistência de Vínculo Empregatício</h3>

																										<p><strong>12</strong> - O presente instrumento, em virtude de ausência de requisitos legais, não implicará na formação de vínculo empregatício de qualquer natureza entre a Contratante e Contratado, sendo que os serviços serão prestados sem subordinação, cada qual respondendo por seus encargos fiscais, previdenciários e trabalhistas.</p>

																										<h3>Cláusula DÉCIMA TERCEIRA – da contratação de ex-empregado</h3>

																										<p><strong>13</strong> - Fica convencionado que a <strong>CONTRATANTE</strong> não admitirá em seu quadro de empregados funcionário egresso da <strong>CONTRATADA</strong>, por um período não inferior a 5 (cinco) anos após o término de contrato de trabalho, ressalvada a hipótese de anuência da <strong>CONTRATADA</strong>.</p>

																										<h3>Cláusula décima QUARTA – DA RESPONSABILIDADE</h3>

																										<p><strong>14.1</strong> - A <strong>CONTRATADA</strong> não se responsabilizará pelos valores formalizados nas propostas fornecidas pela <strong>CONTRATANTE</strong>, quando da sua participação em procedimentos licitatórios, bem como por equívocos nas formações de preço, na execução dos serviços, na vistoria e visita técnica que acarretem prejuízo a <strong>CONTRATANTE</strong>. </p>

																										<p><strong>14.2</strong> - As informações prestadas pela <strong>CONTRATANTE</strong> são de sua inteira responsabilidade, sendo que a <strong>CONTRATADA</strong> não será responsabilizada por eventuais equívocos cometidos.</p>

																										<h3>Cláusula DÉCIMA QUINTA – DAS INFORMAÇÕES</h3>

																										<p><strong>15.1</strong> - Todos os documentos para a execução dos serviços prestados pela <strong>CONTRATADA</strong> deverão ser fornecidos pela <strong>CONTRATANTE</strong> em original ou cópia autenticada por cartório competente, sempre que solicitado, e dentro do prazo indicado pela <strong>CONTRATADA</strong>.</p>

																											<p><strong>15.2</strong> - A <strong>CONTRATANTE</strong> disponibilizará contato telefônico direito com pessoa, preposto ou outrem, que será designado como responsável pelo contrato ora celebrado, com vistas a trocar informações durante a realização do pregão quando necessário. </p>

																												<p><strong>15.3</strong> - A <strong>CONTRATADA</strong> não se responsabilizará por eventuais prejuízos, na hipótese de não conseguir contato com a <strong>CONTRATANTE</strong>, ou responsável por este designado, em momento oportuno.</p>

																												<p><strong>15.4</strong> - Quaisquer notificações a serem enviadas no âmbito deste instrumento as partes, deverão ser por escrito e será considerada recebida quando entregue pelos Correios com Aviso de Recebimento (AR), por reconhecido serviço particular de entrega ou, ainda, por fac-símile, no endereço constante no caput deste instrumento ou outro endereço informado por escrito, devidamente protocolado e tendo comprovação de recebimento.</p>

																												<p><strong>15.5</strong> - Sempre que julgar necessário, a <strong>CONTRATANTE</strong> poderá requerer relatórios acerca das atividades desenvolvidas pela <strong>CONTRATADA</strong>, com prazo para resposta de 5 (cinco) dias úteis. </p>

																												<p><strong>15.6</strong> - A <strong>CONTRATANTE</strong> deverá, em até 48hs, encaminhar, via fac-símile ou por meio de correio eletrônico (e-mail), cópia de qualquer documento referente aos processos conexos com a <strong>CONTRATADA</strong>, que tenha recebido diretamente dos Órgãos Públicos, assim como cópia da Nota Fiscal emitida, em conformidade com o processo de fornecimento, além da apresentação de Contratos, Notas de Empenho, Autorizações de Fornecimento, Ordem de Fornecimento, ou quaisquer outros documentos administrativos correlatos, sob pena de incorrer em multa por descumprimento contratual.</p>

																												<h3>Cláusula DéCIMA SEXTA - DA SUCESSÃO</h3>

																												<p><strong>16</strong> - Na hipótese de transformação societária da empresa CONTRATANTE, seja ela por incorporação, cisão ou fusão, a sociedade que deste processo resultar a sucederá em bens, direitos e obrigações, inclusive em relação ao presente contrato, comprometendo-se a dar continuidade aos termos deste instrumento, bem como aos seus anexos e termos aditivos, caso haja celebrados.</p>

																												<h3>Cláusula décima SÉTIMA – DA RESCISÃO</h3>

																												<p><strong>17.1</strong> - O presente contrato poderá ser rescindido a qualquer tempo sem justo motivo sem pagamento de multa, ou quando ensejado por infrações descrita neste instrumento, mediante simples comunicação epistolar à outra, dando um pré-aviso por escrito de 30 (trinta) dias. </p>

																												<p><strong>17.2</strong> - No caso de haverem processos licitatórios em andamento inicialmente tratados pela CONTRATADA, quando da ocorrência de rescisão contratual, serão de responsabilidade da empresa CONTRATANTE todas as obrigações supervenientes, necessárias à sua finalização, bem como a devida remuneração pelos serviços prestados pela <strong>CONTRATADA</strong>.</p>

																												<p><strong>PARÁGRAFO PRIMEIRO</strong> - Poderão apresentar-se, as referidas obrigações acima mencionadas, título exemplificativo, o dever de:</p>

																												<p>I - Realizar o fornecimento de acordo com as normas e regras constantes no edital de licitação, no contrato firmado, na lei vigente e na proposta enviada a Administração;</p>

																												<p>II – Manter regular e atualizada a sua documentação como consequência de causa e efeito para o recebimento por parte dos Órgãos Públicos;</p>

																												<p>III - Acompanhar as licitações realizadas, por meio dos portais de compras governamentais, chat’s, publicações oficiais, fax, telefonemas, etc;</p>

																												<p>IV - Prestar informações e esclarecimentos à <strong>CONTRATADA</strong>, referentes ao andamento das licitações iniciadas e realizadas;</p>

																												<p>V - Atualizar os Certificados de Registro Cadastrais, Portais de Cadastros e outros Registros de Fornecedores para garantir o fornecimento e recebimento dos processos consagrados;</p>

																												<p>VI - Comunicar a solicitação e autorização de quaisquer ações que tenham correlação com os serviços prestados pela <strong>CONTRATADA</strong> na área de licitação, tais quais: Caronas nas Atas de Registro de Preço, Prorrogações, Realinhamentos de Preço, Aditivos Contratuais, entre outros;</p>

																												<p>VII – Enviar à <strong>CONTRATADA</strong> todos os documentos que tiver acesso referentes aos processos realizados e em acompanhamento, tais quais: Empenhos, Autorização de Fornecimento, Aditivos Contratuais e quaisquer outros documentos referentes aos processos;</p>

																												<p>VIII - Responder em tempo hábil às notificações, ofícios, advertências realizadas pela Administração;</p>

																												<p>IX - Redirecionar os contatos e dados dos processos juntamente aos órgãos.</p>

																												<p><strong>PARÁGRAFO SEGUNDO</strong> - No caso de rescisão contratual por qualquer das partes, fica assegurado à Contratada, o recebimento dos valores a serem pagos em virtude de Contratos, Atas de Registro de Preço, Autorizações de Fornecimento, Aditivos, Prorrogações, Caronas, Realinhamento Economico-Financiero do Contrato, Reajuste ou qualquer outra condição dos processos adjudicados, homologados e/ou licitações participadas e que tenham sido iniciadas antes da realização da licitação (sessão, certame, processo…). </p>

																													<p><strong>PARÁGRAFO TERCEIRO</strong> - A inobservância do previsto no caput desta cláusula importará em aplicação da pena de multa em conformidade com o previsto na <strong>CLÁUSULA DÉCIMA</strong>.</p>

																														<p><strong>PARÁGRAFO QUARTO</strong> - Em caso de distrato, fica a <strong>CONTRATANTE</strong> obrigada a repassar o valor do pagamento realizado pelo órgão a <strong>CONTRATADA</strong> em até 48 horas após a confirmação do pagamento.</p>

																															<p><strong>17.3</strong> - Fica assegurado à <strong>CONTRATANTE</strong>, o direito de proceder à retirada dos documentos de sua empresa, após a rescisão contratual que estejam sob posse da <strong>CONTRATADA</strong>, ao longo da execução deste contrato de prestação de serviços, bem como das informações sobre logins e senhas de conhecimento da <strong>CONTRATADA</strong>, protocolando-se seu recebimento.</p>

																															<h3>CLÁUSULA décima OITAVA – INFRAÇÕES CONTRATUAIS</h3>

																															<p><strong>18</strong> - O presente contrato resolve-se, independente de qualquer notificação judicial ou extrajudicial, na ocorrência das hipóteses que se seguem:</p>

																															<p>I – Se a CONTRATADA deixar de exercer a sua atividade profissional com diligência, probidade e zelo máximos;</p>

																															<p>II – Se for constatada qualquer irregularidade nas atividades da CONTRATADA e/ou da CONTRATANTE, objetivadas pelo presente instrumento;</p>

																															<p>III – Se houver infração deste contrato, em quaisquer de suas cláusulas e condições;</p>

																															<p>IV– Se houver atraso no pagamento da mensalidade e/ou comissão superiores há 15 dias corridos da data de vencimento;</p>

																															<p>V– Nos demais casos previstos na legislação em vigor.</p>

																															<h3>CLÁUSULA DÉCIMA NONA – DA LIBERALIDADE</h3>

																															<p><strong>19</strong> - O atraso, a tolerância ou a abstenção das partes do exercício de quaisquer direitos ou faculdades que lhe assistam em decorrência da lei ou do presente contrato, bem como a eventual tolerância a atrasos no cumprimento das obrigações assumidas pelas empresas, não implicarão em novação, não podendo ser interpretados como renúncia a tais direitos ou faculdades, que poderão ser exercidos, a qualquer tempo, a critério exclusivo das mesmas.</p>

																																<h3>CLÁUSULA VIGÉSIMA – DA AUSÊNCIA DE EXCLUSIVIDADE</h3>

																																<p><strong>20</strong> - O presente contrato de prestação de serviços não tem caráter de exclusividade, podendo a <strong>CONTRATADA</strong> prestar livremente serviços para terceiro, ainda que seja empresa do mesmo ramo de atividade da empresa <strong>CONTRATANTE</strong>.</p>

																																	<h3>CLÁUSULA VIGÉSIMA PRIMEIRA - DISPOSIÇÕES GERAIS</h3>

																																	<p><strong>21.1</strong> – A <strong>CONTRATADA</strong> somente atuará em demandas anteriores a assinatura deste quando acordado as condições de remuneração pelo serviços que serão prestados.</p>

																																	<p><strong>21.2</strong> - As partes concordam em empregar seus melhores esforços ao assinarem os documentos ou os contratos, bem como para a consumação das transações aqui contempladas.</p>

																																	<p><strong>21.3</strong> - Não configurarão desrespeito ou descumprimento às condições deste contrato: </p>

																																	<p>I – Se as informações ou dados forem classificados e de conhecimento público, ou vierem a assumir essa condição no decorrer do contrato ou após seu término;</p>

																																		<p>II – Se a divulgação de ato ou fato sobrevier de ordem judicial, de órgão regulador ou governamental, comprometendo-se a parte reveladora a informar imediatamente à outra parte sobre a ocorrência de tal fato.</p>

																																		<p><strong>21.4</strong> - Os direitos e obrigações das partes em relação a este instrumento não poderão ser cedidos sem o prévio aviso escrito, com o respectivo consentimento da outra parte. </p>

																																		<p><strong>21.5</strong> - As condições comerciais e técnicas prevalecerão sobre as disposições deste instrumento no que não conflitarem com o mesmo.</p>

																																		<p><strong>21.6</strong> - As partes poderão formalizar a contratação de novos produtos ou serviços, bem como alterar consensualmente as condições contratuais ora ajustadas, mediante a subscrição de novos anexos e respectivos termos de aditamento, que passarão a integrar este contrato.</p>

																																		<h3>Cláusula VIGÉSIMA SEGUNDA – Eleição de Foro</h3>

																																		<p><strong>22.1</strong> - Fica eleito o foro da Comarca de Belo Horizonte em Minas Gerais como competente para dirimir quaisquer dúvidas ou eventuais controvérsias surgidas na execução do presente contrato, com renúncia expressa de outro, por mais privilegiado que possa ser.</p>

																																			<p><strong>22.2</strong> - E por estarem assim justos e contratados, assinam as partes o presente instrumento em 02 (duas) vias de igual teor e forma, na presença das testemunhas infine assinadas.</p>

																																			<br>
																																			<br>
																																			<br>

																																			<p>Belo Horizonte, [CLIENTE_DATA_DIA_NUMERO] de [CLIENTE_DATA_MES_EXTENSO] de [CLIENTE_DATA_ANO_NUMERO].</p>

																																			<br><br><br>

																																			<center>
																																			<table style="text-align: left;">
																																			<tr>
																																			<td>
																																			__________________________________________________ <br>
																																			BRS CONSULTORIA LTDA
																																			</td>
																																			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
																																			<td>
																																			__________________________________________________ <br>
																																			[CLIENTE_RAZAO_SOCIAL]
																																			</td>
																																			</tr>
																																			<tr>
																																			<td>
																																			<br><br><br>
																																			__________________________________________________ <br>
																																			TES.: <br>
																																			CPF:
																																			</td>
																																			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
																																			<td>
																																			<br><br><br>
																																			__________________________________________________ <br>
																																			TES.: <br>
																																			CPF:
																																			</td>
																																			</tr>
																																			</table>
																																			</center>

																																			<br><br><br><br>

																																			<center>
																																			<p><strong>Av. Nossa Senhora de Fátima, nº 2576 - Carlos Prates - Belo Horizonte - Minas Gerais - CEP: 30.710-020 <br>Tel. (31) 2533-3100 / 2533-3131 - Website <u>awww.brslicita.com.br</u> - Webmail: <u>contato@brslicita.com.br</u></strong></p>
																																			</center>
																																			</div>
																																			</div>'}
																																			])
end
end
