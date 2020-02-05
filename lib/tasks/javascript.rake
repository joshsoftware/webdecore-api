# frozen_string_literal: true

require 'rake/minify'

Rake::Minify.new(:minify_single) do
  dir('app/javascript/packs/') do # we specify only the source directory
    add('app/javascript/packs/global_animation_data.min.js', 'global_animation_data.js') # the output file name is full path
  end
end
