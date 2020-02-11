# User Data
user1 = User.create('first_name' => 'Preeti',
                    'last_name' => 'Dantkale',
                    'contact_number' => '8983521111',
                    'email' => 'preeti.dantkale@joshsoftware.com',
                    'password' => '888888',
                    'role' => 'admin',
                    'confirmed_at' => DateTime.now)

user2 = User.create('first_name' => 'Yash',
                    'last_name' => 'M',
                    'contact_number' => '7123456789',
                    'email' => 'yash11@gmail.com',
                    'password' => '123456',
                    'role' => 'user',
                    'confirmed_at' => DateTime.now)

# Category Data
festivals = Category.create('category_name' => 'Festivals',
                            'category_description' => 'Checkout all festive animations',
                            'picture' => File.open('public/Images/Festivals.png'),
                            'primarycategory_id' => nil)

diwali = Category.create('category_name' => 'Diwali',
                         'category_description' => 'Happy Diwali',
                         'picture' => File.open('public/Images/diyas.jpg'),
                         'primarycategory_id' => festivals.id)

christmas = Category.create('category_name' => 'Christmas',
                            'category_description' => 'Merry Christmas',
                            'picture' => File.open('public/Images/christmas.jpeg'),
                            'primarycategory_id' => festivals.id)

sports = Category.create('category_name' => 'Sports',
                         'category_description' => 'Check out Sport animations',
                         'picture' => File.open('public/Images/sports.jpeg'),
                         'primarycategory_id' => nil)

# Animation Data
diwali_file = File.open('public/happy-diwali.json').read
diwali_json = diwali_file.as_json
christmas_file = File.open('public/deer.json').read
christmas_json = christmas_file.as_json

diwali_animation = AnimationData.create('animation_name' => 'Diwali-2020',
                                        'animation_price' => 500.0,
                                        'picture' => File.open('public/Images/diwalidiya.jpeg'),
                                        'category_id' => diwali.id,
                                        'animation_json' => diwali_json)

christmas_animation = AnimationData.create('animation_name' => 'Christmas Deer',
                                           'animation_price' => 350.0,
                                           'picture' => File.open('public/Images/christmas_deer.jpeg'),
                                           'category_id' => christmas.id,
                                           'animation_json' => christmas_json)

# User Animation Data
UserAnimation.create('start_date' => 'Sat, 22 Feb 2020',
                     'end_date' => 'Sat, 29 Feb 2020',
                     'user_id' => user2.id,
                     'animation_data_id' => diwali_animation.id,
                     'status' => 'active',
                     'location' => 'Maharashtra')

UserAnimation.create('start_date' => 'Fri, 21 Feb 2020',
                     'end_date' => 'Sat, 29 Feb 2020',
                     'user_id' => user2.id,
                     'animation_data_id' => christmas_animation.id,
                     'status' => 'active',
                     'location' => 'Maharashtra')
