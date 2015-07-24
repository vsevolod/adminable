ActiveAdmin.register Item do

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
