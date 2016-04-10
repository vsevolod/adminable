# DB:
#   name: string
#   data: hstore
#   ancestry: string
#   position: integer
#   photo: asset
class Category < ActiveRecord::Base
  has_ancestry cache_depth: true
  include DictionaryColumns

  add_columns
  add_store_accessor

  Item rescue nil
  if ActiveRecord::Base.connection.table_exists?('items') && defined?(Item)
    has_many :items
  end

  validates :name, presence: true, uniqueness: {scope: [:ancestry]}

  has_attached_file :photo, styles: { :medium => "300x300>",
                                      :list => '280x326#',
                                      :thumb => "100x100>" },
                            convert_options: {
                                      medium: "-background white -compose Copy -gravity center -extent 300x300"
                                    }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def to_param
    if self.name
      "#{self.id}-#{Russian.translit(self.name).gsub(/\W/, '_')}"
    else
      self.id.to_s
    end
  end

end
