rm -f ahir.vhdl
rm -f *_ieee_proposed.vhdl
rm -f GhdlLink.vhdl
rm -f ModelsimLink.vhdl
cat ../Vhpi/Utility_Package.vhdl >> GhdlLink.vhdl
cat ../Vhpi/Vhpi_Package.vhdl >> GhdlLink.vhdl
cat ../Vhpi/LogUtilitiesGhdl.vhdl >> GhdlLink.vhdl
cat ../Vhpi/Utility_Package.vhdl >> ModelsimLink.vhdl
cat ../Vhpi/Modelsim_FLI_Foreign.vhdl >> ModelsimLink.vhdl
cat ../Vhpi/LogUtilitiesModelsim.vhdl >> ModelsimLink.vhdl
cat ../ahir/packagesV2/GlobalConstants.vhd >> ahir.vhdl
cat ../ahir/packagesV2/Types.vhd >> ahir.vhdl
cat ../ahir/packagesV2/Utilities.vhd >> ahir.vhdl
cat ../ahir/packagesV2/Subprograms.vhd >> ahir.vhdl
cat ../ahir/packagesV2/BaseComponents.vhd >> ahir.vhdl
cat ../ahir/packagesV2/Components.vhd >> ahir.vhdl
cat ../ahir/packagesV2/FloatOperatorPackage.vhd >> ahir.vhdl
cat ../ahir/packagesV2/OperatorPackage.vhd >> ahir.vhdl
cat ../ahir/packagesV2/mem_component_pack.vhd >> ahir.vhdl
cat ../ahir/packagesV2/mem_function_pack.vhd >> ahir.vhdl
cat ../ahir/packagesV2/memory_subsystem_package.vhd >> ahir.vhdl
cat ../ahir/packagesV2/merge_functions.vhd >> ahir.vhdl
cat ../ahir/packagesV2/functionLibraryComponents.vhd >> ahir.vhdl
cat ../ahir/packagesV2/ApIntComponents.vhd >> ahir.vhdl
cat ../ahir/memory_subsystem/common/*.vhd >> ahir.vhdl
cat ../ahir/memory_subsystem/base_bank/*.vhd >> ahir.vhdl
cat ../ahir/memory_subsystem/strictly_ordered/*.vhd >> ahir.vhdl
cat ../ahir/memory_subsystem/unordered/*.vhd >> ahir.vhdl
cat ../ahir/control-path/*.vhdl >> ahir.vhdl
cat ../ahir/operatorsV2/base/*.vhd >> ahir.vhdl
cat ../ahir/operatorsV2/ieee754/*.vhd >> ahir.vhdl
cat ../ahir/operatorsV2/experimental/*.vhd >> ahir.vhdl
cat ../ahir/operatorsV2/glue/*.vhd >> ahir.vhdl
cat ../ahir/operatorsV2/functionLibrary/*.vhd >> ahir.vhdl
cat ../ahir/operatorsV2/ap_int/*.vhd >> ahir.vhdl
cat ../aHiR_ieee_proposed/trimmed/math_utility_pkg.vhd >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/fixed_float_types_c.vhdl >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/fixed_pkg_c.vhd >> aHiR_ieee_proposed.vhdl
cat ../aHiR_ieee_proposed/trimmed/float_pkg_c.vhd >> aHiR_ieee_proposed.vhdl
