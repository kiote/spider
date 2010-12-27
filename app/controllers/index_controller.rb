require 'nokogiri'
require 'open-uri'

class IndexController < ApplicationController
  def index
    links = %w('betoffer/1/1211', 'betoffer/1/1103')
    creator = SpiderCreator.new('betoffer/1/922')
    @content = creator.generate

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content }
    end
  end
end