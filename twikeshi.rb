# coding: utf-8
require 'rubygems'
require 'twitter'
require 'tweetstream'
require 'logger'

CONSUMER_KEY = "目を閉じれば"
CONSUMER_SECRET = "億千の星"
OAUTH_TOKEN = "一番光る"
OAUTH_TOKEN_SECRET = "お前がいる"

#Streaming API用
TweetStream.configure do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.oauth_token         = OAUTH_TOKEN
  config.oauth_token_secret  = OAUTH_TOKEN_SECRET
  config.auth_method        = :oauth
end

#REST API用
REST_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

Streaming_client = TweetStream::Client.new

#ログを書く
deleted = Logger.new("deleted.log")

#稼働開始
Streaming_client.on_inited do
  puts 'Connected successfully...'
end

#ツイ消しだ！
Streaming_client.on_delete do |status_id, user_id|
  screen_name = REST_client.user(user_id).screen_name
  deleted.info("DELETED: status_id: #{status_id}, user_id: #{user_id}, screen_name: #{screen_name}")
  puts "DELETED: status_id: #{status_id}, user_id: #{user_id}, screen_name: #{screen_name}"
  REST_client.update("@#{screen_name} ツイ消しを見た")
end
