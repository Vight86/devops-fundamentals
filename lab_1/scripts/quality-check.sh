#!/bin/sh

cd '../shop-angular-cloudfront'

if [ npm run test | grep -o 'Error' ]
  then echo Unit tests failed
  else echo Unit tests passed
fi


if [ npm run lint | grep -o 'Error' ]
  then echo Code have lint errors
  else echo Code is clean
fi