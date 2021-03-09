class CreateBrews < ActiveRecord::Migration[5.2]
    def change
        create_table :brews do |t|
            t.string :name
            t.string :draft
            t.integer :user_id
        end
    end
end