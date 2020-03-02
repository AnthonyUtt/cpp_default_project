function(set_project_warnings project_name)
    option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" TRUE)

    set(MSVC_WARNINGS
        /W4  # Base reasonable warnings
        /w14242  # 'identifier': conversion from 'type1' to 'type1', possible loss of data
        /w14254  # 'operator': coversion from 'type1:field_bits' to 'type2:field_bits', possible loss of data
        /w14263  # 'function': member function does not override any base class virtual member function
        /w14265  # 'classname': class has virtual functions, but destructor is not virtual. Instances of this class may not be destructed correctly
        /w14287  # 'operator': unsigned/negative constant mismatch
        /we4289  # nonstandard extension used: 'variable': loop control variable declared in the for-loop is used outside the for-loop scope
        /w14296  # 'operator': expression is always 'boolean_value'
        /w14311  # 'variable': pointer truncation from 'type1' to 'type2'
        /w14545  # expression before comma evaluates to a function which is missing an argument list
        /w14546  # function call before comma missing argument list
        /w14547  # 'operator': operator before comma has no effect; expected operator with side-effect
        /w14549  # 'operator': operator before comma has no effect; did you intend 'operator'?
        /w14555  # expression has no effect; expected expression with side-effect
        /w14619  # pragma warning: there is no warning number 'number'
        /w14640  # Enable warning on thread un-safe static member initialization
        /w14826  # Conversion from 'type1' to 'type_2' is sign-extended. This may cause unexpected runtime behavior.
        /w14905  # wide string literal cast to 'LPSTR'
        /w14906  # string literal cast to 'LPWSTR'
        /w14928  # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
    )

    set(CLANG_WARNINGS
        -Wall
        -Wextra  # reasonable/standard
        -Wshadow  # variable declaration overrides parent context
        -Wnon-virtual-dtor  # same as /w14265 above
        -Wold-style-cast  # warn for c-style casts
        -Wcast-align  # warn for potential performance problem casts
        -Wunused  # warn for anything unused
        -Woverloaded-virtual  # warn if virtual function is overloaded vs overrided
        -Wpedantic  # warn if non-standard C++ is used
        -Wconversion  # warn on sign conversion
        -Wnull-dereference  # warn on null dereference
        -Wdouble-promotion  # warn if float is implicitly promoted to double
        -Wformat=2  # warn on security issues around funcitons that format output
    )

    if(WARNINGS_AS_ERRORS)
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif()

    set(GCC_WARNINGS
        ${CLANG_WARNINGS}
        -Wmisleading-indentation  # warn if indentation implies blocks where blocks do not exist
        -Wduplicated-cond  # warn if if/else chain has duplicate conditions
        #-Wduplicated-branches  # warn if if/else branches have duplicate code
        -Wlogical-op  # warn about logical operations being used where bitwise is probably wanted
        -Wuseless-cast  # warn about casting to same type
    )

    if (MSVC)
        set(WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(WARNINGS ${CLANG_WARNINGS})
    else()
        set(WARNINGS ${GCC_WARNINGS})
    endif()

    target_compile_options(${project_name} INTERFACE ${WARNINGS})
    
endfunction()