class UsersController < ApplicationController

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
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/signup' do
    if !logged_in?
      erb:'users/create_user'
    else
      redirect'/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb:'/users/login'
    else
      redirect'/tweets'
    end
  end

  get '/logout' do

    if !!logged_in?
      session.destroy
      redirect'/login'
    else
      redirect'/'
    end
    
  end

end
