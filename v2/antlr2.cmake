# Determine the architecture.

if("${CMAKE_SIZEOF_VOID_P}" EQUAL "8")
    MESSAGE(STATUS "64 bit architecture") 
    set(PKGARCH "x86_64") 
else() 
    MESSAGE(STATUS "32 bit architecture") 
    set(PKGARCH "i386")
endif()

# Now setup ANTRL2
set(ANTLR_HOME ${CMAKE_CURRENT_LIST_DIR}/external/_antlr_install)
set(ANTLR_INCLUDE_DIR ${ANTLR_HOME}/include)
set(ANTLR_JAR_FILE ${ANTLR_HOME}/lib/antlr.jar)
set(ANTLR_LIBRARY ${ANTLR_HOME}/lib/libantlr.a)
set(Antlr_LIBRARIES ${ANTLR_LIBRARY})
set(Antlr_EXECUTABLE java -classpath ${ANTLR_JAR_FILE} antlr.Tool)

macro(ADD_ANTLR_GRAMMAR grammar_file output_var output_html)
    get_filename_component(_grammar_dir ${grammar_file} DIRECTORY)
    file(READ ${grammar_file} _antlr_grammar_data)

    string(REGEX MATCHALL "class +([^ ]+) +extends" _antlr_classes "${_antlr_grammar_data}")
    string(REGEX REPLACE  "class +([^ ]+) +extends" "\\1" _antlr_classes "${_antlr_classes}")

    list(LENGTH _antlr_classes _antlr_classes_count)
    message(STATUS "Found ${_antlr_classes_count} Antlr classes: ${_antlr_classes}")
    string(REGEX REPLACE "([^;]+)" "${CMAKE_CURRENT_BINARY_DIR}/\\1.cpp;${CMAKE_CURRENT_BINARY_DIR}/\\1.hpp" _antlr_generated_files "${_antlr_classes}")
    string(REGEX REPLACE "([^;]+)" "${CMAKE_CURRENT_BINARY_DIR}/\\1.html" _antlr_generated_doc_files "${_antlr_classes}")

    # Trick: Antlr does not update the output files if they have
    # not been changed. This breaks builds with cmake/Makefile since
    # the source file keeps an update time > than the output files.
    # Fix it by using touch
    add_custom_command(OUTPUT ${_antlr_generated_files}
        COMMAND ${Antlr_EXECUTABLE} ${grammar_file}
        COMMAND ${Antlr_EXECUTABLE} -html ${grammar_file}
        COMMAND touch ${_antlr_generated_files}
        DEPENDS ${grammar_file})
    set(${output_var} "${_antlr_generated_files}")
    set(${output_html} "${_antlr_generated_doc_files}")
endmacro(ADD_ANTLR_GRAMMAR)
