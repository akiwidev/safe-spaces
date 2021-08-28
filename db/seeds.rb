puts "Getting rid of previous seeds..."
Incident.destroy_all
User.destroy_all
Koban.destroy_all

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
  address: "Japan, Tokyo Prefecture東京都目黒区下目黒5丁目13番8",
  user: charlotte,
  conditions: "I live in an apartment block so I'll buzz you in to give you a place to feel a bit safer."
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
  address: "Japan, Tokyo Prefecture東京都品川区旗の台6丁目5番43",
  user: cheri,
  conditions: "Safe area! Ring my doorbell and I'll be more than happy to meet you outside."
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
  address: "Japan, Tokyo Prefecture東京都品川区西五反田4丁目27番10",
  user: lena,
  conditions: "Lively area so there's lots of people around. Feel free to climb the stairs to put some space between you and danger."
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
  address: "Japan, Tokyo Prefecture東京都品川区小山台1丁目4番2",
  user: noemi,
  conditions: "Quiet family area but well lit and lots of visibility, I'll meet you at the entrance."
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
  address: "Japan, Tokyo Prefecture東京都品川区荏原2丁目10番9",
  user: ope,
  conditions: "I'll let you in my house."
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
  address: "Japan, Tokyo Prefecture東京都品川区西中延3丁目7番3",
  user: sae,
  conditions: "You're welcome to come in and take as much time as you need!"
)
space6.photo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/spaces/space6.png')), filename: 'space6.png', content_type: 'image/jpg')

puts "Creating police station seeds..."
Koban.create!(
  name: "Meguro Ekimae Police Box",
  address: "だるま鮨, 上大崎2-15-19, 東京都, Tokyo Prefecture 141-0021, Japan"
)
Koban.create!(
  name: "Shimomeguro Police Box",
  address: "Japan, Tokyo Prefecture東京都目黒区下目黒1丁目6番18"
)
Koban.create!(
  name: "Aburamen Police Box",
  address: "Japan, Tokyo Prefecture東京都目黒区目黒4丁目26番7"
)
Koban.create!(
  name: "Honcho Area Safety Center",
  address: "Japan, Tokyo Prefecture東京都目黒区目黒本町5丁目15番4"
)
Koban.create!(
  name: "Metropolitan Police Ebara Police Station",
  address: "Japan, Tokyo Prefecture東京都品川区西中延1丁目3番24"
)
Koban.create!(
  name: "Ebara Police Station",
  address: "Japan, Tokyo Prefecture東京都品川区荏原6丁目19番10"
)
Koban.create!(
  name: "Edo Misaka Police Station",
  address: "Japan, Tokyo Prefecture東京都品川区荏原7丁目6番7"
)
Koban.create!(
  name: "Sensoku Sub Police Station",
  address: "Japan, Tokyo Prefecture東京都品川区小山7丁目12番3"
)

puts "All done! Created #{User.count} users, #{Space.count} spaces, and #{Koban.count} kobans."
