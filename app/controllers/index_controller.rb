require 'nokogiri'
require 'open-uri'
require 'yaml'

class IndexController < ApplicationController

  before_filter :configure_app

  def index
    params['name']
#    links = %w(
#      betoffer/1/1211
#      betoffer/1/1103
#      betoffer/1/922
#      betoffer/1/1613
#      betoffer/1/1645
#      betoffer/1/916
#      betoffer/1/3554
#      betoffer/1/4636
#      betoffer/1/2580
#      betoffer/1/5174
#      betoffer/1/5194
#    )
#    creator = SpiderCreator.new(links)
#    @content = creator.generate
#
#    respond_to do |format|
#      format.html
#      format.xml  { render :xml => @content }
#    end
    services = @config['services'].each |service|
      print service
    end
    @content = @config['services']
  end

  def configure_app
    @config = YAML::load(File.open("#{Rails.root}/config/spider.yml"))
  end
end