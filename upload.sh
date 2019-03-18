#!/bin/bash

VersionString=`grep -E 's.version.*=' APITemplateProject_OC.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`
NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' APITemplateProject_OC.podspec | cut -d : -f1`

git add .
git commit -am modification
git pull origin master --tags

sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" APITemplateProject_OC.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"
say "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod trunk push ./APITemplateProject_OC.podspec --verbose --use-libraries --allow-warnings
