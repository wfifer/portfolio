<?php

$vendorDir = dirname(__DIR__);

return array (
  'superbig/craft3-imgix' => 
  array (
    'class' => 'superbig\\imgix\\Imgix',
    'basePath' => $vendorDir . '/superbig/craft3-imgix/src',
    'handle' => 'imgix',
    'aliases' => 
    array (
      '@superbig/imgix' => $vendorDir . '/superbig/craft3-imgix/src',
    ),
    'name' => 'Imgix',
    'version' => '2.0.1',
    'schemaVersion' => '2.0.0',
    'description' => 'Use Imgix with Craft',
    'developer' => 'Superbig',
    'developerUrl' => 'https://superbig.co',
    'documentationUrl' => 'https://github.com/sjelfull/imgix/blob/master/README.md',
    'changelogUrl' => 'https://raw.githubusercontent.com/sjelfull/imgix/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
    'components' => 
    array (
      'imgixService' => 'superbig\\imgix\\services\\ImgixService',
    ),
  ),
  'craftcms/element-api' => 
  array (
    'class' => 'craft\\elementapi\\Plugin',
    'basePath' => $vendorDir . '/craftcms/element-api/src',
    'handle' => 'element-api',
    'aliases' => 
    array (
      '@craft/elementapi' => $vendorDir . '/craftcms/element-api/src',
    ),
    'name' => 'Element API',
    'version' => '2.5.2',
    'description' => 'Create a JSON API for your elements in Craft',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://pixelandtonic.com/',
    'changelogUrl' => 'https://raw.githubusercontent.com/craftcms/element-api/v2/CHANGELOG.md',
    'downloadUrl' => 'https://github.com/craftcms/element-api/archive/v2.zip',
  ),
  'craftcms/redactor' => 
  array (
    'class' => 'craft\\redactor\\Plugin',
    'basePath' => $vendorDir . '/craftcms/redactor/src',
    'handle' => 'redactor',
    'aliases' => 
    array (
      '@craft/redactor' => $vendorDir . '/craftcms/redactor/src',
    ),
    'name' => 'Redactor',
    'version' => '1.0.0.1',
    'description' => 'Edit rich text content in Craft CMS using Redactor by Imperavi.',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://pixelandtonic.com/',
    'developerEmail' => 'support@craftcms.com',
    'documentationUrl' => 'https://github.com/craftcms/redactor',
    'changelogUrl' => 'https://raw.githubusercontent.com/craftcms/redactor/master/CHANGELOG.md',
    'downloadUrl' => 'https://github.com/craftcms/redactor/archive/master.zip',
  ),
);
