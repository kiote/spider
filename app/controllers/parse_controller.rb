require 'nokogiri'
require 'open-uri'
require 'yaml'

class ParseController < ApplicationController

  before_filter :configure_app, :set_default_response_format

  def index
    @config['services'].each do |service|
      next if service['name'] != params['resource']
      parser = service['class']
      creator = SpiderCreator.new(service['url'], service['get'], parser, service['subdomain'])
      @content = creator.generate
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @content }
    end
  end

  protected

    def configure_app
      @config = YAML::load(File.open("#{Rails.root}/config/spider.yml"))
    end

    def set_default_response_format
      request.format = 'xml'.to_sym if params[:format].nil?
    end
end