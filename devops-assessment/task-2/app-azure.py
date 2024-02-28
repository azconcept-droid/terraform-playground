from flask import Flask, jsonify
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

app = Flask(__name__)

key_vault_url = "https://your-key-vault-name.vault.azure.net/"
secret_name = "your-secret-name"

@app.route('/get_blob_contents', methods=['GET'])
def get_blob_contents():
    try:
        # Use DefaultAzureCredential to authenticate using managed identity or other available methods
        credential = DefaultAzureCredential()

        # Create a SecretClient using the key vault URL and credential
        secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

        # Retrieve the secret value from Azure Key Vault
        secret_value = secret_client.get_secret(secret_name).value

        # Now you can use the secret_value as needed

        return jsonify({"secret_value": secret_value})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
