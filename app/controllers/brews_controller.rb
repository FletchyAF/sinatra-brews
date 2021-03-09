class BrewsController < ApplicationController

    get '/brews' do
        redirect_if_not_logged_in
        @items = Item.all
        erb :'brews/index'
    end

    get '/brews/new' do
        redirect_if_not_logged_in
        erb :'/brews/new'
    end

    post '/brews' do
        redirect_if_not_logged_in
        
        brew = current_user.brews.create(params[:item])
        if brew.valid?
            redirect "brews/#{brew.id}"
        else
            redirect '/brewss/new'
        end
    end
        
    get '/brews/:id' do
        redirect_if_not_logged_in
        set_brew
        if !@brew
            redirect '/brew'
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
            erb :'items/show'
        end
    end
end