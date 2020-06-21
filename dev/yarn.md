
scoop install nodejs
scoop install yarn

yarn --version


yarn add prettier --dev --exact
OR
yarn global add prettier

yarn add --dev prettier @prettier/plugin-php

yarn run prettier path/to/file.php --write
OR
prettier path/to/file.php --write