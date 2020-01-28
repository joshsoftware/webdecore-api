# frozen_string_literal: true

require 'rake/minify'

Rake::Minify.new(:minify_single) do
  dir('lib/assets/javascript') do # we specify only the source directory
    add('public/output3.js', ENV['file']) # the output file name is full path
  end
end
