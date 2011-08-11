module SessionsHelper

  def sign_in(player)
    cookies.permanent.signed[:remember_token] = [ player.id, player.password_salt ]
    self.current_player = player
  end

  def current_player=(player)
    @current_player = player
  end

  def current_player
    @current_player ||= player_from_remember_token
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_player = nil
  end

  def signed_in?
    !current_player.nil?
  end

  def authenticate
    deny_access unless signed_in?
  end

  def admin_player
    redirect_to root_path unless admin_player?
  end

  def admin_player?
    return current_player.admin if current_player
    false
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_location
  end

private

  def player_from_remember_token
    Player.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil,nil]
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_location
    session[:return_to] = nil
  end

end