class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def self.version
    '0.2.6'
  end

  #Added in order to have working links in development environment
  def self.hostname
    if Rails.env == 'production'
      #'afternoon-spring-6294.herokuapp.com'
      'www.houserule.it'
    else
      'localhost:3000'
    end
  end
end
