#!/usr/bin/env ruby
require 'date'

allow_type_report = ['account', 'activity', 'position', 'security']
tree = Hash.new {|hash, key| hash[key] = Hash.new(&hash.default_proc)}

Dir.foreach(".") do |f|
	next unless f.match(/^*_*_.*(txt)/)
	info_file = f.capitalize.split('_')
	account, type_report, date = info_file[0], info_file[1], Date.parse(File.basename(info_file[2].to_s, ".*").to_s).strftime("%Y-%m-%d")
	if allow_type_report.include? type_report
		tree[account][date] = [] if tree[account][date] == {}
		tree[account][date].push(type_report).sort!
	end
end

puts tree