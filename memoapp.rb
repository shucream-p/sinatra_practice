# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'pg'

class DB
  @connection = PG.connect(dbname: 'memo_db')

  class << self
    # デフォルトでは全行、idの指定があればその行だけ読み込むメソッド
    def read(id: false)
      if id
        @connection.exec('SELECT * FROM Memos WHERE id = $1', [id])
      else
        @connection.exec('SELECT * FROM Memos')
      end
    end

    def create(title, contents)
      @connection.exec('INSERT INTO Memos (title, contents) VALUES ($1, $2)', [title, contents])
    end

    def delete(id)
      @connection.exec('DELETE FROM Memos WHERE id = $1', [id])
    end

    def update(title, contents, id)
      @connection.exec('UPDATE Memos SET title = $1, contents = $2 WHERE id = $3', [title, contents, id])
    end
  end
end

helpers do
  def h(text)
    ERB::Util.html_escape(text)
  end
end

get '/memos' do
  @memos = DB.read
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  # タイトルの入力がない場合に自動的に'No Title'を入れる処理
  params[:title] = 'No Title' if params[:title] == ''
  DB.create(params[:title], params[:contents])
  redirect '/memos'
end

get '/memos/:id' do
  @memo = DB.read(id: params[:id])
  @id = params[:id]
  erb :show
end

delete '/memos/:id' do
  DB.delete(params[:id])
  redirect '/memos'
end

get '/memos/:id/edit' do
  @memo = DB.read(id: params[:id])
  @id = params[:id]
  erb :edit
end

patch '/memos/:id' do
  params[:title] = 'No Title' if params[:title] == ''
  DB.update(params[:title], params[:contents], params[:id])
  redirect '/memos'
end
