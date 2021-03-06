class CreateCountries < ActiveRecord::Migration
	def change
		create_table :countries do |t|
			t.string :name

			t.timestamps null: false
		end
		Country.create([
			{ name: 'AFEGANISTÃO' },
			{ name: 'ACROTÍRI E DECELIA' },
			{ name: 'ÁFRICA DO SUL' },
			{ name: 'ALBÂNIA' },
			{ name: 'ALEMANHA' },
			{ name: 'AMERICAN SAMOA' },
			{ name: 'ANDORRA' },
			{ name: 'ANGOLA' },
			{ name: 'ANGUILLA' },
			{ name: 'ANTÍGUA E BARBUDA' },
			{ name: 'ANTILHAS NEERLANDESAS' },
			{ name: 'ARÁBIA SAUDITA' },
			{ name: 'ARGÉLIA' },
			{ name: 'ARGENTINA' },
			{ name: 'ARMÉNIA' },
			{ name: 'ARUBA' },
			{ name: 'AUSTRÁLIA' },
			{ name: 'ÁUSTRIA' },
			{ name: 'AZERBAIJÃO' },
			{ name: 'BAHAMAS' },
			{ name: 'BANGLADECHE' },
			{ name: 'BARBADOS' },
			{ name: 'BARÉM' },
			{ name: 'BASSAS DA ÍNDIA' },
			{ name: 'BÉLGICA' },
			{ name: 'BELIZE' },
			{ name: 'BENIM' },
			{ name: 'BERMUDAS' },
			{ name: 'BIELORRÚSSIA' },
			{ name: 'BOLÍVIA' },
			{ name: 'BÓSNIA E HERZEGOVINA' },
			{ name: 'BOTSUANA' },
			{ name: 'BRASIL' },
			{ name: 'BRUNEI DARUSSALAM' },
			{ name: 'BULGÁRIA' },
			{ name: 'BURQUINA FASO' },
			{ name: 'BURUNDI' },
			{ name: 'BUTÃO' },
			{ name: 'CABO VERDE' },
			{ name: 'CAMARÕES' },
			{ name: 'CAMBOJA' },
			{ name: 'CANADÁ' },
			{ name: 'CATAR' },
			{ name: 'CAZAQUISTÃO' },
			{ name: 'CENTRO-AFRICANA REPÚBLICA' },
			{ name: 'CHADE' },
			{ name: 'CHILE' },
			{ name: 'CHINA' },
			{ name: 'CHIPRE' },
			{ name: 'COLÔMBIA' },
			{ name: 'COMORES' },
			{ name: 'CONGO' },
			{ name: 'CONGO REPÚBLICA DEMOCRÁTICA' },
			{ name: 'COREIA DO NORTE' },
			{ name: 'COREIA DO SUL' },
			{ name: 'COSTA DO MARFIM' },
			{ name: 'COSTA RICA' },
			{ name: 'CROÁCIA' },
			{ name: 'CUBA' },
			{ name: 'DINAMARCA' },
			{ name: 'DOMÍNICA' },
			{ name: 'EGIPTO' },
			{ name: 'EMIRADOS ÁRABES UNIDOS' },
			{ name: 'EQUADOR' },
			{ name: 'ERITREIA' },
			{ name: 'ESLOVÁQUIA' },
			{ name: 'ESLOVÉNIA' },
			{ name: 'ESPANHA' },
			{ name: 'ESTADOS UNIDOS' },
			{ name: 'ESTÓNIA' },
			{ name: 'ETIÓPIA' },
			{ name: 'FAIXA DE GAZA' },
			{ name: 'FIJI' },
			{ name: 'FILIPINAS' },
			{ name: 'FINLÂNDIA' },
			{ name: 'FRANÇA' },
			{ name: 'GABÃO' },
			{ name: 'GÂMBIA' },
			{ name: 'GANA' },
			{ name: 'GEÓRGIA' },
			{ name: 'GIBRALTAR' },
			{ name: 'GRANADA' },
			{ name: 'GRÉCIA' },
			{ name: 'GRONELÂNDIA' },
			{ name: 'GUADALUPE' },
			{ name: 'GUAM' },
			{ name: 'GUATEMALA' },
			{ name: 'GUERNSEY' },
			{ name: 'GUIANA' },
			{ name: 'GUIANA FRANCESA' },
			{ name: 'GUINÉ' },
			{ name: 'GUINÉ EQUATORIAL' },
			{ name: 'GUINÉ-BISSAU' },
			{ name: 'HAITI' },
			{ name: 'HONDURAS' },
			{ name: 'HONG KONG' },
			{ name: 'HUNGRIA' },
			{ name: 'IÉMEN' },
			{ name: 'ILHA BOUVET' },
			{ name: 'ILHA CHRISTMAS' },
			{ name: 'ILHA DE CLIPPERTON' },
			{ name: 'ILHA DE JOÃO DA NOVA' },
			{ name: 'ILHA DE MAN' },
			{ name: 'ILHA DE NAVASSA' },
			{ name: 'ILHA EUROPA' },
			{ name: 'ILHA NORFOLK' },
			{ name: 'ILHA TROMELIN' },
			{ name: 'ILHAS ASHMORE E CARTIER' },
			{ name: 'ILHAS CAIMAN' },
			{ name: 'ILHAS COCOS { KEELING)' },
			{ name: 'ILHAS COOK' },
			{ name: 'ILHAS DO MAR DE CORAL' },
			{ name: 'ILHAS FALKLANDS { ILHAS MALVINAS)' },
			{ name: 'ILHAS FEROE' },
			{ name: 'ILHAS GEÓRGIA DO SUL E SANDWICH DO SUL' },
			{ name: 'ILHAS MARIANAS DO NORTE' },
			{ name: 'ILHAS MARSHALL' },
			{ name: 'ILHAS PARACEL' },
			{ name: 'ILHAS PITCAIRN' },
			{ name: 'ILHAS SALOMÃO' },
			{ name: 'ILHAS SPRATLY' },
			{ name: 'ILHAS VIRGENS AMERICANAS' },
			{ name: 'ILHAS VIRGENS BRITÂNICAS' },
			{ name: 'ÍNDIA' },
			{ name: 'INDONÉSIA' },
			{ name: 'IRÃO' },
			{ name: 'IRAQUE' },
			{ name: 'IRLANDA' },
			{ name: 'ISLÂNDIA' },
			{ name: 'ISRAEL' },
			{ name: 'ITÁLIA' },
			{ name: 'JAMAICA' },
			{ name: 'JAN MAYEN' },
			{ name: 'JAPÃO' },
			{ name: 'JERSEY' },
			{ name: 'JIBUTI' },
			{ name: 'JORDÂNIA' },
			{ name: 'KIRIBATI' },
			{ name: 'KOWEIT' },
			{ name: 'LAOS' },
			{ name: 'LESOTO' },
			{ name: 'LETÓNIA' },
			{ name: 'LÍBANO' },
			{ name: 'LIBÉRIA' },
			{ name: 'LÍBIA' },
			{ name: 'LISTENSTAINE' },
			{ name: 'LITUÂNIA' },
			{ name: 'LUXEMBURGO' },
			{ name: 'MACAU' },
			{ name: 'MACEDÓNIA' },
			{ name: 'MADAGÁSCAR' },
			{ name: 'MALÁSIA' },
			{ name: 'MALAVI' },
			{ name: 'MALDIVAS' },
			{ name: 'MALI' },
			{ name: 'MALTA' },
			{ name: 'MARROCOS' },
			{ name: 'MARTINICA' },
			{ name: 'MAURÍCIA' },
			{ name: 'MAURITÂNIA' },
			{ name: 'MAYOTTE' },
			{ name: 'MÉXICO' },
			{ name: 'MIANMAR' },
			{ name: 'MICRONÉSIA' },
			{ name: 'MOÇAMBIQUE' },
			{ name: 'MOLDÁVIA' },
			{ name: 'MÓNACO' },
			{ name: 'MONGÓLIA' },
			{ name: 'MONTENEGRO' },
			{ name: 'MONTSERRAT' },
			{ name: 'NAMÍBIA' },
			{ name: 'NAURU' },
			{ name: 'NEPAL' },
			{ name: 'NICARÁGUA' },
			{ name: 'NÍGER' },
			{ name: 'NIGÉRIA' },
			{ name: 'NIUE' },
			{ name: 'NORUEGA' },
			{ name: 'NOVA CALEDÓNIA' },
			{ name: 'NOVA ZELÂNDIA' },
			{ name: 'OMÃ' },
			{ name: 'PAÍSES BAIXOS' },
			{ name: 'PALAU' },
			{ name: 'PALESTINA' },
			{ name: 'PANAMÁ' },
			{ name: 'PAPUÁSIA-NOVA GUINÉ' },
			{ name: 'PAQUISTÃO' },
			{ name: 'PARAGUAI' },
			{ name: 'PERU' },
			{ name: 'POLINÉSIA FRANCESA' },
			{ name: 'POLÓNIA' },
			{ name: 'PORTO RICO' },
			{ name: 'PORTUGAL' },
			{ name: 'QUÉNIA' },
			{ name: 'QUIRGUIZISTÃO' },
			{ name: 'REINO UNIDO' },
			{ name: 'REPÚBLICA CHECA' },
			{ name: 'REPÚBLICA DOMINICANA' },
			{ name: 'ROMÉNIA' },
			{ name: 'RUANDA' },
			{ name: 'RÚSSIA' },
			{ name: 'SAHARA OCCIDENTAL' },
			{ name: 'SALVADOR' },
			{ name: 'SAMOA' },
			{ name: 'SANTA HELENA' },
			{ name: 'SANTA LÚCIA' },
			{ name: 'SANTA SÉ' },
			{ name: 'SÃO CRISTÓVÃO E NEVES' },
			{ name: 'SÃO MARINO' },
			{ name: 'SÃO PEDRO E MIQUELÃO' },
			{ name: 'SÃO TOMÉ E PRÍNCIPE' },
			{ name: 'SÃO VICENTE E GRANADINAS' },
			{ name: 'SEICHELES' },
			{ name: 'SENEGAL' },
			{ name: 'SERRA LEOA' },
			{ name: 'SÉRVIA' },
			{ name: 'SINGAPURA' },
			{ name: 'SÍRIA' },
			{ name: 'SOMÁLIA' },
			{ name: 'SRI LANCA' },
			{ name: 'SUAZILÂNDIA' },
			{ name: 'SUDÃO' },
			{ name: 'SUÉCIA' },
			{ name: 'SUÍÇA' },
			{ name: 'SURINAME' },
			{ name: 'SVALBARD' },
			{ name: 'TAILÂNDIA' },
			{ name: 'TAIWAN' },
			{ name: 'TAJIQUISTÃO' },
			{ name: 'TANZÂNIA' },
			{ name: 'TERRITÓRIO BRITÂNICO DO OCEANO ÍNDICO' },
			{ name: 'TERRITÓRIO DAS ILHAS HEARD E MCDONALD' },
			{ name: 'TIMOR-LESTE' },
			{ name: 'TOGO' },
			{ name: 'TOKELAU' },
			{ name: 'TONGA' },
			{ name: 'TRINDADE E TOBAGO' },
			{ name: 'TUNÍSIA' },
			{ name: 'TURKS E CAICOS' },
			{ name: 'TURQUEMENISTÃO' },
			{ name: 'TURQUIA' },
			{ name: 'TUVALU' },
			{ name: 'UCRÂNIA' },
			{ name: 'UGANDA' },
			{ name: 'URUGUAI' },
			{ name: 'USBEQUISTÃO' },
			{ name: 'VANUATU' },
			{ name: 'VENEZUELA' },
			{ name: 'VIETNAME' },
			{ name: 'WALLIS E FUTUNA' },
			{ name: 'ZÂMBIA' },
			{ name: 'ZIMBABUÉ' }
			])
end
end
