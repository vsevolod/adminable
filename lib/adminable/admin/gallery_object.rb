ActiveAdmin.register GalleryObject do

  menu false

  member_action :sort, method: :post do
    @gallery_object = GalleryObject.find(params[:id])
    @gallery_object.insert_at params[:position].to_i
    render text: 'complete'
  end
end
