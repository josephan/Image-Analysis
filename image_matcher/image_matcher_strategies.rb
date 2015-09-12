# ImageMatcherStrategies contains methods that define the
# match strategies that can be used by ImageMatcher.
module ImageMatcherStrategies
	@@strategies = {
		'full' => :match_position_by_full_string,
		'rows' => :match_position_by_full_rows,
		'pixels' => :match_position_by_pixel_strings
	}

	private

	# Compare images by converting all image pixels to a string.
	def match_position_by_full_string
		t_width = template_image.columns
		t_height = template_image.rows
		t_pixels = template_image.export_pixels_to_str(0, 0, t_width, t_height)

		catch :found_match do
			search_rows.times do |y|
				search_cols.times do |x|

					puts "Checking search image at #{x}, #{y}" if @verbose
					s_pixels = search_image.export_pixels_to_str(x, y, t_width, t_height)
					
					if s_pixels == t_pixels
						self.match_result = x, y
						throw :found_match
					end
				end
			end
		end

		return match_result
	end

	# Compare images by converting first line pixels in each image
	# to a string. Checks next line only if first line matches.
	def match_position_by_pixel_rows
	end

	# Compare images by converting first pixel in each image
	# to a string. Checks next pixel only if first pixel matches.
	def match_position_by_pixel_strings
	end
end