create_clock -name clk -period 10 -waveform {0 5} [get_ports "clk"]

set_clock_transition -rise 0.1 [get_clocks "clk"]

set_clock_transition -fall 0.1 [get_clocks "clk"]

set_clock_uncertainty 0.01 [get_ports "clk"]

set_input_delay -max 1.0 [get_ports "in1"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in2"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in3"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in4"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in5"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in6"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in7"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in8"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in9"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in10"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in11"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "in12"] -clock [get_clocks "clk"]


set_output_delay -max 1.0 [get_ports "sum"] -clock [get_clocks "clk"]

