if ActiveRecord::Base.connection.table_exists?('items')
  ActiveAdmin.register Item do

    index do
      column :id
      column :name
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
        f.input :text, as: :wysihtml5
        f.input :description, as: :wysihtml5
      end
      f.inputs "Отношения" do
        item_list = Item.joins(:category).where.not(id: f.object.id).order('categories.name, items.name').map{|i| ["#{i.category.name}: #{i.name} (#{link_to 'просмотр', [:edit, :admin, i], target: :blank})".html_safe, i.id]}
        div class: 'two_col' do
          f.input :accessory_ids, as: :check_boxes, collection: item_list
        end
        div class: 'two_col' do
          f.input :similar_ids, as: :check_boxes, collection: item_list
        end
      end
      f.inputs "Документы" do
        f.has_many :documents, new_record: true,  allow_destroy: true, heading: false do |d|
          d.input :name
          d.input :file, as: :file
        end
        f.input :document_ids, as: :check_boxes, collection: Document.order('name, file')
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
          :text,
          accessory_ids: [],
          document_ids: [],
          documents_attributes: [
            :id,
            :_destroy,
            :file,
            :name
          ],
          similar_ids: [],
          galleries_attributes: [
            :_destroy,
            { gallery_objects_attributes:  [:video, :photo, :_destroy, :id] },
            :id
          ]
        ])
      end

    end

  end
end
