import requests
import yaml
from typing import Tuple, List, Literal, Dict
from bs4 import BeautifulSoup

class oracleMetadata():

    def __init__(self, table_name: str, url: str):
        self.table_name = table_name
        self.url = url

    def scrape_oracle_metadata(self, type: Literal['markdown', 'yaml']):
        data = self.get_table_data()

        if type == 'markdown':
            self.write_file(self.generate_markdown(data[0], data[1]), type)
        elif type == 'yaml':
            self.write_file(self.generate_yml(data[0], data[1]), type)
        else:
            raise ValueError("Invalid format. Please choose 'markdown' or 'yml'.")

        return 200

    def get_table_data(self) -> Tuple[List, List]:
        # Send a GET request to the provided URL
        response = requests.get(self.url)
        
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
        
        return headers, rows

    def convert_to_json_array(self, headers: List, rows: List) -> List[Dict]:
        json_array: List[Dict] = []
        for row in rows:
            # Create a dictionary for each row, mapping headers to corresponding values
            json_array.append(dict(zip(headers, row)))
        return json_array

    # Markdown for reference
    def generate_markdown(self, headers, rows):
        # Markdown table header
        md = '| ' + ' | '.join(headers) + ' |\n'
        md += '| ' + ' | '.join(['---'] * len(headers)) + ' |\n'

        # Markdown table rows
        for row in rows:
            md += '| ' + ' | '.join(row) + ' |\n'
        
        return md
    
    def write_file(self, input: str, type: Literal['markdown', 'yaml']):
        if type == 'markdown':
            # Save markdown to file
            with open(f'{self.table_name.lower()}.md', 'w') as file:
                file.write(input)

            print(f"Markdown file has been created: {self.table_name.lower()}.md")
        elif type == 'yaml':
            with open(f'{self.table_name.lower()}.yml', 'w') as file:
                file.write(input)

            print(f"Yaml file has been created: {self.table_name.lower()}.yml")
        else:
            raise ValueError("Invalid format. Please choose 'markdown' or 'yml'.")

    # Leverage in dbt profiles
    def generate_yml(self, headers, rows):
        array: List[Dict] = self.convert_to_json_array(headers, rows)

        columns: List = []
        for col in array:
            columns.append({
                "name": col.get('Name'),
                "description": f"{col.get('Datatype')} datatype. {col.get('Comments')}"
            })
        
        yaml_data = {
            "version": 2,
            "sources": [
                {
                    "name": "Fusion",
                    "database": "{{ var('catalog') }}",
                    "schema": "{{ var('fusion_schema') }}",
                    "tables": [
                        {
                            "name": self.table_name,
                            "columns": columns
                        }
                    ]
                }
            ]
        }

        return yaml.dump(yaml_data, sort_keys=False)

def main(table_name, url):
    doc = oracleMetadata(table_name, url)
    response = doc.scrape_oracle_metadata(type='markdown')
    response = doc.scrape_oracle_metadata(type='yaml')

if __name__ == '__main__':
    main(table_name='RA_CUSTOMER_TRX_ALL', url='https://docs.oracle.com/en/cloud/saas/financials/24a/oedmf/racustomertrxall-5113.html')