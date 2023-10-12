require 'rubygems'
require 'open-uri'
require 'nokogiri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

page = Nokogiri::HTML(URI.open(PAGE_URL))

crypto_name_array = []
crypto_value_array = []
#results = hash.new
#results['name'] = 'value'
#mon_hash = (crypto_name_array).zip(crypto_value_array).to_h



#//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]/td[3]/div

#//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[2]/td[3]/div

#//*[@id="__next"]/tr[]

#//*[@id="__next"]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr[1]/td[4]/div
#//*[@id="__next"]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr[1]/td[3]/div/a/div/div/div/div

crypto_data = []

# Utilisez une boucle pour extraire les données de chaque ligne <tr>
page.css("table tbody tr").first(20).each do |row|
  name = row.css("td[3]/div").text.strip  # Vous pouvez ajuster le numéro de colonne pour le nom
  value = row.css("td[5]").text.strip  # Vous pouvez ajuster le numéro de colonne pour la valeur
  crypto_data << { name: name, value: value }
end

# Affichez les noms et les valeurs des cryptomonnaies
crypto_data.each do |crypto|
  puts "Nom : #{crypto[:name]}, Valeur : #{crypto[:value]}"
end