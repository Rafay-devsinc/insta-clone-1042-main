# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :user_name, default: ''
      t.string :comment_text, default: ''
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
