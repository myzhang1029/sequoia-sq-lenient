DIRS=sequoia-cert-store sequoia-gpg-agent sequoia-keystore sequoia-policy-config sequoia-sq sequoia-wot sequoia

.PHONY: all patch clean

all: patch

patch: $(foreach item,$(DIRS), $(item).patched)

%.patched: % %.patch
	git -C $< apply ../$<.patch
	touch $@

clean:
	for i in $(DIRS); \
	do \
		if [ -f $$i.patched ]; \
		then \
			git -C $$i apply -R ../$$i.patch; \
			rm $$i.patched; \
		fi; \
	done
