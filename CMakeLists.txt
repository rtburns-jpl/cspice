cmake_minimum_required(VERSION 3.13)

project(cspice LANGUAGES C)

include(GNUInstallDirs)

add_library(cspice SHARED)
add_subdirectory(src)
add_subdirectory(include)

target_include_directories(cspice PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/cspice>
    )
install(TARGETS cspice
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cspice
    )

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
