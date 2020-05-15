
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # show all action
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # show page to allow user to input info
  get '/articles/new' do
    erb :new
  end

  # create a new article
  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    # binding.pry
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.delete

    redirect to "/articles"
  end
end
