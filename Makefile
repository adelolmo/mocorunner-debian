BUILD_DIR=build
MOCO_VERSION := $(shell cat VERSION)
JAR_FILE = $(BUILD_DIR)/moco-runner-$(MOCO_VERSION)-standalone.jar

build: clean prepare $(JAR_FILE)
	sed -i 's/{{version}}/'$(MOCO_VERSION)'/g' $(BUILD_DIR)/package/DEBIAN/control
	sed -i 's/{{version}}/'$(MOCO_VERSION)'/g' $(BUILD_DIR)/package/usr/bin/mocorunner
	fakeroot dpkg-deb -b -z9 $(BUILD_DIR)/package $(BUILD_DIR)/release/mocorunner_$(MOCO_VERSION)_all.deb

clean:
	rm -rf $(BUILD_DIR)/tmp $(BUILD_DIR)/package $(BUILD_DIR)/release

prepare:
	mkdir -p $(BUILD_DIR)/tmp $(BUILD_DIR)/release $(BUILD_DIR)/package/opt/mocorunner
	cp $(JAR_FILE) $(BUILD_DIR)/package/opt/mocorunner
	cp -R package/* $(BUILD_DIR)/package

$(JAR_FILE):
	wget -O $(JAR_FILE) https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/$(MOCO_VERSION)/moco-runner-$(MOCO_VERSION)-standalone.jar