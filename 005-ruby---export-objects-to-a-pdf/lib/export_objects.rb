require 'prawn'

module ExportObjects

	class Trial
		def self.export content
			file_name = Time.now.to_s + "_file.txt"
			models_path = File.join(Rails.root, 'tmp', 'pdfs')
			file_path = File.join(models_path, file_name)

			File.open(file_path, 'w') do |file|
				file.write(content)
			end

			puts "File created at: #{file_path}"
		end
	end
end