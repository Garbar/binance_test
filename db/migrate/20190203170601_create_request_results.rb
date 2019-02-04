class CreateRequestResults < ActiveRecord::Migration[5.2]
  def change
    create_table :request_results do |t|
      t.jsonb :raw_data
      t.jsonb :parsed_data, null: false, default: {}
      t.bigint :update_time

      t.timestamps
    end
    add_index :request_results, :raw_data, using: :gin
    add_index :request_results, :parsed_data, using: :gin
  end
end
