# wizard
Magic database-driven project starter, requires Docker, tested on Mac
Configured stack: Linux (Docker) + Apache + MySQL + Laravel (PHP)
## Usage
```
git clone git@github.com:bradand/wizard.git
./wizard.sh --projname=myproject --reposrc=git@github.com:laravel/laravel.git --dbhandle=mydbname
```
## Repair & Redo
Remove the clone command from wizard.sh, test everthing else
```
./wizard.sh --projname=myproject --reposrc=git@github.com:laravel/laravel.git --dbhandle=mydbname --debug
```
clean project folder, remove containers, clean slate *deletes everything inside ./root/myproject
```
./wizard.sh --projname=myproject --reposrc=git@github.com:laravel/laravel.git --dbhandle=mydbname --clean
```
## File Structure
Wizard will clone the specificed repo into root/myproject and apply a series of helper actions to get it up and running (see wizard.sh). You can move the project files somewhere else or edit them in place. Hack the planet!
## Laravel
Initial commands in new terminal after wizard completes (build, up, logging)
```
docker exec -it myproject bash -c "sudo -u devuser /bin/bash"
./laravel_init.sh
```
Now you are free to work with your new project!
## Initial Database Seeds
Place your .sql files in data/ and they will be loaded into the mysql-db container during the Docker build stage (e.g. the included data/sample.sql file)