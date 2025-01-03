import os
import time
import requests
from bs4 import BeautifulSoup

def get_biblicky_citat():
    url = 'https://www.vira.cz/biblicky-citat.php'
    response = requests.get(url)
    if response.status_code == 200:
        response.encoding = 'utf-8'  # Ensure the response is decoded as utf-8
        return response.text
    else:
        return {'error': 'Unable to fetch the biblicky citat'}

def parse_biblicky_citat(html):
    soup = BeautifulSoup(html, 'html.parser')
    text = soup.find('span', id='biblicky-citat-text').get_text()
    reference = soup.find('span', id='biblicky-citat-citace').get_text()
    print(f'{time.ctime()} \nText: {text} {reference}')
    return {'text': text, 'reference': reference}

def post_biblicky_citat(text, reference):
    api_url = 'https://in.zivyobraz.eu'
    import_key = os.getenv('ZIVYOBRAZ_API_IMPORT_KEY')
    data = {'import_key': import_key, 'bible_verse': text, 'bible_ref': reference}
    response = requests.get(api_url, params=data)
    return response.status_code, response.text

html_output = get_biblicky_citat()
parsed_citat = parse_biblicky_citat(html_output)

if 'error' not in parsed_citat:
    status_code, response_text = post_biblicky_citat(parsed_citat['text'], parsed_citat['reference'])
    print(f'Status Code: {status_code}')
    print(f'Response: {response_text}')
else:
    print(parsed_citat)
