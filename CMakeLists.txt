cmake_minimum_required(VERSION 2.8)
project(ahir)

# Build AHIR from this directory.
add_subdirectory(v2)

#####################################################################
# Create vhdl libraries. 
######################################################################
include(GNUInstallDirs)

# VHDL files created by concatnating multiple vhdl files. This variable stores
# there path. Later we will install them.
set(VHDL_TO_INSTALL "")

# Where VHDL libraries are stored.
set(VHDL_LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/vhdl)

# Function to concatnate multiple VHDL files to one file.
function(CAT_FILES _outfile _files)
    list(LENGTH _files _num_files)
    file(REMOVE ${_outfile})
    message(STATUS "Concatnating ${_num_files} files to ${_outfile}")
    foreach(_file ${_files})
        file(READ ${_file} CONTENTS)
        file(APPEND ${_outfile} "${CONTENTS}")
    endforeach()
    set(VHDL_TO_INSTALL ${VHDL_TO_INSTALL} ${_outfile} PARENT_SCOPE)
endfunction()

file(GLOB GHDL_FILES 
    ${VHDL_LIB_DIR}/Vhpi/Utility_Package.vhdl 
    ${VHDL_LIB_DIR}/Vhpi/Vhpi_Package.vhdl 
    ${VHDL_LIB_DIR}/Vhpi/LogUtilitiesGhdl.vhdl 
    )
CAT_FILES("GhdlLink.vhdl" "${GHDL_FILES}")


file(GLOB MODELSIM_FILES 
    ${VHDL_LIB_DIR}/Vhpi/Utility_Package.vhdl 
    ${VHDL_LIB_DIR}/Vhpi/Modelsim_FLI_Foreign.vhdl 
    ${VHDL_LIB_DIR}/Vhpi/LogUtilitiesModelsim.vhdl
    )
CAT_FILES("ModelsimLink.vhdl" "${MODELSIM_FILES}")

file(GLOB AHIR_FILES
    ${VHDL_LIB_DIR}/ahir/packagesV2/GlobalConstants.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Types.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Utilities.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Subprograms.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/BaseComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Components.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/FloatOperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/OperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_component_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_function_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/memory_subsystem_package.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/merge_functions.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/functionLibraryComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/ApIntComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/common/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/base_bank/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/strictly_ordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/unordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/control-path/*.vhdl 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/base/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ieee754/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/experimental/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/glue/*.vhd* 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/level_core/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/functionLibrary/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ap_int/*.vhd 
    )
CAT_FILES("ahir.vhdl" "${AHIR_FILES}")

file(GLOB AHIR_IEEE_PROPOSED_FILES 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/math_utility_pkg.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_float_types_c.vhdl 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_pkg_c.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/float_pkg_c.vhd 
    # These are for ASIC.
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/math_utility_pkg.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_float_types_c.vhdl 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_pkg_c.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/float_pkg_c.vhd 
    # For FPGA
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/math_utility_pkg.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_float_types_c.vhdl 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/fixed_pkg_c.vhd 
    ${VHDL_LIB_DIR}/aHiR_ieee_proposed/trimmed/float_pkg_c.vhd 
    )
CAT_FILES("aHiR_ieee_proposed.vhdl" "${AHIR_IEEE_PROPOSED_FILES}")

# cat_for_asic.
file(GLOB AHIR_FOR_ASIC 
    ${VHDL_LIB_DIR}/ahir/packagesV2/GlobalConstants.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Types.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Utilities.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Subprograms.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/BaseComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Components.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/FloatOperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/OperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_component_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_function_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/memory_subsystem_package.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/merge_functions.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/functionLibraryComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/ApIntComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_ASIC_components.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/MemcutsPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/common/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/base_bank_asic/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/strictly_ordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/unordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/control-path/*.vhdl 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/base/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ieee754/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/experimental/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/glue/*.vhd* 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/level_core/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/functionLibrary/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ap_int/*.vhd 
    )
CAT_FILES("ahirForAsic.vhdl" "${AHIR_FOR_ASIC}")

file(GLOB AHIR_FOR_ASIC_FPGA
    ${VHDL_LIB_DIR}/ahir/packagesV2/GlobalConstants.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Types.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Utilities.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Subprograms.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/BaseComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/Components.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/FloatOperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/OperatorPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_component_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_function_pack.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/memory_subsystem_package.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/merge_functions.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/functionLibraryComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/ApIntComponents.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/mem_ASIC_components.vhd 
    ${VHDL_LIB_DIR}/ahir/packagesV2/MemcutsPackage.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/common/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/base_bank_asic/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/base_bank_asic/for_fpga_impl_of_asic_rtl/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/strictly_ordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/memory_subsystem/unordered/*.vhd 
    ${VHDL_LIB_DIR}/ahir/control-path/*.vhdl 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/base/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ieee754/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/experimental/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/glue/*.vhd* 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/level_core/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/functionLibrary/*.vhd 
    ${VHDL_LIB_DIR}/ahir/operatorsV2/ap_int/*.vhd 
    )
CAT_FILES("ahirForAsicFpga.vhdl" "${AHIR_FOR_ASIC_FPGA}")

#######################################################################
# Install. We are using GNUInstallDirs macros.
#######################################################################
include(GNUInstallDirs)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
    ${CMAKE_CURRENT_SOURCE_DIR}/CONTRIBUTORS
    DESTINATION ${CMAKE_INSTALL_DOCDIR}
    )

install(FILES ${VHDL_TO_INSTALL} 
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/ahir/vhdl/
    )
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/vhdl/unisims/ 
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/ahir/vhdl/
    )


enable_testing()
