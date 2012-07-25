module SessionsHelper
  
  def sign_in(user) #our main helper
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in? # if current_user==true(see double cancelation), true
    !current_user.nil?
  end

  def current_user=(user) #allows current_user.name usage in views
    @current_user = user
  end

  def current_user #define @current_user if not previously defined
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end


  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


end
