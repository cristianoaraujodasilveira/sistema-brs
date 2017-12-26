class LibrariesGrid

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

  filter(:title, :string, :header => Library.human_attribute_name(:title)) do |value|
    self.where("title LIKE ?", "%#{value}%")
  end

  filter(:words_keys, :enum, :select => proc { WordsKey.where.not(:library_id => nil).group(:word).order(:word).map {|c| [c.word, c.word] }}, :header => Library.human_attribute_name(:words_keys)) do |value|
    self.joins(:words_keys).where("words_keys.word = ?", value)
  end 

  filter(:library_category, :enum, :select => proc { LibraryCategory.all.order(:name).map {|c| [c.name, c.id] }}, :header => Library.human_attribute_name(:library_category)) do |value|
    self.where("library_category_id = ?", value)
  end 

  scope do
    Library.includes(:words_keys).includes(:library_category).order(created_at: :desc)
  end
  
  column(:title, :html => true, :order => "title", :header => Library.human_attribute_name(:title)) do |record|
    render "show_library", :object => record
  end

  column(:words_key, :order => "words_keys.word", :header => Library.human_attribute_name(:words_keys)) do |record|
    if record.words_keys
      record.words_keys.pluck(:word).join(', ')
    end
  end

  column(:library_category, :order => "library_categories.name", :header => Library.human_attribute_name(:library_category)) do |record|
    if record.library_category
      record.library_category.name
    end
  end

  column(:created_at, :header => Library.human_attribute_name(:created_at)) do |record|
    if record.created_at != nil
      I18n.l record.created_at.to_datetime, format: :full
    end
  end

  column(:actions, :html => true, :header => Library.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
