class TweetsController < ApplicationController

  get '/tweets' do
    @user = @current_user
    if !!logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end



end
