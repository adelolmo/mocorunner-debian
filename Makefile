MAKEFLAGS += --silent

BUILD_DIR = build
RELEASE_DIR = $(BUILD_DIR)/release
TMP_DIR = $(BUILD_DIR)/tmp
MOCO_VERSION := $(shell cat VERSION)
JAR_FILE = $(BUILD_DIR)/moco-runner-$(MOCO_VERSION)-standalone.jar

package: clean prepare $(JAR_FILE) cp control
	@echo Building package...
	fakeroot dpkg-deb -b -z9 $(TMP_DIR) $(RELEASE_DIR)/mocorunner_$(MOCO_VERSION)_all.deb

clean:
	rm -rf $(TMP_DIR) $(RELEASE_DIR)

prepare:
	mkdir -p $(RELEASE_DIR) $(TMP_DIR)/usr/bin $(TMP_DIR)/opt/mocorunner

$(JAR_FILE):
	@echo Downloading jar...
	wget --quiet -O $(JAR_FILE) https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/$(MOCO_VERSION)/moco-runner-$(MOCO_VERSION)-standalone.jar

cp:
	cp -R deb/* $(TMP_DIR)
	cp $(JAR_FILE) $(TMP_DIR)/opt/mocorunner

control:
	$(eval SIZE=$(shell du -sbk $(TMP_DIR)/ | grep -o '[0-9]*'))
	sed -i "s/{{version}}/$(MOCO_VERSION)/;s/{{size}}/$(SIZE)/" $(TMP_DIR)/DEBIAN/control
	sed -i "s/{{version}}/$(MOCO_VERSION)/g" $(TMP_DIR)/usr/bin/mocorunner
