# lern-git
lerning git command

## EXCLUDE NOT COMMIT ADD  `.gitignore`

````
/system/sessions
/push.bat
/application/config/database.php
/application/logs
````


## AUTO PUSH BAT FILE `push.bat`

````
git add . && git commit -m "%date%-%time%" && git push
````

## ADD PERMANENT CREDENTIAL

````
git config credential.helper cache

git config credential.helper 'cache --timeout=86400'

git config credential.helper store

git config --global credential.helper store

git config credential.helper 'store --file=/full/path/to/.git_credentials'

````
