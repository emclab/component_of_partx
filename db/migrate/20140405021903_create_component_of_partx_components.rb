class CreateComponentOfPartxComponents < ActiveRecord::Migration
  def change
    create_table :component_of_partx_components do |t|
      t.integer :part_id
      t.string :name
      t.text :spec
      t.integer :last_updated_by_id
      t.integer :qty
      t.string :unit
      t.date :production_start_date
      t.date :production_finish_date

      t.timestamps
    end
  end
end
