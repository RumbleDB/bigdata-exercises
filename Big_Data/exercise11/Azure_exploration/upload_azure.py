# ----------------------------------------------------------------------------------
# MIT License
#
# Copyright(c) Microsoft Corporation. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ----------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# pip install azure-storage-blob
# documentation: https://learn.microsoft.com/en-us/python/api/overview/azure/storage-blob-readme?view=azure-python

from datetime import datetime, timedelta
from azure.storage.blob import BlobServiceClient, generate_account_sas, ResourceTypes, AccountSasPermissions
from azure.storage.blob import BlobClient


def run_sample():
    try:
        # Create the BlockBlobService that is used to call the Blob service for the storage account
        # TODO: replace AccountName and AccountKey with your own credentials
        connection_string = "DefaultEndpointsProtocol=https;AccountName=xxxx;AccountKey=xxxx;EndpointSuffix=core.windows.net"

        # Note can test the following code with the smallest, then try to upload a larger dataset. 
        # It can take quite a while to upload git-archive-huge.json
        blob = BlobClient.from_connection_string(conn_str=connection_string, container_name="newcontainer", blob_name="git-archive-huge.json")

        print('starting to upload')
        with open("git-archive-huge.json", "rb") as data:
            blob.upload_blob(data, overwrite=True)
        
        print('finished uploading')

    except Exception as e:
        print(e)


# Main method.
if __name__ == '__main__':
    run_sample()
