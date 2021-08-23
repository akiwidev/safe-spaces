puts "Getting rid of previous seeds..."
User.destroy_all

puts "Creating Charlotte..."

charlotte = User.create!(
  first_name: "charlotte",
  last_name: "demaret",
  email: "charlotte@lewagon.com",
  password: '123123',
  phone_num: "070 688 5764"
)
charlotte.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/charlotte.jpg')), filename: 'charlotte.jpg', content_type: 'image/jpg')

puts "Creating Charlotte's space..."
space1 = Space.create!(
  address: "1-chōme-35 Nakakasai, Edogawa City, Tokyo 134-0083",
  user: charlotte
)
space1.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space1.png')), filename: 'space1.png', content_type: 'image/jpg')

puts "Creating Cheri..."
cheri = User.create!(
  first_name: "cheri",
  last_name: "kennedy",
  email: "cheri@webdev.com",
  password: '123123',
  phone_num: "070 688 5764"
)
cheri.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/cheri.jpg')), filename: 'cheri.jpg', content_type: 'image/jpg')

puts "Creating Cheri's space..."
space2 = Space.create!(
  address: "6-chōme Edogawa, Edogawa City, Tokyo 134-0013",
  user: cheri
)
space2.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space2.png')), filename: 'space2.png', content_type: 'image/jpg')

puts "Creating Lena..."
lena = User.create!(
  first_name: "lena",
  last_name: "namiki",
  email: "lena@lewagon.com",
  password: '123123',
  phone_num: "070 688 5764"
)
lena.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/lena.jpg')), filename: 'lena.jpg', content_type: 'image/jpg')

puts "Creating Lena's space..."
space3 = Space.create!(
  address: "1-chōme-17 Nakakasai, Edogawa City, Tokyo 134-0083",
  user: lena
)
space3.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space3.png')), filename: 'space3.png', content_type: 'image/jpg')

puts "Creating Noemi..."
noemi = User.create!(
  first_name: "noemi",
  last_name: "ashizuka",
  email: "noemi@lewagon.com",
  password: '123123',
  phone_num: "070 688 5764"
)
noemi.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/noemi.jpg')), filename: 'noemi.jpg', content_type: 'image/jpg')

puts "Creating Noemi's space..."
space4 = Space.create!(
  address: "2-chōme-15 Higashikasai, Edogawa City, Tokyo 134-0084",
  user: noemi
)
space4.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space4.png')), filename: 'space4.png', content_type: 'image/jpg')

puts "Creating Ope..."
ope = User.create!(
  first_name: "ope",
  last_name: "dada",
  email: "ope@webdev.com",
  password: '123123',
  phone_num: "070 688 5764"
)
ope.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/ope.jpg')), filename: 'ope.jpg', content_type: 'image/jpg')

puts "Creating Ope's space..."
space5 = Space.create!(
  address: "2-chōme-2 Nakakasai, Edogawa City, Tokyo 134-0083",
  user: ope
)
space5.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space5.png')), filename: 'space5.png', content_type: 'image/jpg')

puts "Creating Sae..."
sae = User.create!(
  first_name: "sae",
  last_name: "shikiji",
  email: "sae@webdev.com",
  password: '123123',
  phone_num: "070 688 5764"
)
sae.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/sae.jpg')), filename: 'sae.jpg', content_type: 'image/jpg')

puts "Creating Sae's space..."
space6 = Space.create!(
  address: "7-chōme-10 Funabori, Edogawa City, Tokyo 134-0091",
  user: sae
)
space6.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space6.png')), filename: 'space6.png', content_type: 'image/jpg')

puts "All done! Created #{User.count} users, and #{Space.count} spaces."
