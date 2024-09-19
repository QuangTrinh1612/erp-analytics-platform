from logger import Logger
from databricks import sql
from typing import List

class DatabricksSQLClient:
    def __init__(self, server_hostname: str, http_path: str, access_token: str, logger):
        """
        Initializes the DatabricksSQLClient with server hostname, HTTP path, access token, and logger.
        
        :param server_hostname: The hostname of your Databricks cluster.
        :param http_path: The HTTP path to the Databricks SQL endpoint.
        :param access_token: Your Databricks personal access token.
        :param logger: Logger instance to log messages.
        """
        self.server_hostname = server_hostname
        self.http_path = http_path
        self.access_token = access_token
        self.logger = logger
        self.connection = None

    def connect(self):
        """Establishes a connection to the Databricks SQL endpoint."""
        try:
            self.connection = sql.connect(
                server_hostname=self.server_hostname,
                http_path=self.http_path,
                access_token=self.access_token
            )
            self.logger.info("Connection established successfully!")
        except Exception as e:
            self.logger.error(f"Failed to establish connection: {e}")
            raise e
        
    def run_query(self, query: str) -> List[tuple]:
        """
        Executes a SQL query on Databricks SQL and returns the result.
        
        :param query: SQL query string to be executed.
        :return: List of rows, where each row is a tuple.
        """
        if not self.connection:
            self.logger.error("Connection not established. Call connect() first.")
            raise Exception("Connection not established. Call connect() first.")
        
        try:
            cursor = self.connection.cursor()
            self.logger.info(f"Running query: {query}")
            cursor.execute(query)
            
            result = cursor.fetchall()
            cursor.close()
            self.logger.info(f"Query executed successfully. Fetched {len(result)} rows.")
            return result
        except Exception as e:
            self.logger.error(f"Query execution failed: {e}")
            raise e
    
    def close(self):
        """Closes the Databricks SQL connection."""
        if self.connection:
            try:
                self.connection.close()
                self.logger.info("Connection closed successfully.")
            except Exception as e:
                self.logger.error(f"Failed to close the connection: {e}")
                raise e