namespace :demo do
  desc "Demo running via rake tasks"
  task say_hello: :environment do
    puts "Hello Rake"
  end
end
