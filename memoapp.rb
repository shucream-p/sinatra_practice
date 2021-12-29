# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'

memos = File.open('db/data_file.json') do |file|
          JSON.load(file)
        end

before do
  @memos = memos
end

helpers do
  def h(text)
    ERB::Util.html_escape(text)
  end
end

get '/memos' do
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  params[:title] = 'No Title' if params[:title] == ''
  memos[SecureRandom.uuid] = params

  File.open('db/data_file.json', 'w') do |file|
    JSON.dump(memos, file)
  end

  redirect '/memos'
end

get '/memos/:id' do
  @id = params[:id]
  erb :show
end

delete '/memos/:id' do
  memos.delete(params[:id])

  File.open('db/data_file.json', 'w') do |file|
    JSON.dump(memos, file)
  end

  redirect '/memos'
end

get '/memos/:id/edit' do
  @id = params[:id]
  erb :edit
end

patch '/memos/:id' do
  params[:title] = 'No Title' if params[:title] == ''
  memos[params[:id]] = { 'title' => params[:title], 'contents' => params[:contents] }

  File.open('db/data_file.json', 'w') do |file|
    JSON.dump(memos, file)
  end

  redirect '/memos'
end
