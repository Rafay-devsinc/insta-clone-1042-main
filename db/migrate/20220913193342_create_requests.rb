# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :requested_id
      t.integer :requester_id

      t.timestamps
    end
  end
end
