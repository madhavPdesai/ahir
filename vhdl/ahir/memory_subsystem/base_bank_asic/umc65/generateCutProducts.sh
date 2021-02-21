../utils/generate_mem_cut_files cut_description_file.txt
cat ../fragments/ComponentPackPreFrag.txt > mem_ASIC_components.vhd
cat __component_decls.vhdl >> mem_ASIC_components.vhd
cat ../fragments/ComponentPackPostFrag.txt >> mem_ASIC_components.vhd
cat ../fragments/dpmem_selectorPreFrag.txt > dpmem_selector.vhd
cat __dp_arch_body.vhdl >> dpmem_selector.vhd
cat ../fragments/dpmem_selectorPostFrag.txt >> dpmem_selector.vhd
cat ../fragments/spmem_selectorPreFrag.txt > spmem_selector.vhd
cat __sp_arch_body.vhdl >> spmem_selector.vhd
cat ../fragments/spmem_selectorPostFrag.txt >> spmem_selector.vhd
cat ../fragments/register_file_1w_1r_selectorPreFrag.txt > register_file_1w_1r_selector.vhd
cat __rf_arch_body.vhdl >> register_file_1w_1r_selector.vhd
cat ../fragments/register_file_1w_1r_selectorPostFrag.txt >> register_file_1w_1r_selector.vhd
cat ../fragments/MemcutDescriptionPackPreFrag.txt > MemcutDescriptionPack.vhd
cat __cut_constants.vhdl >> MemcutDescriptionPack.vhd
cat ../fragments/MemcutDescriptionPackPostFrag.txt >> MemcutDescriptionPack.vhd
rm -f __*.vhdl
