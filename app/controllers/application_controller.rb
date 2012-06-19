class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def self.version
    '0.1'
  end

  def self.hostname
    'afternoon-spring-6294.herokuapp.com'
  end
end
