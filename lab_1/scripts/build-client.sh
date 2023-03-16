#!/bin/sh

DIST_FOLDER='../shop-angular-cloudfront/dist'
ARCHIVE_FILE=./dist/client-app.zip

cd '../shop-angular-cloudfront'
npm install
if [ $( find $ARCHIVE_FILE ) ];
  then 
    rm $ARCHIVE_FILE
    npm run build --configuration=production
    zip -r $ARCHIVE_FILE $DIST_FOLDER
    echo Archive updated
  else
    npm run build --configuration=production
    zip -r $ARCHIVE_FILE $DIST_FOLDER
fi