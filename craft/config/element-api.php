<?php

use craft\elements\Entry;
// use craft\app\helpers\HeaderHelper;

return [
	'endpoints' => [
		'projects.json' => function () {
			if(isset($_SERVER['HTTP_REFERER'])) {
				$whitelist = [
					'*.local',
					'localhost:8080',
					'portfolio.local',
					'willfifer.com',
					'api.willfifer.com'
				];
				$request = $_SERVER['HTTP_REFERER'];
				$matches = 0;
				foreach($whitelist as $valid) {
					$matched = [];
					$valid = preg_replace('/\*/', '\w+', $valid);
					preg_match('/' . $valid . '(\/[^\.]*)?$/', $request, $matched);
					$matches += count($matched);
				}

				if ($matches > 0) {
					\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
				}
				else {
					\Craft::$app->response->headers->set('Access-Control-Allow-Origin', null);
				}
			}
			else {
				// \Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			}
			
			return [
				'elementType' => craft\elements\Entry::class,
				'criteria' => ['section' => 'projects'],
				'transformer' => function(craft\elements\Entry $entry) {

					$heroImage = [];
					if (sizeof($entry->heroImage)) {
						$image = $entry->heroImage[0];
						$heroImage = [
							'url' =>  $image->getUrl('masked'),
							'width' => $image->getWidth('masked'),
							'height' => $image->getHeight('masked')
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

					$thumbnail = [];
					if (sizeof($entry->thumbnail)) {
						$image = $entry->thumbnail[0];
						$thumbnail = [
							'url' =>  $image->getUrl('thumbnail'),
							'width' => $image->getWidth('thumbnail'),
							'height' => $image->getHeight('thumbnail')
						];
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
						$cat = [
							'slug' => $category->slug,
							'title' => $category->title,
							'id' => $category->id
						];
						if (sizeof($category->fontIcon)) {
							$cat['fontIcon'] = $category->fontIcon;
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
						'thumbnail' => $thumbnail,
						'entryId' => $entry->id,
						'website' => $entry->website,
						'categories' => $categories,
						'collaborators' => $collaborators,
						'layers' => $layers,
						'featured' => $entry->featured
					];
				}
			];    
		},
		'categories.json' => function () {
			if(isset($_SERVER['HTTP_REFERER'])) {
				$whitelist = [
					'*.local',
					'localhost:8080',
					'portfolio.local',
					'willfifer.com',
					'api.willfifer.com'
				];
				$request = $_SERVER['HTTP_REFERER'];
				$matches = 0;
				foreach($whitelist as $valid) {
					$matched = [];
					$valid = preg_replace('/\*/', '\w+', $valid);
					preg_match('/' . $valid . '(\/[^\.]*)?$/', $request, $matched);
					$matches += count($matched);
				}

				if ($matches > 0) {
					\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
				}
				else {
					\Craft::$app->response->headers->set('Access-Control-Allow-Origin', null);
				}
			}
			else {
				// \Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			}
			
			return [
				'elementType' => craft\elements\Category::class,
				'criteria' => ['group' => 'projectCategory'],
				'transformer' => function(craft\elements\Category $category) {

					$cat = [
						'slug' => $category->slug,
						'title' => $category->title,
						'id' => $category->id
					];

					if (sizeof($category->fontIcon)) {
						$cat['fontIcon'] = $category->fontIcon;
					}
					
					return $cat;
				}
			];    
		},
		'project/<entryId:\d+>.json' => function ($entryId) {
			\Craft::$app->response->headers->set('Access-Control-Allow-Origin', '*');
			
			return [
				'elementType' => craft\elements\Entry::class,
				'criteria' => ['id' => $entryId],
				'one' => true,
				'transformer' => function(craft\elements\Entry $entry) {
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

						if (sizeof($category->fontIcon)) {
							$cat['fontIcon'] = $category->fontIcon;
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