require 'nokogiri'
require 'open-uri'

class IndexController < ApplicationController
  def index
    links = %w(betoffer/1/1211 betoffer/1/1103 betoffer/1/922)
    creator = SpiderCreator.new(links)
    @content = creator.generate

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content }
    end
  end
end