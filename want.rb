require 'open-uri'
require 'nokogiri'

def want(request)
  begin
    # delete key word
    request = request[5..]

    # get last page and parse it
    html = open("http://old.reactor.cc/tag/#{URI.encode_www_form([request])}")
    doc = Nokogiri::HTML(html)

    # get number of last page and return safe value if page number empty
    page_number = doc.search('//div[@id="Pagination"]/span[2]').text
    if page_number.empty?
      page_number = 1
    end

    rand_page_number = rand(1...page_number.to_i)

    # get random page and parse it
    html = open("http://old.reactor.cc/tag/#{URI.encode_www_form([request])}/#{rand_page_number.to_s}")
    doc = Nokogiri::HTML(html)

    #get content links from random post on the page
    rand_post_numb = rand(doc.search('//div[@id="post_list"]/div[@class="postContainer"]').count)
    link = doc.search("//div[#{rand_post_numb}][@class=\"postContainer\"]/descendant::div[@class=\"image\"]/descendant::*/attribute::src")
    if link.empty?
      link = "¯\\_(ツ)_/¯"
    end
    return link.to_s.gsub("http", " http")
  rescue OpenURI::HTTPError
    return "не хочешь"
  end
end