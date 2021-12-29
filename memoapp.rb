# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'

memos = JSON.parse(File.read('db/data_file.json'))

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
  # タイトルの入力がない場合に自動的に'No Title'を入れる処理
  params[:title] = 'No Title' if params[:title] == ''
  # ハッシュmemosの中で、キーにランダムに生成された文字列、値にparams（メモのタイトル、内容）をそれぞれ持つ
  memos[SecureRandom.uuid] = params

  File.open('db/data_file.json', 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end

get '/memos/:id' do
  @id = params[:id]
  erb :show
end

delete '/memos/:id' do
  # memosのキーを指定して、要素（メモ）を削除する
  memos.delete(params[:id])

  File.open('db/data_file.json', 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end

get '/memos/:id/edit' do
  @id = params[:id]
  erb :edit
end

patch '/memos/:id' do
  params[:title] = 'No Title' if params[:title] == ''
  # memosのキーを指定して、値（メモ）の更新を行う
  memos[params[:id]] = { 'title' => params[:title], 'contents' => params[:contents] }

  File.open('db/data_file.json', 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end
