# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
# temp fix for NoMethodError: undefined method `last_comment'
 # remove when fixed in Rake 11.x
Rake::Application.send :include, TempFixForRakeLastComment
Rails.application.load_tasks
