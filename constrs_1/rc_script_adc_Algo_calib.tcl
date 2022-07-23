set_attr init_lib_search_path /home/Chinmaye/counter_design_database_45nm/scl_pdk/stdlib/fs120/liberty/lib_flow_ss

set_attr init_hdl_search_path /home/Chinmaye/counter_design_database_45nm/scl_pdk/stdlib/fs120/verilog

set_attr library tsl18fs120_scl_ss.lib

read_hdl Algo_calib.v


elaborate

read_sdc /home/Chinmaye/counter_design_database_45nm/constraints/constraints_Algo_calib.sdc

set_attribute syn_generic_effort medium
set_attribute syn_map_effort medium
set_attribute syn_opt_effort medium
syn_generic
syn_map




write_hdl > Algo_calib_netlist.v

write_sdc > Algo_calib_sdc.sdc
