
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
# Allow access to / 
  get '/' do
  end

  get '/articles'do
    @articles= Article.all 

    erb :index
  end
# Allows the user to access the form on :new.erb
  get '/articles/new' do
    # On this page we'll initialize a new object, but we won't post it until later
    @article= Article.new
    erb :new
  end

  # Allows the user to create a new object and post it back to the server/DB
  post '/articles' do
    # Use the params entered in the form to creae the object
    @article= Article.create(params)
    # Redirect to the article we just created
    redirect to "/articles/#{ @article.id}"

  end

  # Show the article that we just created
  get '/articles/:id' do
    @article= Article.find(params[:id])
    erb :show
  end
  # EDIT!
  get '/articles/:id/edit' do
    # Here we need to create an instance variable and set it equal to specific instance with the ID that is inserted into the URL
    @article= Article.find(params[:id])
    erb :edit
  end
  #Update!
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

    #destroy
    delete "/articles/:id" do
      Article.destroy(params[:id])
      redirect to "/articles"
    end
end
