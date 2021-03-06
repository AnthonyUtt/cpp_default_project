option(ENABLE_CPPCHECK "Enable static analysis with cppcheck" OFF)
option(ENABLE_CLANG_TIDY "Enable static analysis with clang-tidy" OFF)

if(ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude
            --enable=all --inconclusive -i ${PROJECT_SOURCE_DIR}/src/)
    else()
        message(SEND_ERROR "CPPCheck requested but not found!")
    endif()
endif()

if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY clang-tidy)
    if(CLANG_TIDY)
        set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY})
    else()
        message(SEND_ERROR "clang-tidy requested but not found!")
    endif()
endif()