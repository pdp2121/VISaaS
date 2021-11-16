class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.string :city
      t.string :current_temperature
      t.string :current_pressure
      t.string :current_humidity
      t.string :description

      t.timestamps
    end
  end
end
