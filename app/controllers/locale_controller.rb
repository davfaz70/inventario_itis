class LocaleController < ApplicationController
  include LocaleHelper
  def change_locale
    redirect_to root_path(locale: params[:set_locale]) 
  end
end
