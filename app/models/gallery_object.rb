class GalleryObject < ActiveRecord::Base
  belongs_to :gallery

  acts_as_list scope: :gallery

  #mount_uploader :photo, PhotoImageUploader, mount_on: :photo_image_filename
  has_attached_file :photo, :styles => { :medium => "300x300>",
                                         :thumb => "100x100>",
                                         :item_show => "553x484>",
                                         :item_down_show => "137x130#",
                                         :item => "356x390#",
                                         #:gallery => { :geometry => "800x600>",
                                         #              :watermark_path => Proc.new{|p| "#{Rails.root}/app/assets/images/watermark-#{p.instance.organization.domain}.png"},
                                         #              :position => "Center",
                                         #              :processors => [:watermark]
                                         #            },
                                         :carousel_gallery => "640x360#",
                                         :photo_large => "800x600>",
                                         :gallery => "376x288#",
                                         :gallery_list => "x567",
                                         :rs_img_small => "96x72#",
                                         :rs_img_big => "540x372#"
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
    main: { geometry: '640x', format: 'jpg', time: 10},
    thumb: {geometry: '100x100>', format: 'jpg', time: 10}
    #small: { geometry: '210x120!', format: 'jpg', time: 10},
    #medium: {format: 'jpg', geometry: "300x300>", time: 10},
    #item_show: {format: 'jpg', geometry: "553x484>", time: 10},
    #item_down_show: {format: 'jpg', geometry: "137x130#", time: 10},
    #item: {format: 'jpg', geometry: "356x390", time: 10},
    #carousel_gallery: {format: 'jpg', geometry: "640x360#", time: 10},
    #gallery: {format: 'jpg', geometry: "376x288#", time: 10},
    #gallery_list: {format: 'jpg', geometry: "x567", time: 10}
  },
  path: "public/system/videos/videos/:style/:filename",
  url: "/system/videos/videos/:style/:basename.:extension",
  processors: [:ffmpeg, :qtfaststart], max_size: 350.megabytes
  process_in_background :video, only_process: [:original]

  #before_create :update_position

  #def update_position
  #  self.position ||= self.gallery.gallery_objects.maximum(:position).to_i + 1
  #end

  def object
    self.video.present? ? self.video : self.photo
  end

  def get_photo_url(photo_thumb_name = nil, video_thumb_name = nil)
    self.photo.present? ? self.photo.url(photo_thumb_name) : self.video.url(video_thumb_name)
  end

end
