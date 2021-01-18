class Api::V1::OrganizacionController < ApplicationController
    def index
        organizacion = Organizacion.order('created_at Desc'); #Organizacions
        render json: {status: 'SUCCESS', message:'Loading', data:organizacion},status: :ok
    end

    def show
        organizacion = Organizacion.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loading', data:organizacion},status: :ok
    end

    def create
        organizacion = Organizacion.new(organizacion_params)
        if organizacion.save
            render json: {status: 'SUCCESS', message:'Saved', data:organizacion},status: :ok
        else
            render json: {status: 'ERROR', message:'Not Saved', data:organizacion.errors},status: :unprocessable_entity
        end
    end

    def destroy
        organizacion = Organizacion.find(params[:id])
        organizacion.destroy
        render json: {status: 'SUCCESS', message:'Deleted', data:organizacion},status: :ok
    end

    def update
        organizacion = Organizacion.find(params[:id])
        if organizacion.update_attributes(organizacion_params)
            render json: {status: 'SUCCESS', message:'Updated', data:organizacion},status: :ok
        else
            render json: {status: 'ERROR', message:'Not Updated', data:organizacion.errors},status: :unprocessable_entity
        end        
    end

    private
    def organizacion_params
        params.permit(:nombre,:telefono,:direccion)
    end
end
