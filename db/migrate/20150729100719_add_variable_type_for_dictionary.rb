class AddVariableTypeForDictionary < ActiveRecord::Migration
  def change
    add_column :dictionaries, :variable_type_id, :integer
  end
end
