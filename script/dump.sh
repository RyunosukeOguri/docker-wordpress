#!/usr/bin/env bash

source ./.env

env=${1:-local}
FILE_NAME="dump"

if [ $env = 'local' ] ; then
	if [ $? = 0 ]; then
		echo "\n\033[37m> \033[m\033[34mDump: Local Database\033[m\n"
		sh script/wp-cli.sh db export $FILE_NAME-local-`date '+%F'`.sql
	fi
fi

if [ $env = 'dev' ] ; then
  sh script/replace-wp.sh local-to-dev
	if [ $? = 0 ]; then
		echo "\n\033[37m> \033[m\033[34mDump: Local Database\033[m\n"
		sh script/wp-cli.sh db export $FILE_NAME-dev-`date '+%F'`.sql
	fi

	if [ $? = 0 ]; then
    sh script/replace-wp.sh dev-to-local
	fi
fi

if [ $env = 'prod' ] ; then
  sh script/replace-wp.sh local-to-prod
	if [ $? = 0 ]; then
		echo "\n\033[37m> \033[m\033[34mDump: Local Database\033[m\n"
		sh script/wp-cli.sh db export $FILE_NAME-prod-`date '+%F'`.sql
	fi

	if [ $? = 0 ]; then
		sh script/replace-wp.sh prod-to-local
	fi
fi
