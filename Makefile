.PHONY: pkg test

INCLUDE=.

test:
	mojo run -I ${INCLUDE} geo_features/test/test_coordinate_sequence.mojo

pkg:
	mkdir -p build/
	mojo package geo_features/ -o build/geo_features.mojopkg
