class CreateAdminRates < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_rates do |t|
      t.decimal :rate
      t.datetime :finished_at

      t.timestamps
    end
  end
end
