# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :story_text, default: ''
      t.references :user
      t.timestamps
    end
  end
end
