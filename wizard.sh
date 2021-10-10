#main wizard file

for i in "$@"; do
  case $i in
    -n=*|--projname=*)
      PROJNAME="${i#*=}"
      shift # past argument=value
      ;;
    -s=*|--reposrc=*)
      REPOSRC="${i#*=}"
      shift # past argument=value
      ;;
    -h=*|--dbhandle=*)
      DBHANDLE="${i#*=}"
      shift # past argument=value
      ;;
    --debug)
      DEBUG=YES
      shift # past argument with no value
      ;;
    --clean)
      CLEAN=YES
      shift # past argument with no value
      ;;
    *)
      # unknown option
      ;;
  esac
done
echo "PROJNAME  = ${PROJNAME}"
echo "REPOSRC   = ${REPOSRC}"
echo "DBHANDLE  = ${DBHANDLE}"
echo "DEBUG     = ${DEBUG}"
echo "CLEAN     = ${CLEAN}"
#echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
# if [[ -n $1 ]]; then
#     echo "Last line of file specified as non-opt/last argument:"
#     tail -1 $1
#fi



if [ -z "$PROJNAME" ] || [ -z "$REPOSRC" ] || [ -z "$DBHANDLE" ]; then
  
  echo "ERROR: missing PROJNAME or REPOSRC or DBHANDLE, aborting"
  exit

else

  if [ "$CLEAN" = "YES" ]; then

    echo "CLEAN install"
    cd root/$PROJNAME/
    docker-compose down
    cd ../
    rm -rf $PROJNAME
    docker system prune --all --volumes --force

  else

    echo "cd root"
    cd root

    if [ "$DEBUG" = "YES" ]; then
      echo "DEBUG, skip clone"
    else
      echo "git clone $REPOSRC $PROJNAME"
      git clone $REPOSRC $PROJNAME
    fi
    
    echo "cd $PROJNAME"
    cd $PROJNAME

    # if [ $DEBUG = "YES" ]; then
    #   echo "DEBUG, skip branch checkout"
    # else
    #   echo "git checkout -b dev-env"
    #   git checkout -b dev-env
    # fi

    echo "cp ../../wizard_env .env"
    cp ../../wizard_env .env

    echo "sed -i.bak 's/DB_DATABASE=laravel/DB_DATABASE=$DBHANDLE/g' .env"
    sed -i.bak "s/DB_DATABASE=laravel/DB_DATABASE=$DBHANDLE/g" .env

    echo "sed -i.bak 's/APP_NAME=Laravel/APP_NAME=$PROJNAME/g' .env"
    sed -i.bak "s/APP_NAME=Laravel/APP_NAME=$PROJNAME/g" .env

    echo "sed -i.bak 's/DB_USERNAME=root/DB_USERNAME=dbuser/g' .env"
    sed -i.bak "s/DB_USERNAME=root/DB_USERNAME=dbuser/g" .env

    echo "sed -i.bak 's/DB_PASSWORD=/DB_PASSWORD=dbpass/g' .env"
    sed -i.bak "s/DB_PASSWORD=/DB_PASSWORD=dbpass/g" .env

    echo "rm .env.bak"
    rm .env.bak

    # echo "echo 'UID=1000' >> .env"
    # echo "UID=1000" >> .env

    echo "cp ../../wizard_Dockerfile ./Dockerfile"
    cp ../../wizard_Dockerfile ./Dockerfile

    echo "sed -i.bak 's/ServerName\ laravel-app.local/ServerName\ $PROJNAME.local/g' Dockerfile"
    sed -i.bak "s/ServerName\ laravel-app.local/ServerName\ $PROJNAME.local/g" Dockerfile
    
    echo "rm Dockerfile.bak"
    rm Dockerfile.bak

    echo "cp ../../wizard_docker-compose.yml ./docker-compose.yml"
    cp ../../wizard_docker-compose.yml ./docker-compose.yml

    echo "cp ../../wizard_laravel_init.sh ./laravel_init.sh"
    cp ../../wizard_laravel_init.sh ./laravel_init.sh

    echo "sed -i.bak 's/laravel-app/$PROJNAME/g' docker-compose.yml"        
    sed -i.bak "s/laravel-app/$PROJNAME/g" docker-compose.yml

    echo "rm docker-compose.yml.bak"
    rm docker-compose.yml.bak

    echo 'echo "run/var" > .dockerignore'
    echo "run/var" > .dockerignore 

    echo 'echo "run/var" > .gitignore'
    echo "run/var" > .gitignore

    echo "[ ! -e run/ ] && mkdir run/"
    [ ! -e run ] && mkdir run

    echo "[ ! -e run/dump/ ] && mkdir run/dump/"
    [ ! -e run/dump ] && mkdir run/dump

    echo "cp ../../data/*.sql run/dump/"
    cp ../../data/*.sql run/dump/

    # #######MAIN BUILD COMMAND
    echo "docker-compose build && docker-compose up -d && docker-compose logs -f"
    docker-compose build && docker-compose up -d && docker-compose logs -f

    
  fi
fi


