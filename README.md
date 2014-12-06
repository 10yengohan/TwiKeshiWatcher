TwiKeshiWatcher
===================
#これなに
タイムラインでツイ消しが発生した場合にその内容をログに保存し、「ツイ消しを見た」とツイートするスクリプトです。
#必要なもの
* RubyGems
* Twitter Ruby Gem https://github.com/sferik/twitter
* TweetStream Gem https://github.com/tweetstream/tweetstream
* その他もろもろ
#つかいかた
起動するとdeleted.logに消されたツイートの時間・ユーザID・スクリーンネーム・本文が保存されます。
#注意
本スクリプトが起動する前にツイートされた内容がツイ消しされた場合、消されたツイートの本文は取得できません。
