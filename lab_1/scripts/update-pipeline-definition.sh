cd ..

if ! command -v jq &> /dev/null
  then
    'jq' does not exists
    exit
fi

JSON_FILE=''
BRANCH='main'
OWNER='owner'

if [[ $# -eq 1 || $# -gt 1 ]];
  then
    JSON_FILE=$1
fi

while ! [ $# -eq 1 ]; do
  case $1 in
    '--branch')
      BRANCH=$2
      ;;
    '--owner')
      OWNER=$2
      ;;
  esac
  shift
done

if [ $JSON_FILE = '' ];
  then
    echo Provide path to json file
    exit
fi

jq 'del(.metadata)' $JSON_FILE | jq '.pipeline.version += 1' | jq --arg branch $BRANCH '.pipeline.stages[0].actions[0].configuration.Branch |= $branch' | jq --arg owner $OWNER '.pipeline.stages[0].actions[0].configuration.Owner |= $owner' > "pipeline-$( date ).json"
