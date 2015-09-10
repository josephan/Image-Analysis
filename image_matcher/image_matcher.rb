require 'RMagick'; include Magick
require 'benchmark'

require_relative('image_matcher_strategies')

# ImageMatcher performs a match between two images.
# * search_image: the "haystack" to search inside
# * template_image: the "needle" for which we are searching
# You also must provide the :strategy to use for matching.
class ImageMatcher

	attr_reader :search_image, :template_image
	attr_reader :match_x, :match_y, :benchmark
	attr_reader :search_cols, :search_rows
	attr_accessor :strategy, :verbose, :hightligh_match, :fuzz

	@@startegies = {}

	include ImageMatcherStrategies

	def initialize(options={})
		search_image = options[:search_image]
		template_image = options[:template_image]
		@strategy = options[:strategy]
		@verbose = options[:verbose] === false ? false : true
		@hightligh_match = options[:verbose] || false
		@fuzz = options[:fuzz] || 0.0
	end