from flask import Flask, jsonify
from azure.storage.blob import BlobServiceClient

app = Flask(__name__)

# Replace these values with your Azure Storage account information
account_name = "your_account_name"
account_key = "your_account_key"
container_name = "your_container_name"

@app.route('/get_blob_contents', methods=['GET'])
def get_blob_contents():
    try:
        # Connect to Azure Blob Storage
        blob_service_client = BlobServiceClient(account_url=f"https://{account_name}.blob.core.windows.net", credential=account_key)
        container_client = blob_service_client.get_container_client(container_name)

        # List all blobs in the container
        blobs = [blob.name for blob in container_client.list_blobs()]

        # Fetch contents of each blob
        blob_contents = {}
        for blob_name in blobs:
            blob_client = container_client.get_blob_client(blob_name)
            blob_contents[blob_name] = blob_client.download_blob().readall()

        return jsonify(blob_contents)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
