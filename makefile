# images:
# 	jpegoptim \
# 	--dest=assets/images \
# 	--overwrite \
# 	--force \
# 	--strip-all \
# 	--size=400 \
# 	_images/*.jpg 
.PHONY: explicit_phony


IMAGES_SRC_DIR=_images
IMAGES_DST_DIR=assets/images
IMAGES_SRC=$(wildcard $(IMAGES_SRC_DIR)/*)

images: $(IMAGES_SRC);

%.jpg: explicit_phony
	@convert \
	-strip \
	-interlace Plane \
	-colorspace RGB \
	-gaussian-blur 0.5 \
	-quality 60% \
	-filter Lanczos \
	-sampling-factor 4:2:0 \
	-adaptive-resize 30% \
	$@ \
	$(IMAGES_DST_DIR)/$(notdir $@)

%.png: explicit_phony
	@convert \
	-strip \
	-define png:compression-level=9  \
	-define png:compression-filter=5 \
	-define png:compression-strategy=2 \
	-adaptive-resize 30% \
	$@ \
	$(IMAGES_DST_DIR)/$(notdir $@)


explicit_phony: ;

# --threshold=50% \
# --max=80 \
	# --all-progressive \