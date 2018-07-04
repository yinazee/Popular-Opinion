require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do # creates a new user form

      erb :'users/new_user'
    end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      #if any of these fields are empty then redirect to /signup page
      redirect to '/signup'
    # elsif params[:username] && params[:password] != database of username & passwords
    #   flash[:message] = "Oops we can't find that account."
    #   redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password])#creates new user with data from 'new' form
      @user.save
      session[:user_id] = @user.id
      redirect to '/questions'
    end
  end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/questions'
      end
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/questions"
      else
        redirect to '/signup'
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/'
      end
    end


end
