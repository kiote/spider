$KCODE = 'u'
require 'jcode' 
class ApplicationController < ActionController::Base
  before_filter :set_default_response_format

  protected

    def set_default_response_format
      request.format = 'xml'.to_sym if params[:format].nil?
    end
  protect_from_forgery
end
