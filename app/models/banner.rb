# DB:
#   position: integer
#   banner_type: string
#   data: hstore
#   url: string
#   available: boolean
#   photo: attachment

class Banner < ActiveRecord::Base
  belongs_to :object, polymorphic: true

  has_attached_file :photo, :styles => { :medium => "300x300>",
                                         :thumb => "100x100>",
                                         :carousel_gallery => "640x360#",
                                         :noco_list => '322x155#'
                                       },
                            :convert_options => { :thumb => "-quality 75 -strip" }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  include DictionaryColumns
  add_columns(:banner_fields)
  add_store_accessor
  
  scope :actual_by_type, lambda {|banner_type| where(banner_type: banner_type, available: true).order('RANDOM()')}

end
