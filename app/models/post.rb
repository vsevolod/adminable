class Post < ActiveRecord::Base
  has_many :galleries, as: :galleryable, dependent: :destroy
  accepts_nested_attributes_for :galleries, allow_destroy: true

  scope :available, ->{ where(available: true) }

  def to_param
    if self.title
      "#{self.id}-#{Russian.translit(self.title).gsub(/\W/, '_')}"
    else
      self.id.to_s
    end
  end
end
