#!/usr/bin/ruby
#
# Dependencies:
# - dropbox_sdk
#

require 'optparse'
require 'dropbox_sdk'

file_name = nil
dropbox_token = nil

ARGV << '-h' if ARGV.empty?

OptionParser.new do |opts|
	opts.banner = "Usage: #{__FILE__} [options]"

	opts.on("-f", "--file FILE", String, "File to upload") do |f|
		file_name = f
	end

	opts.on("-t", "--token TOKEN", String, "Supply auth token directly instead of using $DROPBOX_TOKEN") do |t|
		dropbox_token = t
	end

	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end.parse!

dropbox_token = dropbox_token || ENV["DROPBOX_TOKEN"]

if dropbox_token.nil?
	puts "No auth token supplied"
	exit
end

if file_name.nil?
	puts "No file name supplied"
	exit
end

unless File.file?(file_name)
	puts "File does not exists"
	exit
end

begin
	client = DropboxClient.new(dropbox_token)

	file = open(file_name)

	response = client.put_file(File.basename(file.path), file)

	puts "uploaded:", response.inspect

rescue DropboxAuthError => err
	puts 'Failed Dropbox Auth: ' + err.message

end
