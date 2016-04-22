name             'magento'
maintainer       'Sergiu Ionescu'
maintainer_email 'sergiu.ionescu@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures magento'
long_description 'Installs/Configures magento'
version          '0.0.1'
source_url       'https://github.com/sergiuionescu/magento' if respond_to?(:source_url)
issues_url       'https://github.com/sergiuionescu/magento/issues' if respond_to?(:issues_url)

depends 'lamp'
depends 'mysql2_chef_gem'
depends 'database'
