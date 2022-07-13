all: html view

html: index architecture manifest local_dev examples building_images

index:
	marp README.md -o index.html --allow=local-files
	sed -i 's/\.md/\.html/g' index.html

architecture:
	marp architecture.md -o architecture.html --allow=local-files
	sed -i 's/\.md/\.html/g' architecture.html

manifest:
	marp manifest.md -o manifest.html --allow=local-files
	sed -i 's/\.md/\.html/g' manifest.html

local_dev:
	marp local_dev.md -o local_dev.html --allow=local-files
	sed -i 's/\.md/\.html/g' local_dev.html

known_bugs:
	marp known_bugs.md -o known_bugs.html --allow=local-files
	sed -i 's/\.md/\.html/g' known_bugs.html

examples:
	marp examples.md -o examples.html --allow=local-files
	sed -i 's/\.md/\.html/g' examples.html

building_images:
	marp building_images.md -o building_images.html --allow=local-files

view:
	browse index.html

.PHONY: all pdf html