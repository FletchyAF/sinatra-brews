class BrewsController < ApplicationController

    get '/brews' do
        redirect_if_not_logged_in
        @brews = Brew.all
        erb :'brews/index'
    end

    get '/brews/new' do
        redirect_if_not_logged_in
        erb :'/brews/new'
    end

    post '/brews' do
        redirect_if_not_logged_in
        brew = Brew.create(params[:brew])
        user = User.find_by(id: session[:user_id])
        user.brews << brew
        redirect "/brews/#{brew.id}"
    end
        
    get '/brews/:id' do
        redirect_if_not_logged_in
        set_brew
        if !@brew
            redirect '/brews'
        end
        erb :'/brews/show'
    end

    get '/brews/:id/edit' do
        redirect_if_not_logged_in
        set_brew
        redirect_if_not_brewmonger(@brew)
        erb :'brews/edit'
    end

    patch '/brews/:id' do
        redirect_if_not_logged_in
        set_brew
        if check_brewmonger(@brew)
            @brew.update(params[:brew])
        end
        erb :'/brews/show'
    end

    delete '/brews/:id' do
        redirect_if_not_logged_in
        set_brew
        if check_brewmonger(@brew)
            @brew.delete
            redirect to '/brews'
        else
            erb :'brews/show'
        end
    end
end