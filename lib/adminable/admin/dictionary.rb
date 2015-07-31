ActiveAdmin.register Dictionary do

  sortable tree: true

  action_item :view, only: :show do
    link_to 'Добавить в', new_admin_dictionary_path(dictionary: {parent_id: dictionary.id})
  end

  index :as => :sortable do
    label do |d|
      res = d.name
      if d.tag.present?
        res += " (#{d.tag})"
      end
      res
    end
    actions do |d|
      link_to "Добавить в", new_admin_dictionary_path(dictionary: {parent_id: d.id} )
    end
  end

  form do |f|

    f.inputs 'Основное' do
      f.input :available
      f.input :name
      f.input :tag
      f.input :value
      f.input :parent_id, as: :select, :collection => nested_dropdown(Dictionary.arrange)
    end
    f.inputs 'Дополнительно' do
      f.input :variable_type_id, as: :select, collection: Dictionary[:column_types]
      show_fields_for(f)
    end
    f.actions

  end

  controller do

    def new
      @dictionary = Dictionary.new(permitted_params)
    end

    def create
      @dictionary = Dictionary.new(permitted_params)
      if @dictionary.valid?
        @dictionary.save
        redirect_to [:admin, @dictionary]
      else
        super
      end
    end

    def update
      @dictionary = Dictionary.find(params[:id])
      if @dictionary.update_attributes(permitted_params)
        redirect_to [:admin, @dictionary]
      else
        render action: :new
      end
    end

    def permitted_params
      (params.permit(dictionary: [
        :name,
        :value,
        :tag,
        :available,
        :parent_id,
        :variable_type_id
      ] | Dictionary.fields.map(&:value)) || {})[:dictionary]
    end

  end

end
