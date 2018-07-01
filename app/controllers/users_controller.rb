class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do # creates a new user form
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      #if any of these fields are empty then redirect to /signup page
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])#creates new user with data from 'new' form
      session[:user_id] = @user.id
      redirect to '/tweets'
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
