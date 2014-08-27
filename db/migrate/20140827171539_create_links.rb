class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string   :link
      t.integer  :vote
      t.integer  :rating
      t.datetime :date
    end
  end
end
