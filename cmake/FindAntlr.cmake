# This scripts finds the Antlr parser generator and language-specific configuration
# files as specified by the components field of FIND_PACKAGE. If antlr is available,
# a ADD_ANTLR_GRAMMAR macro is also defined which helps adding Antlr grammars to
# the build (see below)
#
#   FIND_PACKAGE(Antlr COMPONENTS lang1 lang2 ...)
# If Antlr is found, sets Antlr_FOUND to true and defines Antlr_EXECUTABLE as
# the parser generator (the script searches for antlr, cantlr and runantlr)
#
# The following language packages are supported:
#   CPP: C++ language support. It searches for the antlr-config script
#        and defines the related compiler flags, include directories
#        and libraries:
#      Antlr_ANTLR_CONFIG_EXECUTABLE is set to the full path of antlr-config
#      Antlr_CFLAGS is set to the compiler flags and
#      Antlr_LIBRARIES to the runtime library.
#      If a PIC version of the runtime library (suitable to build shared
#      libraries on some Unices) is found, Antlr_PIC_LIBRARIES is set as well.
#
# ADD_ANTLR_GRAMMAR is to be used as follows:
#    ADD_ANTLR_GRAMMAR(mygrammar.g mygrammar_output_files)
#    ADD_EXECUTABLE(${mygrammar_output_files} other_source.c)

SET(Antlr_FOUND FALSE)
FIND_PROGRAM(Antlr_EXECUTABLE NAMES cantlr antlr runantlr cantlr.sh)
IF(NOT Antlr_EXECUTABLE)
    MESSAGE(STATUS "cannot find the antlr executable")
ENDIF(NOT Antlr_EXECUTABLE)

MACRO(ADD_ANTLR_GRAMMAR grammar_file output_var)
    IF (NOT Antlr_FOUND)
        MESSAGE(FATAL_ERROR "Antlr not available")
    ENDIF(NOT Antlr_FOUND)

    FILE(READ ${grammar_file} _antlr_grammar_data)

    STRING(REGEX MATCHALL "class +([^ ]+) +extends" _antlr_classes "${_antlr_grammar_data}")
    STRING(REGEX REPLACE  "class +([^ ]+) +extends" "\\1" _antlr_classes "${_antlr_classes}")

    LIST(LENGTH _antlr_classes _antlr_classes_count)
    MESSAGE(STATUS "Found ${_antlr_classes_count} Antlr classes: ${_antlr_classes}")
    STRING(REGEX REPLACE "([^;]+)" "${CMAKE_CURRENT_BINARY_DIR}/\\1.cpp;${CMAKE_CURRENT_BINARY_DIR}/\\1.hpp" _antlr_generated_files "${_antlr_classes}")

    # Trick: Antlr does not update the output files if they have
    # not been changed. This breaks builds with cmake/Makefile since
    # the source file keeps an update time > than the output files.
    # Fix it by using touch
    ADD_CUSTOM_COMMAND(OUTPUT ${_antlr_generated_files}
        COMMAND ${Antlr_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/${grammar_file}
        COMMAND touch ${_antlr_generated_files}
        DEPENDS ${grammar_file})
    SET(${output_var} "${_antlr_generated_files}")

    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
ENDMACRO(ADD_ANTLR_GRAMMAR)

IF(Antlr_EXECUTABLE)
    SET(Antlr_FOUND TRUE)

    FOREACH(lang ${Antlr_FIND_COMPONENTS})
        STRING(COMPARE EQUAL "CPP" ${lang} Antlr_SEARCH_CPP)
        IF(NOT Antlr_SEARCH_CPP)
            MESSAGE(FATAL_ERROR "unknown Antlr language package ${lang}")
        ENDIF(NOT Antlr_SEARCH_CPP)

        IF(Antlr_SEARCH_CPP)
            SET(Antlr_FOUND FALSE)
            SET(Antlr_CPP_FOUND FALSE)
            FIND_PROGRAM(Antlr_ANTLR_CONFIG_EXECUTABLE NAMES antlr-config)

            IF(Antlr_ANTLR_CONFIG_EXECUTABLE)
                SET(Antlr_FOUND TRUE)
                SET(Antlr_CPP_FOUND TRUE)

                EXECUTE_PROCESS(COMMAND ${Antlr_ANTLR_CONFIG_EXECUTABLE} --cflags
                    OUTPUT_VARIABLE Antlr_CFLAGS)
                STRING(REPLACE "\n" "" Antlr_CFLAGS ${Antlr_CFLAGS})

                EXECUTE_PROCESS(COMMAND ${Antlr_ANTLR_CONFIG_EXECUTABLE} --libs
                    OUTPUT_VARIABLE Antlr_LIBRARIES)
                STRING(REPLACE "\n" "" Antlr_LIBRARIES ${Antlr_LIBRARIES})
                STRING(REPLACE ".a" "-pic.a" Antlr_PIC_LIBRARIES "${Antlr_LIBRARIES}")

                MARK_AS_ADVANCED(Antlr_CFLAGS Antlr_LIBRARIES Antlr_PIC_LIBRARIES)
            ELSE(Antlr_ANTLR_CONFIG_EXECUTABLE)
                MESSAGE(STATUS "cannot find the antlr-config script. Antlr C++ support disabled")
            ENDIF(Antlr_ANTLR_CONFIG_EXECUTABLE)
        ENDIF(Antlr_SEARCH_CPP)
    ENDFOREACH(lang)
ENDIF(Antlr_EXECUTABLE)

IF (Antlr_FOUND)
    IF (NOT Antlr_FIND_QUIETLY)
        MESSAGE(STATUS "Found the Antlr executable: ${Antlr_EXECUTABLE}")
    ENDIF(NOT Antlr_FIND_QUIETLY)
ELSE (Antlr_FOUND)
    IF (Antlr_FIND_REQUIRED)
        MESSAGE(FATAL_ERROR "Please install the Antlr executable and/or the ${Antlr_FIND_COMPONENTS} language packages")
    ENDIF(Antlr_FIND_REQUIRED)
ENDIF(Antlr_FOUND)

