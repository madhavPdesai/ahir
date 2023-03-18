TECH=sac
LIBFILE=ahirForAsicFpga.$TECH.vhdl
rm -f $LIBFILE
cat ../ahir/packagesV2/GlobalConstants.vhd >> $LIBFILE
cat ../ahir/packagesV2/Types.vhd >> $LIBFILE
cat ../ahir/packagesV2/Utilities.vhd >> $LIBFILE
cat ../ahir/packagesV2/Subprograms.vhd >> $LIBFILE
cat ../ahir/packagesV2/BaseComponents.vhd >> $LIBFILE
cat ../ahir/packagesV2/Components.vhd >> $LIBFILE
cat ../ahir/packagesV2/FloatOperatorPackage.vhd >> $LIBFILE
cat ../ahir/packagesV2/OperatorPackage.vhd >> $LIBFILE
cat ../ahir/packagesV2/mem_component_pack.vhd >> $LIBFILE
cat ../ahir/packagesV2/mem_function_pack.vhd >> $LIBFILE
cat ../ahir/packagesV2/memory_subsystem_package.vhd >> $LIBFILE
cat ../ahir/packagesV2/merge_functions.vhd >> $LIBFILE
cat ../ahir/packagesV2/functionLibraryComponents.vhd >> $LIBFILE
cat ../ahir/packagesV2/ApIntComponents.vhd >> $LIBFILE
cat ../ahir/packagesV2/MemcutsPackage.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/base_bank_asic/$TECH/mem_ASIC_components.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/base_bank_asic/$TECH/MemcutDescriptionPack.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/base_bank_asic/$TECH/*_selector.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/common/*.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/base_bank_asic/*.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/base_bank_asic/for_fpga_impl_of_asic_rtl/$TECH/ReverseWrappers.vhdl >> $LIBFILE
cat ../ahir/memory_subsystem/strictly_ordered/*.vhd >> $LIBFILE
cat ../ahir/memory_subsystem/unordered/*.vhd >> $LIBFILE
cat ../ahir/control-path/*.vhdl >> $LIBFILE
cat ../ahir/operatorsV2/base/*.vhd >> $LIBFILE
cat ../ahir/operatorsV2/ieee754/*.vhd >> $LIBFILE
cat ../ahir/operatorsV2/experimental/*.vhd >> $LIBFILE
cat ../ahir/operatorsV2/glue/*.vhd* >> $LIBFILE
cat ../ahir/operatorsV2/level_core/*.vhd >> $LIBFILE
cat ../ahir/operatorsV2/functionLibrary/*.vhd >> $LIBFILE
cat ../ahir/operatorsV2/ap_int/*.vhd >> $LIBFILE
cat ../aHiR_ieee_proposed/trimmed/math_utility_pkg.vhd >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/fixed_float_types_c.vhdl >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/fixed_pkg_c.vhd >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/float_pkg_c.vhd >> aHiR_ieee_proposed.vhdl
#
# A hack to coexist with xilinx ip for clock gating.
#
cat ../ahir/clock_gating/*_clock_gate.vhdl >> ahir.vhdl
cat ../ahir/clock_gating/clock_gater_xilinx.vhdl >> ahirXilinx.vhdl
