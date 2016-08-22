require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
end

OUT_DIRECTORY = 'output'.freeze
RESULT_FILE_PREFIX = 'data_generator'.freeze

if ARGV[0].nil? or ARGV[0].strip == ''
  num_of_files = 1
else
  num_of_files = ARGV[0].to_i
end
#
(1..num_of_files).each do |num|
  (1..1000).each do |t|
    file = File.expand_path("../sample-s3.log", __FILE__)
    new_file = File.new("#{OUT_DIRECTORY}/#{RESULT_FILE_PREFIX}#{num}.log", 'a')
    open(file) do |f|
      data = f.read(1_000_000_000)
      new_file.write(data)
    end
    new_file.close
  end
  `gzip #{OUT_DIRECTORY}/#{RESULT_FILE_PREFIX}#{num}.log`
end
