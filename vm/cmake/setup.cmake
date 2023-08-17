#!/usr/bin/env cmake
#
# setup all necessary build definition variables
#

if(SELF_X11)
    message(STATUS "Using X11 plaform windows.")
    list(APPEND _defines -DXLIB)
endif()

list(APPEND _defines
  -DFAST_COMPILER
  -DSIC_COMPILER
  -DNATIVE_ARCH=${platform_processor}
  ${DYNAMIC}
)

add_definitions_if_cmakevar(
  COMPILER
  TARGET_OS_VERSION
  TARGET_OS_FAMILY
  TARGET_ARCH
  HOST_ARCH
)


#
# setup all necessary build flags
#
list(APPEND _flags
  -fno-omit-frame-pointer
  -fno-delete-null-pointer-checks
  -fno-threadsafe-statics
  -fvisibility=default
  -fno-exceptions
  -fno-stack-protector
)

if(SELF_COVERAGE)
  list(APPEND _flags --coverage)
endif()

if(SELF_PROFILE)
  list(APPEND _flags -pg)
endif()

#
# setup all warning flags
#
if (clang)
  list(APPEND _flags -Wabi)
elseif(gcc)
  list(APPEND _flags -Wabi=11)
endif()
list(APPEND _flags
  -Wreorder
  -Wreturn-type
  -Wswitch
  -Wcomment
  -Wformat
  -Wpointer-arith
  -Woverloaded-virtual
  -Wno-write-strings
  -Wparentheses
)
