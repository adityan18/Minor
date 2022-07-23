create_clock -name CLK -period 10 -waveform {0 5} [get_ports "CLK"]

set_clock_transition -rise 0.1 [get_clocks "CLK"]

set_clock_transition -fall 0.1 [get_clocks "CLK"]

set_clock_uncertainty 0.01 [get_clocks "CLK"]

set_input_delay -max 1.0 [get_ports "num_dp"] -clock [get_clocks "CLK"]
set_input_delay -max 1.0 [get_ports "feat"] -clock [get_clocks "CLK"]
set_input_delay -max 1.0 [get_ports "ser"] -clock [get_clocks "CLK"]
set_input_delay -max 1.0 [get_ports "RST"] -clock [get_clocks "CLK"]


set_output_delay -max 1.0 [get_ports "addr"] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports "done"] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports "data"] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports "flag"] -clock [get_clocks "CLK"]

