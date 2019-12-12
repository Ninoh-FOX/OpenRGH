################################################################################
#
# esoteric
#
################################################################################
ESOTERIC_VERSION = master
ESOTERIC_SITE = $(call github,podulator,esoteric,$(ESOTERIC_VERSION))
ESOTERIC_DEPENDENCIES = dejavu libpng sdl sdl_ttf sdl_gfx
ESOTERIC_INSTALL_TARGET = YES

ESOTERIC_MAKE_OPTS = \
    MD="mkdir -p" \
    CROSS_COMPILE="$(TARGET_CROSS)"
    
ifeq ($(BR2_PACKAGE_LIBOPK),y)
ESOTERIC_DEPENDENCIES += libopk
endif

ifeq ($(BR2_PACKAGE_LIBXDGMIME),y)
ESOTERIC_DEPENDENCIES += libxdgmime
endif

define ESOTERIC_BUILD_CMDS
    $(MAKE) $(ESOTERIC_MAKE_OPTS) -C $(@D) all dist \
        -f Makefile.${BR2_PACKAGE_ESOTERIC_PLATFORM}
endef

define ESOTERIC_INSTALL_ESOTERIC
    (   cd $(@D) ; \
	if [ -D $(TARGET_DIR)/usr/share/esoteric ]; then \
		echo "removing old directory"; \
		rm -rf $(TARGET_DIR)/usr/share/esoteric ; \
	fi ; \
	cp -r dist/$(BR2_PACKAGE_ESOTERIC_PLATFORM)/esoteric $(TARGET_DIR)/usr/share/ ; \
	if [ -L $(TARGET_DIR)/usr/bin/esoteric ]; then \
		echo "removing old link"; \
		rm -rf $(TARGET_DIR)/usr/bin/esoteric ; \
	fi ; \
	ln -rs $(TARGET_DIR)/usr/share/esoteric/esoteric $(TARGET_DIR)/usr/bin/esoteric ; )
endef
ESOTERIC_POST_INSTALL_TARGET_HOOKS += ESOTERIC_INSTALL_ESOTERIC


$(eval $(generic-package))
