require 'nokogiri'
require 'open-uri'

class IndexController < ApplicationController
  def index
    creator = SpiderCreator.new('betoffer/1/1211')
    @content = creator.generate

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content }
    end
  end
end