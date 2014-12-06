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
timeline = Logger.new("timeline.log")

#稼働開始
Streaming_client.on_inited do
  puts 'Connected successfully...'
end
tweets = Hash.new("none")
#ツイ消しだ！
Streaming_client.on_delete do |status_id, user_id|
  screen_name = REST_client.user(user_id).screen_name
  REST_client.update("ツ")
  if tweets["#{status_id}"] != "none" then
    puts "--- DELETED ---"
    puts tweets["#{status_id}"].user.screen_name
    puts tweets["#{status_id}"].user.id
    puts tweets["#{status_id}"].id
    puts tweets["#{status_id}"].text

    deleted.info "--- DELETED ---"
    deleted.info tweets["#{status_id}"].user.screen_name
    deleted.info tweets["#{status_id}"].user.id
    deleted.info tweets["#{status_id}"].id
    deleted.info tweets["#{status_id}"].text
  else
    puts "--- DELETED ---"
    puts screen_name
    puts user_id
    puts status_id
    puts "text unknown"
    
    deleted.info "--- DELETED ---"
    deleted.info screen_name
    deleted.info user_id
    deleted.info status_id
    deleted.info "text unknown"
  end
  deleted.info("\n\n\n")
end

#タイムライン取得
Streaming_client.userstream do |object|
  puts "recieve a tweet / class: #{object.class}"
  puts object.text
  tweets["#{object.id}"] = object
  timeline.info("STATUS: #{object.class}")
  timeline.info("STATUS: #{object.user.screen_name}")
  timeline.info("STATUS: #{object.user.id}")
  timeline.info("STATUS: #{object.text}")
  timeline.info("STATUS: #{object.id}")
  timeline.info("\n\n\n")
end
