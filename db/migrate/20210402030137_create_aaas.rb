class CreateAaas < ActiveRecord::Migration[5.2]
  def change
    create_table :aaas do |t|

      t.timestamps
    end
  end
end
