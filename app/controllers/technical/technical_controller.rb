class Technical::TechnicalController < ActionController::Base
    layout 'technical'
    before_action :authenticate_technical!
    before_action :authorized_technical
    before_action :set_i18n_locale_from_params
    # ...

    def authorized_technical
      if current_technical.authorized == false
        flash[:danger] = "Devi essere autorizzato per accedere"
        redirect_to root_path
      end
    end

    protected
      def set_i18n_locale_from_params
        if params[:locale]
          if I18n.available_locales.map(&:to_s).include?(params[:locale])
            I18n.locale = params[:locale]
          else
            flash.now[:notice] = "#{params[:locale]} translation not available"
            logger.error flash.now[:notice]
          end
        end
      end

      def default_url_options
        { locale: I18n.locale }
      end

end
