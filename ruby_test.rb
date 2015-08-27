#!/usr/bin/env ruby

type_report = ['account', 'activity', 'position', 'security']

tree = Hash.new {|hash, key| hash[key] = Hash.new(&hash.default_proc)}

Dir.foreach(".") do |f|
	info_file = f.capitalize.split('_')
	if type_report.include? info_file[1]
		tree[info_file[0]][info_file[1]] = [] if tree[info_file[0]][info_file[1]] == {}
		tree[info_file[0]][info_file[1]].push(info_file[2]).sort!
	end
end

puts tree