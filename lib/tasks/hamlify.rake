
# frozen_string_literal: true
require 'html2haml/html'
namespace :hamlify do
  desc 'Convert ERB to HAML'
  task convert: :environment do
    Dir["#{Rails.root}/app/views/**/*.erb"].each do |file_name|
      puts "hamlifying: #{file_name}"
      haml_file = file_name.gsub(/erb$/, 'haml')
      if !File.exist?(haml_file)
        erb_string = File.open(file_name).read

        haml_string = Html2haml::HTML.new(erb_string, erb: true).render

        f = File.new(haml_file, 'w')
        f.write(haml_string)

        File.delete(file_name)
      else
        puts 'Error!!!'
      end
    end
    puts 'Successfully Hamilyfied.'
  end
end
