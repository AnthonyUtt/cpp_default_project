cmake_minimum_required(VERSION 3.12.4)

# Set up project name and default settings
project(default VERSION 1.0)
include(cmake/DefaultProjectSettings.cmake)

# "Library" for project options / C++ standard
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# "Library" for compiler warning flags
add_library(project_warnings INTERFACE)

# Add project warnings module
include(cmake/CompilerWarnings.cmake)
set_project_warnings(project_warnings)

# Add sanitizer module
include(cmake/CompilerSanitizers.cmake)
enable_sanitizers(project_options)

# Add doxygen
include(cmake/Doxygen.cmake)
enable_doxygen()

# Enable static analyzers
include(cmake/StaticAnalysis.cmake)

# Various extra options go here
option(BUILD_SHARED_LIBS "Enable compilation of shared libraries" OFF)
option(ENABLE_TESTING "Enable test builds" ON)

# Any pre-compiled header files should be placed in ${PROJECT_SOURCE_DIR}/include
option(ENABLE_PCH "Enable pre-compiled headers" OFF)
if(ENABLE_PCH)
    file(GLOB pch_files "${PROJECT_SOURCE_DIR}/include/*.h" "${PROJECT_SOURCE_DIR}/include/*.hpp")
    target_precompile_headers(project_options INTERFACE ${pch_files})
endif()

# Conan setup
set(CONAN_EXTRA_REQUIRES "")
set(CONAN_EXTRA_OPTIONS "")

include(cmake/Conan.cmake)
run_conan()

# Testing setup
if(ENABLE_TESTING)
    enable_testing()
    message(STATUS "Building tests")
    add_subdirectory(test)
endif()

# Create variable for source files
set(source_dir "${PROJECT_SOURCE_DIR}/src/")
file(GLOB source_files "${source_dir}/*.cpp")

# Add executable to build
add_executable(${PROJECT_NAME} ${source_files})
target_link_libraries(${PROJECT_NAME} PRIVATE project_options project_warnings)
