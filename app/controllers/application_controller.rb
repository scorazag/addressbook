class ApplicationController < ActionController::API
    def index
        render html: "hola mundo"
    end
end
