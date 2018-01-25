require "hathitext/version"
require "nokogiri"
require "open-uri"

module Hathitext

  HATHI = 'https://babel.hathitrust.org'

  class HTTPError < StandardError; end
  
  def self.fetchText(u)
    begin
      Nokogiri::HTML(open("%s%s" % [HATHI, u])).css("#mdpPage")
    rescue OpenURI::HTTPError
      raise HTTPError.new "Couldn't open %s%s" % [HATHI, u]
    end
  end

  def self.nextLink(d)
    links = d.css('a').select{|l| l.text =~ /Next Page/}
    if links.count > 0
      return links.first['href']
    end

    return nil
  end
end
