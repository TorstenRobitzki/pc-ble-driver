function(nrf_apply_patches)
    cmake_parse_arguments(nrf_apply_patches "QUIET" "SOURCE_PATH" "PATCHES" ${ARGN})

    find_program(GIT NAMES git git.cmd)
    set(PATCHNUM 0)

    foreach(PATCH ${nrf_apply_patches_PATCHES})
        message(STATUS "Applying patch ${PATCH}")

        execute_process(
            COMMAND "${GIT}" apply "${PATCH}" --ignore-whitespace
            WORKING_DIRECTORY ${nrf_apply_patches_SOURCE_PATH}
            RESULT_VARIABLE error_code
            ERROR_VARIABLE error
            OUTPUT_VARIABLE output
        )

        if(error_code)
            message(WARNING "Applying patch failed with error \"${error_code}\". This is expected if this patch was previously applied.")
            string(STRIP "${error}" error)
            message(STATUS "git error: ${error}")
        endif()

        math(EXPR PATCHNUM "${PATCHNUM}+1")
    endforeach()
endfunction()
