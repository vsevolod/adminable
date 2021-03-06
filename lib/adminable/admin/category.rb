ActiveAdmin.register Category do

  sortable tree: true

  action_item :view, only: :show do
    link_to 'Добавить подкатегорию', new_admin_category_path(category: {parent_id: category.id})
  end

  index :as => :sortable do
    label :name # item content
    actions do |d|
      link_to "Добавить в", new_admin_category_path(category: {parent_id: d.id} )
    end
  end

  form do |f|

    f.inputs 'Основное' do
      f.input :name
      f.input :parent_id, :as => :select, :collection => nested_dropdown(Category.arrange)
      f.input :photo, as: :file, hint: (f.object.photo.blank? ? '' : f.template.image_tag(f.object.photo.url(:thumb)))
    end
    f.inputs 'Дополнительно' do
      show_fields_for(f)
    end
    f.actions

  end

  controller do

    def new
      @category = Category.new(permitted_params)
    end

    def create
      @category = Category.new(permitted_params)
      if @category.valid?
        @category.save
        redirect_to [:admin, @category]
      else
        super
      end
    end

    def update
      @category = Category.find(params[:id])
      if @category.update_attributes(permitted_params)
        redirect_to [:admin, @category]
      else
        render action: :new
      end
    end

    def permitted_params
      (params.permit(category: [
        :name,
        :parent_id,
        :photo
      ] | Category.fields.map(&:value)) || {})[:category]
    end

  end

end
