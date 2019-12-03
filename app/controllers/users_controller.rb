class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
    end
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :"/users/show"
  end


end
