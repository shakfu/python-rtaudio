set(PROJECT_NAME custom)

set(PROJECT_SRC ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}module.cpp)

add_library( 
    ${PROJECT_NAME} 
    MODULE
    ${PROJECT_SRC}
)

add_dependencies(
    ${PROJECT_NAME}
    rtaudio
)

string(TOLOWER ${CMAKE_SYSTEM_NAME} platform)
set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
    PREFIX ""
    LIBRARY_OUTPUT_NAME "${PROJECT_NAME}.cpython-311-${platform}"
)
    
target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
    ${Python_INCLUDE_DIRS}
    ${PROJECT_INCLUDES}/
)

target_compile_definitions(
    ${PROJECT_NAME}
    PUBLIC
    $<$<BOOL:${DEBUG}>:Py_DEBUG=1>
)

target_compile_options(
    ${PROJECT_NAME}
    PUBLIC
    -std=c++14
    $<$<PLATFORM_ID:Darwin>:-Wno-unused-result>
    $<$<PLATFORM_ID:Darwin>:-Wsign-compare>
    $<$<PLATFORM_ID:Darwin>:-Wunreachable-code>
    $<$<PLATFORM_ID:Darwin>:-fno-common>
    $<$<PLATFORM_ID:Darwin>:-Wall>  
    $<$<PLATFORM_ID:Darwin>:-g>
    $<$<PLATFORM_ID:Darwin>:-fwrapv>
    $<$<PLATFORM_ID:Darwin>:-O3>
    $<$<PLATFORM_ID:Windows>:/O2>
    $<$<PLATFORM_ID:Windows>:/MD> # api module works with this
)

target_link_options(
    ${PROJECT_NAME}
    PUBLIC
    $<$<PLATFORM_ID:Darwin>:-dynamic>
)

target_link_directories(
    ${PROJECT_NAME} 
    PUBLIC
    ${Python_LIBRARY_DIRS}
    ${PROJECT_LIB_DIRS}
)

target_link_libraries(
    ${PROJECT_NAME} 
    PUBLIC
    ${Python_LIBRARIES}
    "$<$<PLATFORM_ID:Darwin>:-ldl>"
)
