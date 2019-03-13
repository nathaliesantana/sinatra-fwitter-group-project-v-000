class TweetsController < ApplicationController

  post '/tweets' do
    if logged_in?
      @tweet = current_user.tweets.create(content: params[:content])
      redirect'/tweets'
    else
      redirect'/login'
    end
  end

  get '/tweets' do

    if !!logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end





end
