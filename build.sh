#!/bin/sh

#请配置如下打包信息

#项目中文昵称
projectChineseName=早团

#当前项目目录

currentDir=`pwd`

#项目工程名字

projectName=pjk

#编译条件 Realse Debug 两种

configuration=Realse

bundle=./ios/bundle

if [ -d "${bundle}" ]; then
rm -rf ${bundle}
fi

mkdir ${bundle}

react-native bundle --platform ios --assets-dest ${bundle} --dev false --entry-file App.js --bundle-output ${bundle}/main.jsbundle

cd ios

#记录一下当前jsbundle路径

jsbundlePath=`pwd`

xcodebuild clean -workspace ${projectName}.xcworkspace -scheme ${projectName} -configuration ${configuration}

xcodebuild archive -workspace ${projectName}.xcworkspace -scheme ${projectName} -configuration ${configuration} -archivePath ../${projectName}.xcarchive

packageName=Payload.ipa

cp -r ../${projectName}.xcarchive/Products/Applications/${projectName}.app ../Payload

cd ..

zip -r $packageName Payload

