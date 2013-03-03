require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

class Blog
  include DataMapper::Resource
  property :id, Serial
  property :title, Text
  property :content, Text
  property :date, Date
end

DataMapper.finalize.auto_upgrade!


get '/' do 
  @blogs = Blog.all order: :date.desc
  erb :index
end

post '/' do
  blog = Blog.new
  blog.title = params[:title]
  blog.content = params[:content]
  blog.date = DateTime.now
  blog.save
  redirect '/'
end

get '/:id' do
  @blog = Blog.get params[:id]
  erb :view   
end