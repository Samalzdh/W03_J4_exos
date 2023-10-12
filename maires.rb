require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = "http://annuaire-des-mairies.com/"
@page = Nokogiri::HTML(URI.open(url))

url95 = "http://annuaire-des-mairies.com/val-d-oise.html"
@page95 = Nokogiri::HTML(URI.open(url95))

urlmail = "https://www.annuaire-des-mairies.com/95/avernes.html"
@pagemail = Nokogiri::HTML(URI.open(urlmail))


def vald_link #recuperation des liens des differentes villes
  mailval = @page95.xpath("//a[@class='lientxt']/@href")
  valville = []
  mailval.each do |ville|
    urlvalville = ville.text
    valville << "http://annuaire-des-mairies.com" + urlvalville[1..-1]
  end
  
  return valville
end


def scrap_mail(liens) #recuperation des liens et des mails dans chaque pages
  
  scaping = []
  liens.each do |url|
    lesmails = Nokogiri::HTML(URI.open(url))
    mailave = lesmails.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')
    
    mailave.each do |mails|
      scaping << mails.text
    end
  end
  
  return scaping
end

def vald_nom #recuperation des noms des differentes villes
  pagevilleval = @page95.xpath("//a[@class='lientxt']")
  nomdeville = []
  pagevilleval.each do |ville|
    nomdeville << ville.text

  end
  
  return nomdeville

end


def perform 
  crypto_hash = Hash[vald_nom.zip(scrap_mail(vald_link))]
  crypto_hash.each{|nom,adresse| puts "#{nom} : #{adresse}"}
  # parcours l'ensemble du hashes et à chaque row il va faire un puts de la key et de la value ==> permet une présentation plus soignée du tableau
end
#scrap_mail(vald_link())

perform
