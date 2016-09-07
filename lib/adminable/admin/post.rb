ActiveAdmin.register Post do

  sortable tree: true

  index do
    column '' do |p|
      if p.respond_to?(:is_a_project) && p.is_a_project
        content_tag :span, 'Проект', class: 'status_tag yes'
      else
        content_tag :span, 'Статья', class: 'status_tag no'
      end
    end
    column :id
    column 'Тэги' do |p|
      content_tag :span, p.tag_list
    end
    column :title
    column :available
    column :published_at
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
        post.galleries.each do |g|
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
      simple_format post.content
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
      f.input :title
      f.input :content, as: :wysihtml5
      f.input :published_at
    end
    f.inputs 'Тэги' do
      tags = ActsAsTaggableOn::Tag.order(:name).map{|x| [x.name, x.id]}
      tags.each_slice((tags.size/3).ceil + 1) do |sub_tags|
        f.input :tag_ids, as: :check_boxes, collection: sub_tags, label: false, input_html: {style: 'float:left;'}
      end
    end
    f.inputs 'Дополнительно' do
      show_fields_for(f)
    end
    galleries_for(f)
    f.actions
  end

  controller do
    def new
      @post = Post.new(published_at: Time.now, available: true)
    end

    def create
      @post = Post.new(permitted_params)
      if @post.valid?
        @post.save
        redirect_to [:admin, @post]
      else
        super
      end
    end

    def update
      @post = Post.find(params[:id])
      params[:post][:tag_list] = ActsAsTaggableOn::Tag.where(id: params[:post][:tag_ids]).pluck(:name).join(', ')
      if @post.update_attributes(permitted_params)
        redirect_to [:admin, @post]
      else
        render action: :new
      end
    end

    def permitted_params
      (params.permit(post: [:tag_list, :available, :title, :content, :published_at,
        galleries_attributes: [
          :_destroy,
          :name,
          { gallery_objects_attributes:  [:video, :photo, :_destroy, :id] },
          :id
        ]
      ] | Post.fields.map(&:value)) || {})[:post]
    end
  end

end
