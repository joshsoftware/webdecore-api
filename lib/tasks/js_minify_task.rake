# frozen_string_literal: true

require 'rake/minify'
Rake::Minify.new(:minify_and_combine) do
  dir('lib/assets/javascript') do # we specify only the source directory
    group('lib/output-first-second.js') do
      add('custom.js') # this file is not minified
      add('minified_custom.js')
    end
  end
end
