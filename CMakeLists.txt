cmake_minimum_required(VERSION 3.13)

project(cspice
        VERSION 66.1
        LANGUAGES C
        )

include(GNUInstallDirs)

add_library(cspice SHARED)
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

# Agree with new CMP0090 behavior (no export by default)
if(CMAKE_VERSION VERSION_LESS 3.15 AND NOT CMAKE_EXPORT_PACKAGE_REGISTRY)
    set(CMAKE_EXPORT_NO_PACKAGE_REGISTRY ON)
endif()
export(PACKAGE cspice)
export(TARGETS cspice NAMESPACE cspice:: FILE cspice-targets.cmake)

add_library(cspice::cspice ALIAS cspice)

# install config file for find_package
include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${PROJECT_SOURCE_DIR}/cmake/cspice-config.cmake.in
    ${PROJECT_BINARY_DIR}/cspice-config.cmake
    INSTALL_DESTINATION share/cmake/cspice
    )

install(FILES ${PROJECT_BINARY_DIR}/cspice-config.cmake
        DESTINATION share/cmake/cspice
        )
