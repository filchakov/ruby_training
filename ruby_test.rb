#!/usr/bin/env ruby
require 'date'
require 'json'

ALLOW_TYPE_REPORT = ['account', 'activity', 'position', 'security']
DATE_FORMAT = "%Y-%m-%d"

tree = Hash.new {|hash, key| hash[key] = Hash.new(&hash.default_proc)}

Dir.glob("*txt").sort.each { |f|
	next unless f.match(/^*_*_.*(txt)/)
	info_file = f.capitalize.split('_')
	account, type_report, date = info_file[0], info_file[1], Date.parse(File.basename(info_file[2].to_s, ".*").to_s).strftime(DATE_FORMAT)
	
	if ALLOW_TYPE_REPORT.include? type_report
		tree[account][date] = [] if tree[account][date] == {}
		tree[account][date].push(type_report).sort!
	end
}

puts tree.to_json