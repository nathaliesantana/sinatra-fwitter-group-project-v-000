class TweetsController < ApplicationController

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect'/tweets'
      end
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

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end




end
