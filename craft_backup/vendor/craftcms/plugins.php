<?php

$vendorDir = dirname(__DIR__);

return array (
  'nystudio107/craft3-typogrify' => 
  array (
    'class' => 'nystudio107\\typogrify\\Typogrify',
    'basePath' => $vendorDir . '/nystudio107/craft3-typogrify/src',
    'handle' => 'typogrify',
    'aliases' => 
    array (
      '@nystudio107/typogrify' => $vendorDir . '/nystudio107/craft3-typogrify/src',
    ),
    'name' => 'Typogrify',
    'version' => '1.1.2',
    'schemaVersion' => '1.0.0',
    'description' => 'Typogrify prettifies your web typography by preventing ugly quotes and \'widows\' and more',
    'developer' => 'nystudio107',
    'developerUrl' => 'https://nystudio107.com/',
    'changelogUrl' => 'https://raw.githubusercontent.com/nystudio107/craft3-typogrify/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
    'components' => 
    array (
      'typogrify' => 'nystudio107\\typogrify\\services\\TypogrifyService',
    ),
  ),
);
