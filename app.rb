require 'sinatra'
require 'wei-backend'

on_text do
    "你发送了如下内容: #{params[:Content]}!!"
end

on_subscribe do
    "感谢您的订阅"
end

on_unsubscribe do
    "欢迎您再次订阅"
end
