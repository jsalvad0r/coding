class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_service
  before_action :set_user

  attr_accessor :service, :user

  def facebook
    handle_auth 'Facebook'
  end

  def handle_auth kind
    if service
      service.update(service_attrs)
    else
      user.services.create(service_attrs)
    end

    sign_in_and_redirect user, event: :authentication
    set_flash_message :notice, :success, kind: kind
  end

  private
  def set_user
    if user_signed_in?
      @user = current_user
    elsif service
      @user = service.user
    else
      @user = create_user
    end
  end

  def create_user
    User.create(
      email: auth.info.email,
      nickname: auth.info.name,
      fname: auth.info.first_name,
      lname: auth.info.last_name,
      photo: auth.info.image,
      address: auth.extra.raw_info.location,
      password: Devise.friendly_token[0,20]
    )
  end

  def set_service
    @service = Service.where(provider: auth.provider, uid: auth.uid).first
  end

  def service_attrs
    expires_at = auth.credentials.expires_at ? Time.at(auth.credentials.expires_at) : nil
    {
      provider: auth.provider,
      uid: auth.uid,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      expires_at: expires_at
    }
  end

  def auth
    request.env["omniauth.auth"]
  end
end