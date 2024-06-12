import yaml
from robot.api import logger
from robot.api.deco import keyword

class YamlEditor:
    def __init__(self, filename):
        self.filename = filename
        self.data = self.load_yaml()

    def load_yaml(self):
        """Load YAML data from the file and return it."""
        with open(self.filename, 'r') as file:
            return yaml.safe_load(file)

    @keyword
    def get_value(self, path):
        """Retrieve a value from the YAML data based on the path.
        
        Args:
            path (list): The path to the value (list of keys).
        
        Returns:
            The value from the specified path or None if the path is invalid.
        """
        current_data = self.data
        for key in path:
            if key in current_data:
                current_data = current_data[key]
            else:
                return None
        return current_data

    @keyword
    def update_value(self, path, value):
        """Update value in the YAML data based on the path.
        
        Args:
            path (list): The path to the value to update (list of keys).
            value (any): The new value to set.
        """
        current_data = self.data
        for key in path[:-1]:
            current_data = current_data.setdefault(key, {})
        current_data[path[-1]] = value

    @keyword
    def save_yaml(self):
        """Save the updated YAML data back to the file."""
        with open(self.filename, 'w') as file:
            yaml.safe_dump(self.data, file, default_flow_style=False)
