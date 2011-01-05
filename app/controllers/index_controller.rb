require 'nokogiri'
require 'open-uri'
require 'yaml'

class IndexController < ApplicationController

  before_filter :configure_app

  def index
    params['name']
    @config['services'].each do |service|
      class_name = service['class']
      creator = eval(class_name).new(service['get'])
      @content = creator.generate
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @content }
    end
  end

  def configure_app
    @config = YAML::load(File.open("#{Rails.root}/config/spider.yml"))
  end
end