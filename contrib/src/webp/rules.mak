# webp

WEBP_VERSION := 0.6.1
WEBP_URL := https://github.com/webmproject/libwebp/archive/refs/tags/v$(WEBP_VERSION).tar.gz

$(TARBALLS)/libwebp-$(WEBP_VERSION).tar.gz:
	$(call download,$(WEBP_URL))

.sum-webp: libwebp-$(WEBP_VERSION).tar.gz

ifdef HAVE_ANDROID
ifeq ($(MY_TARGET_ARCH),armeabi-v7a)
	mkdir -p $(PREFIX)/lib
	cp $(PREFIX)/../../src/webp/libcpufeatures.a $(PREFIX)/lib/
endif
endif

webp: libwebp-$(WEBP_VERSION).tar.gz .sum-webp
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.webp: webp
	cd $< && ./autogen.sh
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE)
	cd $< && $(MAKE) install
	touch $@
