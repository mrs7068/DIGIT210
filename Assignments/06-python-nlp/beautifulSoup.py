from bs4 import BeautifulSoup
import requests
import os

archive_url = "https://afish2003.github.io/GretaVanZeppelin/albums.html"


# create response object
r = requests.get(archive_url)

# create beautifulSoup object
soup = BeautifulSoup(r.text, 'html.parser')

artists = soup.select("div.artist")

for artist in artists:
    artist_name = artist.find("h2").get_text(strip=True)
    print(f"\n🎤 Artist: {artist_name}")

    albums = artist.select("div.album")
    for album in albums:
        link_tag = album.find("a")
        album_title = link_tag.find("h3").get_text(strip=True)
        release_info = link_tag.find("p").get_text(strip=True)
        album_url = link_tag['href']

        print(f"  🎵 Album: {album_title}")
        print(f"     📅 {release_info}")
        print(f"     🔗 Link: https://afish2003.github.io/GretaVanZeppelin/{album_url}")
