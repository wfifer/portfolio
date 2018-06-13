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
					if (sizeof($entry->heroImage)) {
						$image = $entry->heroImage[0];
						$heroImage = [
							'url' =>  $image->getUrl(),
							'width' => $image->getWidth(),
							'height' => $image->getHeight()
						];
					}

					$heroBackground = [];
					if (sizeof($entry->heroBackground)) {
						$block = $entry->heroBackground[0];
						if ($block->type == 'background') {
							$heroBackground = [
								'stops' => $block->stops,
								'angle' => $block->angle
							];
						}
					}

					$layers = [];
					if (sizeof($entry->projectLayers)) {
						foreach ($entry->projectLayers->all() as $block) {
							if ($block->type == 'layer') {
								if (sizeof($block->image)) {
									$image = $block->image[0];
									$layerImage = [
										'url' =>  $image->getUrl(),
										'width' => $image->getWidth(),
										'height' => $image->getHeight()
									];
								}
								$layer = [
									'image' => $layerImage,
									'depth' => $block->depth
								];
								$layers[] = $layer;
							}
						}
					}

					$categories = [];
					foreach ($entry->projectCategory->all() as $category) {
						$cat  = [
							'slug' => $category->slug,
							'title' => $category->title
						];
						if (sizeof($category->icon)) {
							$cat['icon'] = $category->icon[0]->getUrl();
						}
						if (sizeof($category->fontIcon)) {
							$fontIcon = [];
							foreach ($category->fontIcon as $icon) {
								$fontIcon[] = $icon['className'];
							}
							$cat['fontIcon'] = $fontIcon;
						}
						$categories[] = $cat;
					}

					$collaborators = [];
					foreach ($entry->collaborator->all() as $collab) {
						$collaborators[] = [
							'title' => $collab->title,
							'website' => $collab->website
						];
					}
					
					return [
						'title' => $entry->title,
						'url' => $entry->url,
						'heroImage' => $heroImage,
						'heroBackground' => $heroBackground,
						'entryId' => $entry->id,
						'website' => $entry->website,
						'categories' => $categories,
						'collaborators' => $collaborators,
						'layers' => $layers
					];
				}
			];    
		},
		'project/<entryId:\d+>.json' => function ($entryId) {
			\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			
			return [
				'elementType' => Entry::class,
				'criteria' => ['id' => $entryId],
				'one' => true,
				'transformer' => function(Entry $entry) {
					$pageContent = [];
					foreach ($entry->pageContent->all() as $block) {
						$blockContent = [
							'type' => $block->type->handle
						];
						switch ($block->type->handle) {
							case 'wysiwyg':
								$blockContent['body'] = $block->body->getParsedContent();
								break;
						}
						$pageContent[] = $blockContent;
					}
					$categories = [];
					foreach ($entry->projectCategory->all() as $category) {
						$cat  = [
							'slug' => $category->slug,
							'title' => $category->title
						];
						if (sizeof($category->icon)) {
							$cat['icon'] = $category->icon[0]->getUrl();
						}
						$categories[] = $cat;
					}
					return [
						'categories' => $categories,
						'intro' => $entry->intro,
						'pageContent' => $pageContent
					];
				}
			];    
		}
	]
];