# frozen_string_literal: true

class RenameRequest < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :requested_id, :requestee_id
  end
end
