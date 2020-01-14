require 'rake/minify'
Rake::Minify.new(:minify_single) do
  dir("lib/assets/javascript") do # we specify only the source directory
    add("public/output.js", "custom.js") # the output file name is full path
  end
end