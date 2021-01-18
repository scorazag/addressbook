class Api::V1::UserController < ApplicationController
    def index
        user = User.order('created_at Desc'); #Users
        render json: {status: 'SUCCESS', message:'Loading', data:user},status: :ok
    end

    def show
        user = User.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loading', data:user},status: :ok
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: {status: 'SUCCESS', message:'User Saved', data:user},status: :ok
        else
            render json: {status: 'ERROR', message:'User not Saved', data:user.errors},status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        User.destroy
        render json: {status: 'SUCCESS', message:'Deleted', data:user},status: :ok
    end

    def update
        user = User.find(params[:id])
        if User.update_attributes(User_params)
            render json: {status: 'SUCCESS', message:'Updated', data:user},status: :ok
        else
            render json: {status: 'ERROR', message:'Not Updated', data:user.errors},status: :unprocessable_entity
        end        
    end

    private
    def user_params
        params.permit(:nombre,:email,:password,:telefono,:organizacion_id)
    end

end