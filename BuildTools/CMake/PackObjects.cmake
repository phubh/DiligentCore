# PackObjects.cmake
# Helper script for combining object files into a static library on Windows/MinGW
# where ar does not support glob expansion.
#
# Required variables:
#   AR              - Path to the ar/gcc-ar tool
#   COMBINED_LIB_NAME - Output library name
#   OBJ_EXT        - Object file extension (e.g. .obj or .o)
#   WORK_DIR       - Working directory containing the object files

file(GLOB OBJ_FILES "${WORK_DIR}/*${OBJ_EXT}")

if(NOT OBJ_FILES)
    message(FATAL_ERROR "PackObjects: No ${OBJ_EXT} files found in ${WORK_DIR}")
endif()

execute_process(
    COMMAND ${AR} -crs ${COMBINED_LIB_NAME} ${OBJ_FILES}
    WORKING_DIRECTORY ${WORK_DIR}
    RESULT_VARIABLE AR_RESULT
)

if(NOT AR_RESULT EQUAL 0)
    message(FATAL_ERROR "PackObjects: ar failed with exit code ${AR_RESULT}")
endif()
