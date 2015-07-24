# DB:
#   position: integer
#   banner_type: string
#   data: hstore
#   url: string
#   available: boolean
#   photo: attachment

class Banner < ActiveRecord::Base

  has_attached_file :photo, :styles => { :medium => "300x300>",
                                         :thumb => "100x100>",
                                         :carousel_gallery => "640x360#"
                                       },
                            :convert_options => { :thumb => "-quality 75 -strip" }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
