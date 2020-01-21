# require 'rake/minify'

class JsMinfier

	def initialize(file_name)
		@file_name = file_name
	end

	def compress
		require 'rake'
		Rake::Task.clear
		WebDecor::Application.load_tasks
		Rake::Task['minify_single'].invoke
		# require 'rake/minify'

		# Rake::Minify.new(:minify_single) do

		#   dir("lib/assets/javascript") do # we specify only the source directory
		#     add("public/output.js", "custom.js") # the output file name is full path
		#   end

		# end

	end

end