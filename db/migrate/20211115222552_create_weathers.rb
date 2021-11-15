class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.string :base_url
      t.string :api_key

      t.timestamps
    end
  end
end
