class ApplicationController < ActionController::Base
   before_action :set_locale
  # ...
  protected

   def authorized_prof
     if current_prof.authorized == false
       flash[:danger] = "Devi essere autorizzato per accedere"
       redirect_back(fallback_location: root_path)
     end
   end
   #This method run when the user call an action that require the devise entity current_prof was authorized by admin

   private
   def set_locale
     I18n.locale = extract_locale || I18n.default_locale
   end
   def extract_locale
     parsed_locale = params[:locale]
     I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
   end
   def default_url_options
     { locale: I18n.locale }
   end

end
