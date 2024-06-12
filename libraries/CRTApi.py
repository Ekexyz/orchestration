import requests

class CRTApi:
    def __init__(self, api_url, access_token):
        self.api_url = api_url
        self.headers = {
            'X-Authorization': access_token,
            'Content-Type': 'application/json'
        }

    def start_test_run(self, project_id, suite_id, input_parameters=None):
        """Start a test run and return the response including status and buildId."""
        url = f"{self.api_url}/projects/{project_id}/jobs/{suite_id}/builds"
        payload = {
            "inputParameters": input_parameters if input_parameters else []
        }
        response = requests.post(url, json=payload, headers=self.headers)
        response.raise_for_status()  # Raises an HTTPError for bad responses
        return response.json()

    def get_build_status(self, project_id, build_id):
        """Retrieve the status of a build."""
        url = f"{self.api_url}/projects/{project_id}/builds/{build_id}"
        response = requests.get(url, headers=self.headers)
        response.raise_for_status()
        return response.json()
