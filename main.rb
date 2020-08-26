require_relative 'spider'
require_relative 'parse_page_service'
require 'byebug'

gossiping = Spider::Ptt.new('https://www.ptt.cc/bbs/Gossiping/index.html')
page = Spider::ParsePageService.new(gossiping.index, 10)
puts page.titles
