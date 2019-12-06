#############################################################
#
# libshake
#
#############################################################
LIBSHAKE_VERSION = 32174c6
LIBSHAKE_SITE = $(call github,zear,libShake,$(LIBSHAKE_VERSION))
LIBSHAKE_LICENSE = MIT
LIBSHAKE_LICENSE_FILES = LICENSE.txt
LIBSHAKE_INSTALL_STAGING = YES

LIBSHAKE_MAKE_ENV = PREFIX=/usr BACKEND=LINUX AR="$(TARGET_AR)" CC="$(TARGET_CC)" LD="$(TARGET_CC)" STRIP="$(TARGET_STRIP)"

define LIBSHAKE_BUILD_CMDS
	$(LIBSHAKE_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBSHAKE_INSTALL_STAGING_CMDS
	$(LIBSHAKE_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBSHAKE_INSTALL_TARGET_CMDS
	$(LIBSHAKE_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
