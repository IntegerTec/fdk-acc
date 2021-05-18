# 宏函数，返回当前路径，表示android.mk所在路径
LOCAL_PATH:= $(call my-dir)
# 声明CLEAR_VARS变量，CLEAR_VARS变量指向一个特殊的GNU Makefile，该Makefile会清除很多LOCAL_XXX 变量
# 例如LOCAL_MODULE、LOCAL_SRC_FILES 和 LOCAL_STATIC_LIBRARIES，GNU Makefile 不会清除 LOCAL_PATH
include $(CLEAR_VARS)
# LOCAL_MODULE 变量存储要构建的模块的名称，每个模块中使用一次此变量
# 每个模块名称必须唯一，且不含任何空格
LOCAL_MODULE := FraunhoferAAC
# 列举源文件，以空格分隔多个文件
# LOCAL_SRC_FILES := libAACdec/src/*.cpp libAACenc/src/*.cpp libPCMutils/src/*.cpp \
#     libFDK/src/*.cpp libSYS/src/*.cpp libMpegTPDec/src/*.cpp libMpegTPEnc/src/*.cpp \
#     libSBRdec/src/*.cpp libSBRenc/src/*.cpp libArithCoding/src/*.cpp libDRCdec/src/*.cpp \
#     libSACdec/src/*.cpp libSACenc/src/*.cpp
FILE_LIST := $(wildcard $(LOCAL_PATH)/../*.cpp)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
# cflags
LOCAL_CFLAGS := -DANDROID
LOCAL_CFLAGS += -Werror -Wno-unused-parameter -Wno-warnings -Wuninitialized -Wno-self-assign -Wno-implicit-fallthrough
LOCAL_LDLIBS := -lz -llog -landroid

# 导出头动态库的文件
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libAACdec/include $(LOCAL_PATH)/libAACenc/include \
    $(LOCAL_PATH)/libPCMutils/include $(LOCAL_PATH)/libFDK/include $(LOCAL_PATH)/libSYS/include \
    $(LOCAL_PATH)/libMpegTPDec/include $(LOCAL_PATH)/libMpegTPEnc/include $(LOCAL_PATH)/libSBRdec/include \
    $(LOCAL_PATH)/libSBRenc/include $(LOCAL_PATH)/libArithCoding/include $(LOCAL_PATH)/libDRCdec/include \
    $(LOCAL_PATH)/libSACdec/include $(LOCAL_PATH)/libSACenc/include

# BUILD_SHARED_LIBRARY 变量指向一个 GNU Makefile 脚本，该脚本会收集最近 include 以来在 LOCAL_XXX 变量中定义的所有信息
# 此脚本确定要构建的内容以及构建方式
# BUILD_STATIC_LIBRARY 静态库
# BUILD_SHARED_LIBRARY 动态库
# BUILD_EXECUTABLE 可执行文件
include $(BUILD_SHARED_LIBRARY)

