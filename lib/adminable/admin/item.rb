ActiveAdmin.register Item do

  index do
    column :id
    column :cost
    column :currency do |item|
      item.currency.try(:name)
    end
    column :category do |item|
      if item.category
        link_to item.category.try(:name), [:admin, item.category]
      end
    end
    column :brand do |item|
      item.brand.try(:name)
    end
    actions
  end

  form do |f|

    f.inputs 'Основное' do
      f.input :available
      f.input :name
      f.input :cost
      f.input :currency_id, as: :select, collection: Dictionary[:currencies]
      f.input :category_id, as: :select, :collection => nested_dropdown(Category.arrange)
      f.input :brand_id, as: :select, collection: Dictionary[:brands]
      f.input :description, as: :wysihtml5
    end
    galleries_for(f)
    f.actions

  end

  controller do

    def permitted_params
      params.permit(item: [
        :available,
        :name,
        :cost,
        :currency_id,
        :category_id,
        :brand_id,
        :description,
        galleries_attributes: [
          :_destroy,
          { gallery_objects_attributes:  [:video, :photo, :_destroy, :id] },
          :id
        ]
      ])
    end

  end

end
