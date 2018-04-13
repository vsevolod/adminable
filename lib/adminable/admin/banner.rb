ActiveAdmin.register Banner do

  sortable tree: true
  config.filters = false

  index do
    column :id
    column :banner_type do |banner|
      s = Dictionary.find_by_tag(banner.banner_type).try(:name)
      if banner.object
        s += " " + banner.object.try(:name)
      end
      s
    end
    column :available
    column :url
    column :photo do |banner|
      if banner.photo?
        image_tag banner.photo.url(:thumb)
      end
    end
    actions
  end

  show do
    attributes_table do
      row :banner_type
      row :url
    end
    div do
      span link_to(image_tag(banner.photo.url(:thumb)), banner.photo.url, {target: '_blank'})
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
      f.input :banner_type, as: :select, collection: Dictionary[:banners_lists].map{|d| [d.name, d.tag]}
      f.input :url
      f.input :photo, as: :file, hint: (f.object.photo.blank? ? '' : f.template.image_tag(f.object.photo.url(:thumb)))
    end
    f.inputs 'Дополнительно' do
      f.input :object_type, as: :select, :collection => [['Страница', 'Page']]
      f.input :object_id, as: :select, :collection => nested_dropdown(Page.arrange)
      show_fields_for(f)
    end
    f.actions
  end

  controller do
    def index
      @banners = Banner.order(created_at: :desc).page(params[:page]).per(10)
    end

    def new
      @banner = Banner.new(permitted_params)
    end

    def create
      @banner = Banner.new(permitted_params)
      if @banner.valid?
        @banner.save
        redirect_to [:admin, @banner]
      else
        super
      end
    end

    def update
      @banner = Banner.find(params[:id])
      if @banner.update_attributes(permitted_params)
        redirect_to [:admin, @banner]
      else
        render action: :new
      end
    end

    def permitted_params
      (params.permit(banner: [
        :available, :banner_type, :url, :photo, :object_id, :object_type
      ] | Banner.fields.map(&:value)) || {})[:banner]
    end

  end

end
