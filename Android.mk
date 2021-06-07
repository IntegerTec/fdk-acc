# 宏函数，返回当前路径，表示android.mk所在路径
LOCAL_PATH:= $(call my-dir)
# 声明CLEAR_VARS变量，CLEAR_VARS变量指向一个特殊的GNU Makefile，该Makefile会清除很多LOCAL_XXX 变量
# 例如LOCAL_MODULE、LOCAL_SRC_FILES 和 LOCAL_STATIC_LIBRARIES，GNU Makefile 不会清除 LOCAL_PATH
include $(CLEAR_VARS)
# LOCAL_MODULE 变量存储要构建的模块的名称，每个模块中使用一次此变量
# 每个模块名称必须唯一，且不含任何空格
LOCAL_MODULE := FraunhoferAAC

aacdec_sources := $(wildcard $(LOCAL_PATH)/libAACdec/src/*.cpp)
aacdec_sources := $(aacdec_sources:$(LOCAL_PATH)/libAACdec/src/%=%)

aacenc_sources := $(wildcard $(LOCAL_PATH)/libAACenc/src/*.cpp)
aacenc_sources := $(aacenc_sources:$(LOCAL_PATH)/libAACenc/src/%=%)

pcmutils_sources := $(wildcard $(LOCAL_PATH)/libPCMutils/src/*.cpp)
pcmutils_sources := $(pcmutils_sources:$(LOCAL_PATH)/libPCMutils/src/%=%)

fdk_sources := $(wildcard $(LOCAL_PATH)/libFDK/src/*.cpp)
fdk_sources := $(fdk_sources:$(LOCAL_PATH)/libFDK/src/%=%)

sys_sources := $(wildcard $(LOCAL_PATH)/libSYS/src/*.cpp)
sys_sources := $(sys_sources:$(LOCAL_PATH)/libSYS/src/%=%)

mpegtpdec_sources := $(wildcard $(LOCAL_PATH)/libMpegTPDec/src/*.cpp)
mpegtpdec_sources := $(mpegtpdec_sources:$(LOCAL_PATH)/libMpegTPDec/src/%=%)

mpegtpenc_sources := $(wildcard $(LOCAL_PATH)/libMpegTPEnc/src/*.cpp)
mpegtpenc_sources := $(mpegtpenc_sources:$(LOCAL_PATH)/libMpegTPEnc/src/%=%)

sbrdec_sources := $(wildcard $(LOCAL_PATH)/libSBRdec/src/*.cpp)
sbrdec_sources := $(sbrdec_sources:$(LOCAL_PATH)/libSBRdec/src/%=%)

sbrenc_sources := $(wildcard $(LOCAL_PATH)/libSBRenc/src/*.cpp)
sbrenc_sources := $(sbrenc_sources:$(LOCAL_PATH)/libSBRenc/src/%=%)

sacdec_sources := $(wildcard $(LOCAL_PATH)/libSACdec/src/*.cpp)
sacdec_sources := $(sacdec_sources:$(LOCAL_PATH)/libSACdec/src/%=%)

sacenc_sources := $(wildcard $(LOCAL_PATH)/libSACenc/src/*.cpp)
sacenc_sources := $(sacenc_sources:$(LOCAL_PATH)/libSACenc/src/%=%)

drcdec_sources := $(wildcard $(LOCAL_PATH)/libDRCdec/src/*.cpp)
drcdec_sources := $(drcdec_sources:$(LOCAL_PATH)/libDRCdec/src/%=%)

arithcoding_sources := $(wildcard $(LOCAL_PATH)/libArithCoding/src/*.cpp)
arithcoding_sources := $(arithcoding_sources:$(LOCAL_PATH)/libArithCoding/src/%=%)

LOCAL_SRC_FILES := \
	$(aacdec_sources:%=libAACdec/src/%) \
	$(aacenc_sources:%=libAACenc/src/%) \
	$(arithcoding_sources:%=libArithCoding/src/%) \
	$(pcmutils_sources:%=libPCMutils/src/%) \
	$(fdk_sources:%=libFDK/src/%) \
	$(sys_sources:%=libSYS/src/%) \
	$(mpegtpdec_sources:%=libMpegTPDec/src/%) \
	$(mpegtpenc_sources:%=libMpegTPEnc/src/%) \
	$(sbrdec_sources:%=libSBRdec/src/%) \
	$(sbrenc_sources:%=libSBRenc/src/%) \
	$(sacdec_sources:%=libSACdec/src/%) \
	$(sacenc_sources:%=libSACenc/src/%) \
	$(drcdec_sources:%=libDRCdec/src/%)

LOCAL_CFLAGS := -DANDROID
LOCAL_CFLAGS += -Wno-sequence-point -Wno-extra


LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/libAACdec/include \
        $(LOCAL_PATH)/libAACenc/include \
        $(LOCAL_PATH)/libArithCoding/include \
        $(LOCAL_PATH)/libPCMutils/include \
        $(LOCAL_PATH)/libFDK/include \
        $(LOCAL_PATH)/libSYS/include \
        $(LOCAL_PATH)/libMpegTPDec/include \
        $(LOCAL_PATH)/libMpegTPEnc/include \
        $(LOCAL_PATH)/libSBRdec/include \
        $(LOCAL_PATH)/libSBRenc/include \
        $(LOCAL_PATH)/libSACdec/include \
        $(LOCAL_PATH)/libSACenc/include \
        $(LOCAL_PATH)/libDRCdec/include


#LOCAL_EXPORT_SHARED_LIBRARY_HEADERS := $(HEADER_LIST:$(LOCAL_PATH)/%=%)
#LOCAL_EXPORT_STATIC_LIBRARY_HEADERS := $(HEADER_LIST:$(LOCAL_PATH)/%=%)
# $(info "LOCAL_EXPORT_SHARED_LIBRARY_HEADERS = $(LOCAL_EXPORT_SHARED_LIBRARY_HEADERS)")

# 设置输出目录
FDK_AAC_SRC_INCLUDE_DIR := $(LOCAL_PATH)/libAACdec \
		$(LOCAL_PATH)/libAACenc \
        $(LOCAL_PATH)/libArithCoding \
        $(LOCAL_PATH)/libPCMutils \
        $(LOCAL_PATH)/libFDK \
        $(LOCAL_PATH)/libSYS \
        $(LOCAL_PATH)/libMpegTPDec \
        $(LOCAL_PATH)/libMpegTPEnc \
        $(LOCAL_PATH)/libSBRdec \
        $(LOCAL_PATH)/libSBRenc \
        $(LOCAL_PATH)/libSACdec \
        $(LOCAL_PATH)/libSACenc \
        $(LOCAL_PATH)/libDRCdec

FDK_AAC_DST_LIB_DIR := $(LOCAL_PATH)/../../jni/fdkaac
FDK_AAC_DST_INCLUDE_DIR := $(LOCAL_PATH)/../../jni/fdkaac/include
NDK_APP_DST_DIR := $(FDK_AAC_DST_LIB_DIR)/lib/$(TARGET_ARCH_ABI)


# BUILD_SHARED_LIBRARY 变量指向一个 GNU Makefile 脚本，该脚本会收集最近 include 以来在 LOCAL_XXX 变量中定义的所有信息
# 此脚本确定要构建的内容以及构建方式
# BUILD_STATIC_LIBRARY 静态库
# BUILD_SHARED_LIBRARY 动态库
# BUILD_EXECUTABLE 可执行文件
include $(BUILD_SHARED_LIBRARY)
#include $(BUILD_STATIC_LIBRARY)
$(shell rm -rf $(FDK_AAC_DST_LIB_DIR))
$(shell mkdir -p $(FDK_AAC_DST_LIB_DIR))
$(foreach dir, $(FDK_AAC_SRC_INCLUDE_DIR), $(shell cp -rf $(dir) $(FDK_AAC_DST_INCLUDE_DIR)))
#$(info "LOCAL_C_INCLUDES = $(LOCAL_C_INCLUDES)")
#$(shell cp -af $(LOCAL_C_INCLUDES) $(FDK_AAC_INCLUDE_DIR))
#$(info "LOCAL_INSTALLED11111 = $(LOCAL_INSTALLED)")

