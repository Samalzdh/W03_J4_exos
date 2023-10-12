require 'rubygems'
require 'open-uri'
require 'nokogiri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"
@page = Nokogiri::HTML(URI.open(PAGE_URL))

def crypto_symbol
  crypto_path = @page.xpath('//td[contains(@class, "by__symbol")]')
  crypto_name_array = []
  crypto_path.each do |symbol|
    crypto_name_array << symbol.text
    
   # puts "#{crypto_name_array}"

  end
  return crypto_name_array
end

def crypto_price
  value_path = @page.xpath('//td[contains(@class, "by__price")]')
  crypto_value_array = []
  value_path.each do |price|
    crypto_value_array << price.text
    
   # puts "#{crypto_value_array}"
  end
  return crypto_value_array
end

def perform 
  crypto_hash = Hash[crypto_symbol.zip(crypto_price)]
  crypto_hash.each{|key,value| puts "#{key} : #{value}"}
  # parcours l'ensemble du hashes et à chaque row il va faire un puts de la key et de la value ==> permet une présentation plus soignée du tableau
end

perform