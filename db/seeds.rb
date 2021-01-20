# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by(id: 1) do |admin|
 admin.email = "admin@admin"
 admin.password = "aaaaaa"
end

Genre.create!(
  name: 'ケーキ',
  is_active: 'true',
)
Product.create!(
  genre_id: 1,
  image_id: '1',
  name: 'ショートケーキ',
  description: '美味しいです。',
  price: 600,
  sales_status: 0,
)
Customer.create!(
  email: '1@1',
  password: 'aaaaaa',
  last_name: '山田',
  first_name: '太郎',
  last_name_kana: 'ヤマダ',
  first_name_kana: 'タロウ',
  zipcode: '1111111',
  address: 'tokyo',
  phone_number: '12345678900',
  is_active: 'true',
)