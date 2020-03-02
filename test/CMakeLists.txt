if(CONAN_CATCH2_ROOT_DEBUG)
    include(${CONAN_CATCH2_ROOT_DEBUG}/lib/cmake/Catch2/catch.cmake)
else()
    include(${CONAN_CATCH2_ROOT}/lib/cmake/Catch2/Catch.cmake)
endif()

# Adding file that defines catch's main() function
add_library(catch_main STATIC catch_main.cpp)
target_link_libraries(catch_main PUBLIC CONAN_PKG::catch2)

# Creating basic tests executable
add_executable(tests tests.cpp)
target_link_libraries(tests PRIVATE project_options project_warnings catch_main)

# Looking for tests with catch. The "unit." prefix can be changed.
catch_discover_tests(
    tests
    TEST_PREFIX
    "unit."
    EXTRA_ARGS
    -s
    --reporter=xml
    --out=tests.xml
)

# Creating constexpr tests executable
add_executable(constexpr_tests constexpr_tests.cpp)
target_link_libraries(constexpr_tests PRIVATE project_options project_warnings catch_main)

# Looking for constexpr tests
catch_discover_tests(
    constexpr_tests
    TEST_PREFIX
    "constexpr."
    EXTRA_ARGS
    -s
    --reporter=xml
    --out=constexpr.xml
)
    
# Disabling constexpr for debugging tests
add_executable(relaxed_constexpr constexpr_tests.cpp)
target_link_libraries(relaxed_constexpr PRIVATE project_options project_warnings catch_main)
target_compile_definitions(relaxed_constexpr PRIVATE -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE)

catch_discover_tests(
    relaxed_constexpr
    TEST_PREFIX
    "relaxed_constexpr."
    EXTRA_ARGS
    -s
    --reporter=xml
    --out=relaxed_constexpr.xml
)