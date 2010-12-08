require 'nokogiri'
require 'open-uri'

class IndexController < ApplicationController
  def index
    creator = SpiderCreator.new('betoffer/1/1193')
    @content = creator.generate

  end
end