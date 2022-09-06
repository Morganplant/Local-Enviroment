from pyicloud import PyiCloudService

# connect to the API
username = 'morgan@chuffnuts.com'
password = 'Dexterdog123'
api = PyiCloudService(username, password)

files = api.files.dir()

# you can figure out the file path
file_name = 'pythonfile.py'
download = api.files['com~apple~Notes']['Documents'][file_name].open(stream=True)
