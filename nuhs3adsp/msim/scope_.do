onerror {resume}
quietly virtual signal -install /testbench {/testbench/dq  } dq16
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/nuhs3adsp_e/mii_txen
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/mii_txd
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/clk_p
add wave -noupdate /testbench/cke
add wave -noupdate /testbench/cs_n
add wave -noupdate /testbench/ras_n
add wave -noupdate /testbench/cas_n
add wave -noupdate /testbench/we_n
add wave -noupdate /testbench/ba
add wave -noupdate -radix hexadecimal /testbench/addr
add wave -noupdate /testbench/nuhs3adsp_e/testpattern_e/rst
add wave -noupdate /testbench/nuhs3adsp_e/testpattern_e/clk
add wave -noupdate /testbench/nuhs3adsp_e/testpattern_e/req
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/testpattern_e/so
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/input_data
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/input_rdy
add wave -noupdate -expand /testbench/dqs
add wave -noupdate -radix hexadecimal -childformat {{/testbench/dq(15) -radix hexadecimal} {/testbench/dq(14) -radix hexadecimal} {/testbench/dq(13) -radix hexadecimal} {/testbench/dq(12) -radix hexadecimal} {/testbench/dq(11) -radix hexadecimal} {/testbench/dq(10) -radix hexadecimal} {/testbench/dq(9) -radix hexadecimal} {/testbench/dq(8) -radix hexadecimal} {/testbench/dq(7) -radix hexadecimal} {/testbench/dq(6) -radix hexadecimal} {/testbench/dq(5) -radix hexadecimal} {/testbench/dq(4) -radix hexadecimal} {/testbench/dq(3) -radix hexadecimal} {/testbench/dq(2) -radix hexadecimal} {/testbench/dq(1) -radix hexadecimal} {/testbench/dq(0) -radix hexadecimal}} -subitemconfig {/testbench/dq(15) {-height 16 -radix hexadecimal} /testbench/dq(14) {-height 16 -radix hexadecimal} /testbench/dq(13) {-height 16 -radix hexadecimal} /testbench/dq(12) {-height 16 -radix hexadecimal} /testbench/dq(11) {-height 16 -radix hexadecimal} /testbench/dq(10) {-height 16 -radix hexadecimal} /testbench/dq(9) {-height 16 -radix hexadecimal} /testbench/dq(8) {-height 16 -radix hexadecimal} /testbench/dq(7) {-height 16 -radix hexadecimal} /testbench/dq(6) {-height 16 -radix hexadecimal} /testbench/dq(5) {-height 16 -radix hexadecimal} /testbench/dq(4) {-height 16 -radix hexadecimal} /testbench/dq(3) {-height 16 -radix hexadecimal} /testbench/dq(2) {-height 16 -radix hexadecimal} /testbench/dq(1) {-height 16 -radix hexadecimal} /testbench/dq(0) {-height 16 -radix hexadecimal}} /testbench/dq
add wave -noupdate /testbench/dm
add wave -noupdate /testbench/nuhs3adsp_e/ddrphy_e/sys_sto
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/input_req
add wave -noupdate /testbench/nuhs3adsp_e/ddrphy_e/sys_sti(0)
add wave -noupdate /testbench/nuhs3adsp_e/ddrphy_e/sys_sto(0)
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_cmd_req
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddrs_cmd_req
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/ddrphy_e/sys_dqi
add wave -noupdate /testbench/mii_treq
add wave -noupdate /testbench/mii_strt
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/ddrphy_dqo
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_sto
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/ddrs_creq
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/ddrio_b/creq
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/ddrio_b/ddrs_breq
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/ddrs_rreq
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/dataio_e/sys_rst
add wave -noupdate -divider rdfifo
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_rdy
add wave -noupdate -radix hexadecimal -childformat {{/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(31) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(30) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(29) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(28) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(27) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(26) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(25) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(24) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(23) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(22) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(21) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(20) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(19) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(18) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(17) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(16) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(15) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(14) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(13) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(12) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(11) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(10) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(9) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(8) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(7) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(6) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(5) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(4) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(3) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(2) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(1) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(0) -radix hexadecimal}} -subitemconfig {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(31) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(30) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(29) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(28) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(27) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(26) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(25) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(24) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(23) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(22) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(21) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(20) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(19) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(18) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(17) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(16) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(15) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(14) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(13) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(12) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(11) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(10) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(9) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(8) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(7) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(6) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(5) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(4) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(3) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(2) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(1) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do(0) {-height 16 -radix hexadecimal}} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_do
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/xdr_dqsi
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/xdr_win_dqs
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_rea
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/sys_clk
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(0)/inbyte_i/apll_q
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(0)/inbyte_i/phases_g(0)/aser_q
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(0)/inbyte_i/phases_g(0)/ram_b/clk
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(0)/inbyte_i/phases_g(0)/ram_b/we
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(0)/inbyte_i/apll_q
add wave -noupdate -radix hexadecimal -childformat {{/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(0) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(1) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(2) -radix hexadecimal} {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(3) -radix hexadecimal}} -subitemconfig {/testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(0) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(1) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(2) {-height 16 -radix hexadecimal} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q(3) {-height 16 -radix hexadecimal}} /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/phases_g(0)/aser_q
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/rdfifo_i/bytes_g(1)/DATA_PHASES_g(1)/inbyte_i/ser_clk(0)
add wave -noupdate -divider wrfifo
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/sys_clk
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/sys_dqi
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/sys_req
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/ser_ena(0)
add wave -noupdate /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/ser_ena(1)
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/apll_q
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/phases_g(0)/aser_q
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/phases_g(1)/aser_q
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/ddrphy_e/byte_g(1)/ddrdqphy_i/ddr_dqo
add wave -noupdate -radix hexadecimal /testbench/nuhs3adsp_e/scope_e/ddr_e/wrfifo_i/xdr_dqo
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2602720 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {13068072 ps}
