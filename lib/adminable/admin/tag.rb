# coding: utf-8
ActiveAdmin.register ActsAsTaggableOn::Tag do

  actions :all, :except => [:show]

  index do
    column :name
    column :old_tag_ids
    actions
  end

  form do |f|
    f.inputs :name
    f.actions
  end

  controller do
    def permitted_params
      params.permit acts_as_taggable_on_tag: [:name]
    end
  end

end

