source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass'

# Banco de dados
gem 'mysql2'
# Mensagens de notificação
gem 'gritter', '~> 1.2'
# Form
gem 'simple_form'
# Datagrid
gem 'datagrid'
gem 'iconv'
gem "kaminari"
# Criptografia de password
gem 'bcrypt'
# TinyMCE Editor
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
# Envio de emails
gem 'mailgun_rails'
# Upload
gem "paperclip", "~> 4.3"
# Armazenamento
gem 'aws-sdk', '< 2.0'
# Busca CEP Correios
gem 'correios-cep'
# Find N+1 Queries
gem 'n_1_finder'
# Auditoria
gem "audited", "~> 4.4"
# Auto-session-timeout
gem 'auto-session-timeout'
# Recaptcha
gem "recaptcha", require: "recaptcha/rails"
# Agendamento de ações
gem 'rufus-scheduler', '~> 3.2'
# fullcalendar
gem 'fullcalendar-rails'
gem 'momentjs-rails'
# export pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
# validar email
gem 'validates_email_format_of'
# geolocalização
gem 'geokit-rails'
gem 'geocoder'
# datatable
gem 'jquery-datatables-rails', '~> 3.4.0'

# unread
gem 'unread'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
  gem 'cpf_faker'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
   gem 'heroku-deflater'
end

group :test do
  gem "chromedriver-helper"
  gem 'email_spec'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem "shoulda-matchers", "< 3.0.0", require: false
end
