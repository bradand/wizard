# wizard
Magic database-driven project starter, requires Docker
## Usage
```
./wizard.sh --projname=myproject --reposrc=git@github.com:laravel/laravel.git --dbhandle=mydbname
```
## Repair
Remove the clone command from wizard.sh, test everthing else
```
... --debug
```
clean project folder, remove containers, clean slate *deletes everything inside ./root/myproject
```
... --clean
```
## Laravel
Initial commands in new terminal after wizard completes (build, up, logging)
```
docker exec -it myproject bash -c "sudo -u devuser /bin/bash"
./laravel_init.sh
```