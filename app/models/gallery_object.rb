class GalleryObject < ActiveRecord::Base
  belongs_to :gallery

  #mount_uploader :photo, PhotoImageUploader, mount_on: :photo_image_filename
  has_attached_file :photo, :styles => { :medium => "300x300>",
                                         :thumb => "100x100>",
                                         :item_show => "553x484>",
                                         :item_down_show => "137x130#",
                                         :item => "356x390",
                                         #:gallery => { :geometry => "800x600>",
                                         #              :watermark_path => Proc.new{|p| "#{Rails.root}/app/assets/images/watermark-#{p.instance.organization.domain}.png"},
                                         #              :position => "Center",
                                         #              :processors => [:watermark]
                                         #            },
                                         :carousel_gallery => "640x360#",
                                         :gallery => "376x288#"
                                       },
                            :convert_options => { :thumb => "-quality 75 -strip" }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_attached_file :video, styles: {
    original:  {
      geometry: "1024x768",
      format: 'mp4',
      streaming: true,
      convert_options: { output: {vcodec: 'libx264', acodec: 'libfaac'}}
    },
    main: { geometry: '640x', format: 'jpg', time: 10 },
    thumb: {geometry: '100x100>', format: 'jpg', time: 10},
    small: { geometry: '210x120!', format: 'jpg', time: 10 }
  },
  path: "public/system/videos/videos/:style/:filename",
  url: "/system/videos/videos/:style/:basename.:extension",
  processors: [:ffmpeg, :qtfaststart], max_size: 350.megabytes

end
