#!/usr/bin/env bash
cp requires_windows.txt requirements.txt
wget -r --cut-dirs=1 -nH -np --reject index.html $WINDOWS_BINARIES_PATH

docker run -v "$(pwd):/src/" ${BUILDER_CONTAINER}

#Workaround until themes will be "don't care" themes
[ ! -d 'http/default_gui' ] && cp -r http/default http/default_gui

cp -r http/ dist/windows/main/http/
# Because windows
chmod a+x -R dist/windows/main/
# Rename to chat name
mv dist/windows/main dist/windows/LalkaChat

cd dist/windows
zip -r ${ZIP_NAME}.zip LalkaChat
chmod 664 ${ZIP_NAME}.zip
sudo mv ${ZIP_NAME}.zip $UPLOAD_DIR/
