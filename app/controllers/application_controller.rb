class ApplicationController < Sinatra::Base

    configure do
        set(:views, 'app/views')
        set :public_folder, 'public'
        enable :sessions
        set :session_secret, 'placeholder'
    end

    get('/') do
        @name = "Brewster"
        erb :homepage
    end

    helpers do
        
        def current_user
            @user = User.find_by(id: session[:user_id])
        end

        def redirect_if_not_logged_in
            redirect to '/login' unless current_user
        end

        def check_brewmonger(obj)
            obj && obj.user == current_user
        end

        def redirect_if_not_brewmonger(obj)
            if !check_brewmonger(obj)
                redirect to '/brews'
            end
        end

        def set_brew
            @brew = Brew.find_by(id: params[:id])
        end
    end
end