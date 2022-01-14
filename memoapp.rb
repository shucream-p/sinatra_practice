# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'pg'

connection = PG.connect(dbname: 'memo_db')

helpers do
  def h(text)
    ERB::Util.html_escape(text)
  end
end

get '/memos' do
  @memos = connection.exec('SELECT id, title FROM Memos')
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  # タイトルの入力がない場合に自動的に'No Title'を入れる処理
  params[:title] = 'No Title' if params[:title] == ''
  title = params[:title]
  contents = params[:contents]
  connection.exec('INSERT INTO Memos (title, contents) VALUES ($1, $2)', [title, contents])
  redirect '/memos'
end

get '/memos/:id' do
  @id = params[:id]
  @memo = connection.exec('SELECT title, contents FROM Memos WHERE id = $1', [@id])
  erb :show
end

delete '/memos/:id' do
  id = params[:id]
  connection.exec('DELETE FROM Memos WHERE id = $1', [id])
  redirect '/memos'
end

get '/memos/:id/edit' do
  @id = params[:id]
  @memo = connection.exec('SELECT title, contents FROM Memos WHERE id = $1', [@id])
  erb :edit
end

patch '/memos/:id' do
  params[:title] = 'No Title' if params[:title] == ''
  title = params[:title]
  contents = params[:contents]
  id = params[:id]
  connection.exec('UPDATE Memos SET title = $1, contents = $2 WHERE id = $3', [title, contents, id])
  redirect '/memos'
end
