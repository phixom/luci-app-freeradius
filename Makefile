include $(TOPDIR)/rules.mk
#include ../../luci.mk


LUCI_TITLE:=Freeradius3 LuCI Interface
LUCI_DEPENDS:=+luci-mod-admin-full
PKG_NAME:=luci-app-freeradius
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_MAINTAINER:=Alexander Wendland <nospam@phixom.de>
PKG_LICENSE:=GPLv1
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-freeradius
   SECTION:=luci
   CATEGORY:=Network
   DEPENDS:=+freeradius3 +freeradius3-common +freeradius3-democerts +freeradius3-mod-always +freeradius3-mod-attr-filter +freeradius3-mod-chap +freeradius3-mod-detail +freeradius3-mod-digest +freeradius3-mod-eap +freeradius3-mod-eap-gtc +freeradius3-mod-eap-leap +freeradius3-mod-eap-md5 +freeradius3-mod-eap-mschapv2 +freeradius3-mod-eap-peap +freeradius3-mod-eap-tls +freeradius3-mod-eap-ttls +freeradius3-mod-exec +freeradius3-mod-expiration +freeradius3-mod-expr +freeradius3-mod-files +freeradius3-mod-ldap +freeradius3-mod-logintime +freeradius3-mod-mschap +freeradius3-mod-pap +freeradius3-mod-passwd +freeradius3-mod-preprocess +freeradius3-mod-radutmp +freeradius3-mod-realm +freeradius3-mod-unix +freeradius3-utils
   TITLE:=Freeradius Server Management
   MAINTAINER:=Alexander Wendland <nospam@phixom.de>
   PKGARCH:=all
endef

define Package/luci-app-freeradius/description
Freeradius3 Server Management
endef

define Package/luci-app-freeradius/conffiles
/etc/config/freeradius
endef

define Package/luci-app-freeradius/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/config/freeradius $(1)/etc/config/freeradius
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults/luci-freeradius $(1)/etc/uci-defaults/luci-freeradius
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/controller/freerad.lua $(1)/usr/lib/lua/luci/controller/freerad.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/freeradius
	$(INSTALL_DATA) ./files/cbi/clients.lua $(1)/usr/lib/lua/luci/model/cbi/freeradius/clients.lua
	$(INSTALL_DATA) ./files/cbi/users.lua $(1)/usr/lib/lua/luci/model/cbi/freeradius/users.lua
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) ./files/lib/freeradius.sh $(1)/usr/lib/freeradius.sh
endef

define Package/luci-app-freeradius3/postinst
#!/bin/sh
[ ! -z "$${IPKG_INSTROOT}" ] && exit 0
. /etc/uci-defaults/luci-freeradius
rm -f /etc/uci-defaults/luci-freeradius
endef

define Build/Compile
endef

$(eval $(call BuildPackage,luci-app-freeradius))
