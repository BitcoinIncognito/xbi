# - Find Miniupnp
# This module defines
# MINIUMNP_INCLUDE_DIR, where to find Miniupnp headers
# MINIUMNP_LIBRARY, Miniupnp libraries
# MINIUMNP_FOUND, If false, do not try to use Miniupnp

set(MINIUMNP_PREFIX "" CACHE PATH "path ")

find_path(MINIUMNP_INCLUDE_DIR miniupnpc.h
        PATHS ${MINIUMNP_PREFIX}/include /usr/include /usr/local/include
        PATH_SUFFIXES miniupnpc)

find_library(MINIUMNP_LIBRARY NAMES miniupnpc libminiupnpc
        PATHS ${MINIUMNP_PREFIX}/lib /usr/lib /usr/local/lib)

if(MINIUMNP_INCLUDE_DIR AND MINIUMNP_LIBRARY)
    get_filename_component(MINIUMNP_LIBRARY_DIR ${MINIUMNP_LIBRARY} PATH)
    set(MINIUMNP_FOUND TRUE)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
        Miniupnpc DEFAULT_MSG
        MINIUMNP_INCLUDE_DIR
        MINIUMNP_LIBRARY
)

if(MINIUMNP_FOUND)
    file(STRINGS "${MINIUMNP_INCLUDE_DIR}/miniupnpc.h" MINIUMNPC_API_VERSION_STR REGEX "^#define[\t ]+MINIUMNPC_API_VERSION[\t ]+[0-9]+")
    if(MINIUMNPC_API_VERSION_STR MATCHES "^#define[\t ]+MINIUMNPC_API_VERSION[\t ]+([0-9]+)")
        set(MINIUMNPC_API_VERSION "${CMAKE_MATCH_1}")
        if (${MINIUMNPC_API_VERSION} GREATER "10" OR ${MINIUMNPC_API_VERSION} EQUAL "10")
            if(NOT Miniupnp_FIND_QUIETLY)
                message(STATUS "Found Miniupnpc API version " ${MINIUMNPC_API_VERSION})
            endif()
            set(MINIUMNP_FOUND true)
        else()
            message(FATAL_ERROR "Unsupported Miniupnpc version!")
        endif()
    endif()
else()
    if(MINIUMNP_FIND_REQUIRED)
        message(FATAL_ERROR "Could not find Miniupnp")
    endif()
endif()

mark_as_advanced(
        MINIUMNP_LIBRARY
        MINIUMNP_INCLUDE_DIR
)