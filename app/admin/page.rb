Adminable::ActiveAdmin.register Adminable::Page do

  sortable tree: true

  index :as => :sortable do
    label :name # item content
    actions
  end

  show do
    attributes_table do
      row :title
      row :tag
    end
    div do
      h2 "Галереи"
      ul do
        page.galleries.each do |g|
          li do
            g.gallery_objects.each do |go|
              unless go.photo.blank?
                span link_to(image_tag(go.photo.url(:thumb)), go.photo.url, {target: '_blank'})
              end
              unless go.video.blank?
                span link_to(image_tag(go.video.url(:thumb)), go.video.url, {target: '_blank'})
              end
            end
          end
        end
      end
    end
    div do
      simple_format page.content
    end
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  form do |f|
    f.inputs 'Основное' do
      f.input :available, as: :boolean, required: false
      f.input :name
      f.input :title
      f.input :tag
      f.input :parent_id, :as => :select, :collection => nested_dropdown(Adminable::Page.arrange)
      f.input :content, as: :wysihtml5
      f.input :options, as: :text, input_html: {class: 'jsoneditor-target'}
    end
    galleries_for(f)
    f.actions
  end

  controller do

    def permitted_params
      params.permit(page: [
        :available, :name, :title, :tag, :content, :options, :parent_id,
        galleries_attributes: [
          :_destroy,
          { gallery_objects_attributes:  [:video, :photo, :_destroy, :id] },
          :id
        ]
      ])
    end

  end

end
