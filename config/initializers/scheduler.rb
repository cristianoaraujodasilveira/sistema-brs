require 'rufus-scheduler'

ENV['TZ'] = 'America/Sao_Paulo'

s = Rufus::Scheduler.singleton

s.cron '00 06 * * *' do
	ClientDocument.update_documents
	Contract.update_values_contracts
end

# s.every('1m') do
# 	ClientDocument.update_documents
# end