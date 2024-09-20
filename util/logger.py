import logging
import os

class Logger:
    def __init__(self, log_file: str = "app.log", log_level: int = logging.INFO):
        """
        Initializes the logger with the specified log file and log level.
        
        :param log_file: Path to the log file.
        :param log_level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL).

        Usage example:
        logger = Logger(log_file="application.log").get_logger()

        """
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(log_level)
        
        # Check if handlers are already attached to avoid duplicate logs
        if not self.logger.handlers:
            # Create file handler
            file_handler = logging.FileHandler(log_file)
            file_handler.setLevel(log_level)

            # Create console handler
            console_handler = logging.StreamHandler()
            console_handler.setLevel(log_level)

            # Create formatter and add it to the handlers
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            file_handler.setFormatter(formatter)
            console_handler.setFormatter(formatter)

            # Add handlers to the logger
            self.logger.addHandler(file_handler)
            self.logger.addHandler(console_handler)
    
    def get_logger(self):
        """Returns the logger object."""
        return self.logger