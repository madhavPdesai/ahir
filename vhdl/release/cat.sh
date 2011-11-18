rm -f ahir.vhdl
rm -f ieee_proposed.vhdl
cat ../packagesV2/Types.vhd >> ahir.vhdl
cat ../packagesV2/Utilities.vhd >> ahir.vhdl
cat ../packagesV2/Subprograms.vhd >> ahir.vhdl
cat ../packagesV2/BaseComponents.vhd >> ahir.vhdl
cat ../packagesV2/Components.vhd >> ahir.vhdl
cat ../packagesV2/FloatOperatorPackage.vhd >> ahir.vhdl
cat ../packagesV2/OperatorPackage.vhd >> ahir.vhdl
cat ../packagesV2/mem_component_pack.vhd >> ahir.vhdl
cat ../packagesV2/mem_function_pack.vhd >> ahir.vhdl
cat ../packagesV2/memory_subsystem_package.vhd >> ahir.vhdl
cat ../packagesV2/merge_functions.vhd >> ahir.vhdl
cat ../memory_subsystem/common/*.vhd >> ahir.vhdl
cat ../memory_subsystem/strictly_ordered/*.vhd >> ahir.vhdl
cat ../memory_subsystem/unordered/*.vhd >> ahir.vhdl
cat ../control-path/*.vhdl >> ahir.vhdl
cat ../operatorsV2/base/*.vhd >> ahir.vhdl
cat ../ieee_proposed/trimmed/math_utility_pkg.vhd >> ieee_proposed.vhdl
cat ../ieee_proposed/trimmed/fixed_float_types_c.vhdl >> ieee_proposed.vhdl
cat ../ieee_proposed/trimmed/fixed_pkg_c.vhd >> ieee_proposed.vhdl
cat ../ieee_proposed/trimmed/float_pkg_c.vhd >> ieee_proposed.vhdl
