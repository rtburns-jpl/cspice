include(CMakePackageConfigHelpers)
file(
    WRITE ${CMAKE_BINARY_DIR}/project-config.cmake.in
    [[
@PACKAGE_INIT@
include(${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@-targets.cmake)
]]
)

function(bpl8_install_targets)
    install(
        TARGETS ${ARGN}
        EXPORT ${PROJECT_NAME}-targets
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endfunction()

macro(bpl8_full_rpath)
    # don't skip full RPATH for build tree
    set(CMAKE_SKIP_BUILD_RPATH NO)
    # don't use install RPATH when building
    set(CMAKE_BUILD_WITH_INSTALL_RPATH NO)
    # add non-system linker dirs to install RPATH
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH YES)
    # use RPATH when not installing to system dir
    if(NOT CMAKE_INSTALL_FULL_LIBDIR IN_LIST
       CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES
    )
        set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
    endif()
endmacro()

macro(bpl8_project_setup)
    if("${CMAKE_SOURCE_DIR}" STREQUAL "${PROJECT_SOURCE_DIR}")
        set(IS_ROOT_PROJECT YES)
    else()
        set(IS_ROOT_PROJECT NO)
    endif()
    include(GNUInstallDirs)

    set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_FULL_LIBDIR})

    # hardcoded new policy behavior
    if(CMAKE_EXPORT_PACKAGE_REGISTRY)
        export(PACKAGE ${PROJECT_NAME})
    endif()

    set(CMAKE_DIR share/cmake/${PROJECT_NAME})

    configure_package_config_file(
        ${CMAKE_BINARY_DIR}/project-config.cmake.in
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        INSTALL_DESTINATION ${CMAKE_DIR}
    )
    install(FILES ${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
            DESTINATION ${CMAKE_DIR}
    )

    install(
        EXPORT ${PROJECT_NAME}-targets
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION ${CMAKE_DIR}
    )
    export(
        EXPORT ${PROJECT_NAME}-targets
        NAMESPACE ${PROJECT_NAME}::
        FILE ${PROJECT_NAME}-targets.cmake
    )

    bpl8_full_rpath()
endmacro()

macro(bpl8_add_library name)
    add_library(${name} ${ARGN})
    add_library(${PROJECT_NAME}::${name} ALIAS ${name})
    bpl8_install_targets(${name})
endmacro()
