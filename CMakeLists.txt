cmake_minimum_required(VERSION 3.13)

include(cmake/bpl8.cmake)
project(cspice
        VERSION 66.1
        LANGUAGES C
        )
bpl8_project_setup()

include(CheckCCompilerFlag)
check_c_compiler_flag(-Wno-implicit-int HAVE_WNO_IMPLICIT_INT)
if(HAVE_WNO_IMPLICIT_INT)
    add_compile_options(-Wno-implicit-int)
endif()

bpl8_add_library(cspice SHARED)
add_subdirectory(src)
add_subdirectory(include)

set_target_properties(cspice PROPERTIES
    SOVERSION ${PROJECT_VERSION_MAJOR}
    VERSION   ${PROJECT_VERSION}
    )

target_include_directories(cspice PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/cspice>
    )
install(TARGETS cspice
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cspice
    )
