import requests
from bs4 import BeautifulSoup

class oracleMetadata():

    def __init__(self, table_name: str, type: str):
        self.table_name = table_name

    def get_url(self):
        return 'https://docs.oracle.com/en/cloud/saas/procurement/24b/oedmp/podistributionsall-29728.html'

    def scrape_oracle_metadata_table(self):
        # Send a GET request to the provided URL
        response = requests.get(self.get_url())
        
        if response.status_code != 200:
            print(f"Failed to retrieve the page. Status code: {response.status_code}")
            return

        # Parse the page content
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Find the table that contains metadata. This may need to be adjusted depending on the structure of the page.
        table = soup.find('table', {'summary': 'Columns'})

        if not table:
            print("No table found on the page.")
            return

        # Extract the headers and rows from the table
        headers = [th.get_text(strip=True) for th in table.find_all('th')]
        rows = []
        for tr in table.find_all('tr')[1:]:  # Skipping the header row
            row_data = [td.get_text(strip=True) for td in tr.find_all('td')]
            rows.append(row_data)
        
        # Generate markdown
        md_output = self.generate_markdown(headers, rows)
        self.write_markdown(md_output)

    def generate_markdown(self, headers, rows):
        # Markdown table header
        md = '| ' + ' | '.join(headers) + ' |\n'
        md += '| ' + ' | '.join(['---'] * len(headers)) + ' |\n'

        # Markdown table rows
        for row in rows:
            md += '| ' + ' | '.join(row) + ' |\n'
        
        return md
    
    def write_markdown(self, input: str):
        # Save markdown to file
        with open(f'{self.table_name.lower()}.md', 'w') as file:
            file.write(input)

        print(f"Markdown file has been created: {self.table_name.lower()}.md")

if __name__ == '__main__':
    doc = oracleMetadata('po_headers_all', 'table')
    doc.scrape_oracle_metadata_table()