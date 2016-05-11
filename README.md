# simple-dropbox-upload

## Requirements
### Gems
- dropbox_sdk

### Dropbox API
Create an app [here](https://www.dropbox.com/developers/apps) and generate an access token.

Export this token as an environment variable or pass it as a parameter when using the script.

## Usage
  dropbox-upload.rb [options]

    -f, --file FILE                  File to upload
    
    -t, --token TOKEN                Supply auth token directly instead of using $DROPBOX_TOKEN
    
    -h, --help                       Show this message
