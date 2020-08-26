require 'byebug'

module Spider
  class ParsePageService
    def initialize(index_doc, page = 1)
      @index_doc = index_doc
      @page = page
    end

    def titles
      @page == 1 ? single_page_title(@index_doc) : multiple_page_title
    end

    private

    def single_page_title(doc)
      doc.css('.r-ent').map do |row|
        row.css('.title').text
      end
    end

    def multiple_page_title
      titles = single_page_title(@index_doc)
      current_doc = @index_doc

      @page.times do
        url = next_page_url(current_doc)
        current_doc = Spider::Ptt.new("https://www.ptt.cc#{url}").index
        titles += single_page_title(current_doc)
      end
      titles
    end

    def next_page_url(doc)
      link_div = doc.css('.btn-group-paging > a').select do |div|
        div.text.include?('上頁')
      end
      link_div[0].values[1]
    end
  end
end
