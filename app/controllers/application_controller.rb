# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb:'/index'
  end

  post '/signup' do
    # binding.pry
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect'/signup'
    else
      @user = User.create(:username => params[:username])
      @user.email = params['email']
      @user.password = params['password']
      @user.save
      session[:user_id] = @user.id
      redirect'/tweets'
    end

  end

  post '/login' do
    redirect'tweets'
  end

  get '/signup' do
    if !logged_in?
      erb:'users/create_user'
    else
      redirect'/tweets'
    end
  end

  get '/login' do
    if !!logged_in?

      redirect'/tweets'
    else
      erb:'/users/login'
    end
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user = User.find_by(id: session[:user_id])
    end


  end

  get '/tweets' do
   erb :'tweets/tweets'
  end



end
