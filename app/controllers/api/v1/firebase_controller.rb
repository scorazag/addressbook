class Api::V1::FirebaseController < ApplicationController
    def index
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        response = firebase.get("ContactosOrganizacion")
        render json: {status: 'SUCCESS', message:'Loading', data:response.body},status: :ok
    end
    def show
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        contactos = organizacion_params
        user = User.where(organizacion_id: contactos[:id_organizacion])
        if user
            idor ="ContactosOrganizacion/#{contactos[:id_organizacion]}"
            response = firebase.get(idor)
            if response.success?
                render json: {status: 'SUCCESS', message:'Contactos Encontrados',data:response.body},status: :ok
            else
                render json: {status: 'Fail', message:'Contacto no ecnontrados',data:response.code},status: :unprocessable_entity
            end
        else
            render json: {status: 'Fail', message:'Usuario sin permisos en la organizacion',data:response.code},status: :unprocessable_entity
        end
    end

    def create
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        contactos = contactos_params
        user = User.where(organizacion_id: contactos[:id_organizacion])
        if user
            idor ="ContactosOrganizacion/#{contactos[:id_organizacion]}"
            response = firebase.push(idor,{:id_organizacion => contactos[:id_organizacion],:nombre =>contactos[:nombre],:telefono=>contactos[:telefono],:email=>contactos[:email]})
            if response.success?
                render json: {status: 'SUCCESS', message:'Contacto guardado',data:response.body},status: :ok
            else
                render json: {status: 'Fail', message:'Contacto no guardado',data:response.code},status: :unprocessable_entity
            end
        else
            render json: {status: 'Fail', message:'Usuario sin permisos en la organizacion',data:response.code},status: :unprocessable_entity
        end
    end
    def destroy
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        orga = deleteContacto_params     
        user = User.where(organizacion_id: contactos[:id_organizacion])
        if user
            idor ="ContactosOrganizacion/#{contactos[:id_organizacion]}"
            response = firebase.get(idor)
            ary = Array.new
            response.body.each do |child|
                if child[1]["nombre"] == contactos[:nombre]
                        ary.append(child[0])
                else
                end
            end
            ary.each do |n|
                f = idor +"/"+n
                responseF = firebase.delete(f)
                if response.success?
                    render json: {status: 'SUCCESS', message:'Contacto guardado',data:response.body},status: :ok
                else
                    render json: {status: 'Fail', message:'Contacto no guardado',data:response.code},status: :unprocessable_entity
                end
            end
        else
            render json: {status: 'Fail', message:'Usuario sin permisos en la organizacion',data:response.code},status: :unprocessable_entity
        end
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        render json: {status: 'SUCCESS', message:'Deleted', data:organizacion},status: :ok
        contactos = contactos_params
        idor ="ContactosOrganizacion/#{contactos[:id_organizacion]}"
        response = firebase.push(idor)
        if response.success?
            render json: {status: 'SUCCESS', message:'Contacto guardado',data:response.body},status: :ok
        else
            render json: {status: 'Fail', message:'Contacto guardado',data:response.code},status: :ok
        end
    end

    def update
        firebase_url    = 'https://addresbook-f71c0-default-rtdb.firebaseio.com/'
        firebase_secret = 'vqJ9vzNQSqywhExkGH64yCsV0gZm8Cu1O5IUhbsV'
        firebase = Firebase::Client.new(firebase_url, firebase_secret)
        orga = contactos_params     
        user = User.where(organizacion_id: contactos[:id_organizacion])
        if user
            idor ="ContactosOrganizacion/#{contactos[:id_organizacion]}"
            response = firebase.get(idor)
            ary = Array.new
            response.body.each do |child|
                if child[1]["nombre"] == contactos[:nombre]
                        puts "encontrado"
                        ary.append(child[0])
                else
                end
            end
            ary.each do |n|
                f = idor +"/"+n
                responseF = firebase.update(f,{:nombre =>contactos[:nombre],:telefono=>contactos[:telefono],:email=>contactos[:email]})
                if response.success?
                    render json: {status: 'SUCCESS', message:'Contacto guardado',data:response.body},status: :ok
                else
                    render json: {status: 'Fail', message:'Contacto no guardado',data:response.code},status: :unprocessable_entity
                end
            end
        else
            render json: {status: 'Fail', message:'Usuario sin permisos en la organizacion',data:response.code},status: :unprocessable_entity
        end
    end


    private
    def contactos_params
        params.permit(:id_organizacion,:nombre,:telefono,:email,:user_id)
    end

    def organizacion_params
        params.permit(:id_organizacion,:user_id)
    end

    def deleteContacto_params
        params.permit(:id_organizacion,:user_id,:nombre)
    end

end