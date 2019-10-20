#!/usr/bin/env bash

source ./.env

env=${1:-dev-to-local}

LOCAL_URL=$APP_LOCAL_PROTOCOL$APP_LOCAL_DOMAIN
DEV_URL=$APP_DEV_PROTOCOL$APP_DEV_DOMAIN
PRO_URL=$APP_PROD_PROTOCOL$APP_PROD_DOMAIN

if [ $env = 'dev-to-local' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $DEV_URL -> $LOCAL_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_DEV_DOMAIN $APP_LOCAL_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_DEV_PROTOCOL$APP_LOCAL_DOMAIN $LOCAL_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $S3_BUCKET_DEV $S3_BUCKET_LOCAL --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_DEV_ADMIN $APP_LOCAL_ADMIN --network
fi

if [ $env = 'prod-to-local' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $PRO_URL -> $LOCAL_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_PROD_DOMAIN $APP_LOCAL_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_PROD_PROTOCOL$APP_LOCAL_DOMAIN $LOCAL_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $S3_BUCKET_PRO $S3_BUCKET_LOCAL --network
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_PROD_ADMIN $APP_LOCAL_ADMIN --network
fi


if [ $env = 'local-to-dev' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $LOCAL_URL -> $DEV_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_LOCAL_DOMAIN $APP_DEV_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_LOCAL_PROTOCOL$APP_DEV_DOMAIN $DEV_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $S3_BUCKET_LOCAL $S3_BUCKET_DEV --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_LOCAL_ADMIN $APP_DEV_ADMIN --network
fi

if [ $env = 'prod-to-dev' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $PRO_URL -> $DEV_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_PROD_DOMAIN $APP_DEV_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_PROD_PROTOCOL$APP_DEV_DOMAIN $DEV_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $S3_BUCKET_PRO $S3_BUCKET_DEV --network
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_PROD_ADMIN $APP_DEV_ADMIN --network
fi


if [ $env = 'local-to-prod' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $LOCAL_URL -> $PRO_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_LOCAL_DOMAIN $APP_LOCAL_DOMAIN $APP_PROD_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_LOCAL_PROTOCOL$APP_PROD_DOMAIN $PRO_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $S3_BUCKET_LOCAL $S3_BUCKET_PRO --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_LOCAL_ADMIN $APP_PROD_ADMIN --network
fi

if [ $env = 'dev-to-prod' ] ; then
	echo "\n\033[37m> \033[m\033[34mReplace DB: $DEV_URL -> $PRO_URL\033[m\n"
	sh script/wp-cli.sh search-replace --url=$APP_DEV_DOMAIN $APP_DEV_DOMAIN $APP_PROD_DOMAIN --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_DEV_PROTOCOL$APP_PROD_DOMAIN $PRO_URL --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $S3_BUCKET_DEV $S3_BUCKET_PRO --network
	sh script/wp-cli.sh search-replace --url=$APP_PROD_DOMAIN $APP_DEV_ADMIN $APP_PROD_ADMIN --network
fi
