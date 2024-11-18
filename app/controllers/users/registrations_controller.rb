# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only:[:edit, :update]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      if resource.profile_picture.attached?
        puts "El usuario ya tiene una imagen de perfil adjunta."
      else
        default_image_path = Rails.root.join("public/default.jpeg")
        begin
          resource.profile_picture.attach(
            io: File.open(default_image_path),
            filename: "default.jpeg",
            content_type: "image/jpeg"
          )
          puts "Se ha asignado una imagen de perfil predeterminada."
        rescue => e
          puts "Error al adjuntar la imagen predeterminada: #{e.message}"
        end
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  
  def update
    super do |resource|
      if resource.profile_picture.blank?
        # Si no hay imagen de perfil adjunta y el usuario no tiene una imagen existente
        if resource.profile_picture.attached?
          puts "El usuario ya tiene una imagen de perfil adjunta."
        else
          default_image_path = Rails.root.join("public/default.jpeg")
          begin
            resource.profile_picture.attach(
              io: File.open(default_image_path),
              filename: "default.jpeg",
              content_type: "image/jpeg"
            )
            puts "Se ha asignado una imagen de perfil predeterminada."
          rescue => e
            puts "Error al adjuntar la imagen predeterminada: #{e.message}"
          end
        end
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def set_user
    @user = current_user
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_picture])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :profile_picture])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
