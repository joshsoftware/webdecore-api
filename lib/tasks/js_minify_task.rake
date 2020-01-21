# frozen_string_literal: true

require 'rake/minify'
Rake::Minify.new(:minify_single) do
  dir("lib/assets/javascript") do # we specify only the source directory
      add("public/output1.js","custom.js")# this file is not minified
  end
end
