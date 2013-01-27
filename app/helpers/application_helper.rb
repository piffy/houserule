module ApplicationHelper

  #http://stackoverflow.com/questions/185965/how-do-i-change-the-title-of-a-page-in-rails
  #def page_title
  #  (@content_for_title + " &mdash; " if @content_for_title).to_s + 'My Cool Site'
  #end

  def set_locale
    extracted_locale = params[:locale] ||
        extract_locale_from_subdomain ||
        extract_locale_from_accept_language_header

    I18n.locale = (I18n::available_locales.include? extracted_locale.to_sym) ? extracted_locale : I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def extract_locale_from_subdomain
    request.host.split('.').first
  end

end
