class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.new(params)
      @tweet.user = Helpers.current_user(session)
      if !@tweet.content.empty?
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end

    else
      redirect "/users/login"
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      if !@tweet.content.empty?
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
      end
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
