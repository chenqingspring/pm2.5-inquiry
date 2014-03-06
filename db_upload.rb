#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'

bucket_name = 'pm25-inquiry-db'
file_name = "mongodump#{ENV['TRAVIS_BUILD_NUMBER']}.tar.gz"
system 'mongodump'
system "tar czvf #{file_name} dump"

s3 = AWS::S3.new
puts 'get an instance of the S3 interface.'

key = File.basename(file_name)
puts "object key is #{key}"
puts "create bucket #{bucket_name}"
bucket = s3.buckets[bucket_name]
unless bucket.exists?
  bucket = s3.buckets.create(bucket_name)
end
puts "bucket #{bucket_name} is created "
puts "uploading object"
bucket.objects[key].write(:file => file_name)
puts "Object file #{file_name} has uploaded to #{bucket_name}"