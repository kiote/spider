require 'nokogiri'
require 'open-uri'

class IndexController < ApplicationController
  def index
    links = %w(
      betoffer/1/1211
      betoffer/1/1103
      betoffer/1/922
      betoffer/1/1613 
      betoffer/1/1645
      betoffer/1/916
      betoffer/1/3554
      betoffer/1/4636
      betoffer/1/2580
      betoffer/1/5174
      betoffer/1/5194
    )
    creator = SpiderCreator.new(links)
    @content = creator.generate

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content }
    end
  end
end