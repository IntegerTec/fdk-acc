# 宏函数，返回当前路径，表示android.mk所在路径
LOCAL_PATH:= $(call my-dir)
# 声明CLEAR_VARS变量，CLEAR_VARS变量指向一个特殊的GNU Makefile，该Makefile会清除很多LOCAL_XXX 变量
# 例如LOCAL_MODULE、LOCAL_SRC_FILES 和 LOCAL_STATIC_LIBRARIES，GNU Makefile 不会清除 LOCAL_PATH
include $(CLEAR_VARS)
# LOCAL_MODULE 变量存储要构建的模块的名称，每个模块中使用一次此变量
# 每个模块名称必须唯一，且不含任何空格
LOCAL_MODULE := FraunhoferAAC


# 头文件
HEADER_LIST := $(wildcard $(LOCAL_PATH)/libFDK/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libFDK/include/*/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libAACdec/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libAACenc/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libPCMutils/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libSYS/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libMpegTPDec/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libMpegTPEnc/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libSBRdec/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libSBRenc/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libArithCoding/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libDRCdec/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libSACdec/include/*.h)
HEADER_LIST += $(wildcard $(LOCAL_PATH)/libSACenc/include/*.h)
# LOCAL_C_INCLUDES := $(HEADER_LIST:$(LOCAL_PATH)/%=%)
LOCAL_C_INCLUDES := $(HEADER_LIST)
$(info "LOCAL_PATH = $(LOCAL_PATH)")

# 列举源文件，以空格分隔多个文件，遍历src目录
SRC_LIST += $(wildcard $(LOCAL_PATH)/libAACdec/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libAACdec/src/*/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libAACenc/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libPCMutils/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libFDK/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libFDK/src/*/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSYS/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libMpegTPDec/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libMpegTPEnc/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSBRdec/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSBRdec/src/*/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSBRenc/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libArithCoding/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libDRCdec/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSACdec/src/*.cpp)
SRC_LIST += $(wildcard $(LOCAL_PATH)/libSACenc/src/*.cpp)
#LOCAL_SRC_FILES := $(SRC_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES := $(SRC_LIST)

LOCAL_CPPFLAGS += -I$(LOCAL_SRC_FILES)
#LOCAL_CPPFLAGS += -DANDROID
#LOCAL_CPPFLAGS += -Werror -Wno-unused-parameter -Wno-#warnings -Wuninitialized -Wno-self-assign -Wno-implicit-fallthrough
LOCAL_LDLIBS := -lz -llog -landroid -lm
# cflags
#LOCAL_CFLAGS := -DANDROID
#LOCAL_CFLAGS += -Werror -Wno-unused-parameter -Wno-#warnings -Wuninitialized -Wno-self-assign -Wno-implicit-fallthrough

#LOCAL_EXPORT_C_INCLUDE_DIRS := ./jni/fdkaac/$(TARGET_ARCH_ABI)/include
# $(info "LOCAL_EXPORT_C_INCLUDE_DIRS = $(LOCAL_EXPORT_C_INCLUDE_DIRS)")


#LOCAL_EXPORT_SHARED_LIBRARY_HEADERS := $(HEADER_LIST:$(LOCAL_PATH)/%=%)
#LOCAL_EXPORT_STATIC_LIBRARY_HEADERS := $(HEADER_LIST:$(LOCAL_PATH)/%=%)
# $(info "LOCAL_EXPORT_SHARED_LIBRARY_HEADERS = $(LOCAL_EXPORT_SHARED_LIBRARY_HEADERS)")

# 设置输出目录
#NDK_APP_DST_DIR := ./jni/fdkaac/$(TARGET_ARCH_ABI)/lib


# BUILD_SHARED_LIBRARY 变量指向一个 GNU Makefile 脚本，该脚本会收集最近 include 以来在 LOCAL_XXX 变量中定义的所有信息
# 此脚本确定要构建的内容以及构建方式
# BUILD_STATIC_LIBRARY 静态库
# BUILD_SHARED_LIBRARY 动态库
# BUILD_EXECUTABLE 可执行文件
#include $(BUILD_SHARED_LIBRARY)
 include $(BUILD_STATIC_LIBRARY)

