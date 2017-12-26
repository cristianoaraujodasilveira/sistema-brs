class UsersGrid

  include Datagrid

  Datagrid.configure do |config|

    # Defines date formats that can be used to parse date.
    # Note that multiple formats can be specified but only first format used to format date as string. 
    # Other formats are just used for parsing date from string in case your App uses multiple.
    config.date_formats = ["%d/%m/%Y", "%d-%m-%Y"]

    # Defines timestamp formats that can be used to parse timestamp.
    # Note that multiple formats can be specified but only first format used to format timestamp as string. 
    # Other formats are just used for parsing timestamp from string in case your App uses multiple.
    config.datetime_formats = ["%d/%m/%Y %h:%M", "%d-%m-%Y %h:%M:%s"]
  end


  filter(:name, :string, :header => "Nome") do |value|
    self.where("name LIKE ?", "%#{value}%")
  end

  filter(:email, :string, :header => "Email") do |value|
    self.where("email LIKE ?", "%#{value}%")
  end

  filter(:profile_id, :enum, :select => proc { Profile.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Perfil") do |value|
    self.where("profile_id = ?", value)
  end 

  scope do
    User.includes(:calendar_color).includes(:profile).where.not(:id => 1).order(:name)
  end

  column(:type, :order => "profiles.name", :header => "Tipo") do |record|
    if record.profile
      record.profile.name
    end
  end

  column(:name, :order => "name", :header => "Nome completo") do |record|
    record.name
  end

  column(:color, :html => true, :header => "Cor") do |record|
    render "show_color", :object => record
  end

  column(:email, :order => "email", :header => "Email") do |record|
    record.email
  end

  column(:password, :order => "password_to_save", :header => "Senha") do |record|
    record.password_to_save
  end

  column(:last_access, :header => "Último acesso") do |record|
     if record.last_access != nil
      I18n.l record.last_access.to_datetime, format: :full
    end
  end

  column(:is_blocked, :header => "Bloqueado?") do |record|
    if record.is_blocked
      "Sim"
    else
      "Não"
    end
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
