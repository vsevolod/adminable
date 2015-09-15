module ActiveAdmin::ViewsHelper

  def show_fields_for(f)
    dictionary_fields(f, f.object.class.fields)
  end

  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
      result << [('- ' * item.depth) + item.name, item.id]
      result += nested_dropdown(sub_items) unless sub_items.blank?
    end
    result
  end

  def galleries_for(f)
    f.inputs 'Галереи' do
      f.has_many :galleries, new_record: true, allow_destroy: true, heading: false do |gallery|
        gallery.input :name
        gallery.has_many :gallery_objects, new_record: true, allow_destroy: true, heading: false do |go|
          [:photo, :video].each do |m|
            #next if m == :video #TODO Temprorary remoed video
            if go.object
              go.input m, as: :file, hint: (go.object.send(m).blank? ? '' : go.template.image_tag(go.object.send(m).url(:thumb)))
            #else
            #  go.input m, as: :file
            end
          end
        end
      end
    end
  end
end
