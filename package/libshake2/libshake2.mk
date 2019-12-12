#############################################################
#
# LIBSHAKE2
#
#############################################################
LIBSHAKE2_VERSION = master
LIBSHAKE2_SITE = $(call github,zear,libshake,$(LIBSHAKE2_VERSION))
LIBSHAKE2_LICENSE = MIT
LIBSHAKE2_LICENSE_FILES = LICENSE.txt
LIBSHAKE2_INSTALL_STAGING = YES

LIBSHAKE2_MAKE_ENV = PREFIX=/usr BACKEND=LINUX AR="$(TARGET_AR)" CC="$(TARGET_CC)" LD="$(TARGET_CC)" STRIP="$(TARGET_STRIP)"

define LIBSHAKE2_BUILD_CMDS
	$(LIBSHAKE2_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBSHAKE2_INSTALL_STAGING_CMDS
	$(LIBSHAKE2_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBSHAKE2_INSTALL_TARGET_CMDS
	$(LIBSHAKE2_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))