<?php

use craft\elements\Entry;
// use craft\app\helpers\HeaderHelper;

return [
	'endpoints' => [
		'projects.json' => function () {
			// $whitelist = [
			// 	'*.local',
			// 	'localhost:8081',
			// 	preg_replace('/https?:\/\/w*.?/', '', $_SERVER['SERVER_NAME'])
			// ];
			// $request = $_SERVER['HTTP_REFERER'];
			// $matches = 0;
			// foreach($whitelist as $valid) {
			// 	$matched = [];
			// 	$valid = preg_replace('/\*/', '\w+', $valid);
			// 	preg_match('/' . $valid . '(\/[^\.]*)?$/', $request, $matched);
			// 	$matches += count($matched);
			// }

			// if ($matches > 0) {
			// 	\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			// }
			// else {
			// 	\Craft::$app->response->headers->set('Access-Control-Allow-Origin', null);
			// }

			\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			
			return [
				'elementType' => Entry::class,
				'criteria' => ['section' => 'projects'],
				'transformer' => function(Entry $entry) {

					$heroImage = [];
					$image = $entry->heroImage[0];
					$heroImage = [
						'url' => 'http://' . $_SERVER['SERVER_NAME'] . $image->getUrl('masked'),
						'width' => $image->getWidth('masked'),
						'height' => $image->getHeight('masked')
					];

					$heroBackground = [];
					$block = $entry->heroBackground[0];
					if ($block->type == 'background') {
						$heroBackground = [
							'stops' => $block->stops,
							'angle' => $block->angle
						];
					}
					
					return [
						'title' => $entry->title,
						'url' => $entry->url,
						'heroImage' => $heroImage,
						'heroBackground' => $heroBackground
					];
				}
			];    
		}
	]
];