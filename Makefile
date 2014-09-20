export ARCHS = armv7 arm64 armv7s
export SOURCE = src
export TARGET_IPHONEOS_DEPLOYMENT_VERSION = 5.0

export ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HTN
HTN_FILES = $(SOURCE)/Tweak.xm
HTN_FRAMEWORKS = Foundation UIKit CoreGraphics MyoKit
HTN_OBJC_FILES = $(SOURCE)/HTNController.m

include $(THEOS)/makefiles/tweak.mk