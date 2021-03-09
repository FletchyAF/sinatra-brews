class UsersControll < ApplicationController

    get 'signup' do
        if session[:id]
            redirect to "/users#{[session[:id]}"
        end
        erb :'/users/signup'
    end

    post 'signup' do
        user = User.create(params[:user])
        if user.id
            session[:id] = user.id
            rediect to "/users/#{user.id}"
        else
            erb :'/users/signup'
        end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
            @user = User.find_by(id: params[:id])
            @items = @user.items
            erb :'users/show'
    end

    get '/login' do
        if session[:user_id]
          redirect "/users/#{session[:user_id]}"
        end
        erb :'users/login'
      end
    
      post '/login' do
        user = User.find_by(username: params[:user][:username])
    
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          flash[:message] = "login successful!"
          redirect "/users/#{user.id}"
        else
          @errors = ["Invalid Login"]
          erb :'users/login'
        end
      end
    
      get '/logout' do
        session.clear
        redirect '/login'
      end
    
      get '/users' do
        redirect_if_not_logged_in
        @users = User.all
        erb :'users/index'
    
      end
    
    
    end