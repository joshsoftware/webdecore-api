# frozen_string_literal: true

require 'rake/minify'

Rake::Minify.new(:minify_single) do
  dir('app/javascript/packs/') do # we specify only the source directory
    add('app/javascript/packs/animation.min.js', 'start.js') # the output file name is full path
  end
end
