# frozen_string_literal: true

# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

User.create!([{
               email: 'test1@gmail.com',
               password: 'testuser1',
               name: 'test user 1'
             },
              {
                email: 'test2@gmail.com',
                password: 'testuser2',
                name: 'test user 2'
              },
              {
                email: 'test3@gmail.com',
                password: 'testuser3',
                name: 'test user 3'
              }])
