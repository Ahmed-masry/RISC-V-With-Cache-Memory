vlib work
vlog -sv TOP.sv TOP_Tb.sv AdderPCPlus4.sv AdderPCPlus4ImmExt.sv Mux2to1_PC.sv PC.sv instrMemory.sv ControlUnit.sv RegisterFile.sv Mux2to1_RG_f.sv ALU.sv DataMemory.sv Mux3to1.sv AND.sv Data_memory_system_module.v Data_memory_cache.v cache_memory.v Cache_controler.v
vlog TOP_Tb.sv
vsim -voptargs=+acc work.TOP_Tb

add wave -position insertpoint  \
sim:/TOP_Tb/dut/clk \
sim:/TOP_Tb/dut/reset
add wave -position insertpoint  \
sim:/TOP_Tb/dut/instr_mem/instr
add wave -position insertpoint  \
sim:/TOP_Tb/dut/control_unit/op \
sim:/TOP_Tb/dut/control_unit/funct3 \
sim:/TOP_Tb/dut/control_unit/funct7 \
sim:/TOP_Tb/dut/control_unit/Zero \
sim:/TOP_Tb/dut/control_unit/RegWrite \
sim:/TOP_Tb/dut/control_unit/ImmSrc \
sim:/TOP_Tb/dut/control_unit/ALUSrc \
sim:/TOP_Tb/dut/control_unit/MemWrite \
sim:/TOP_Tb/dut/control_unit/mem_read \
sim:/TOP_Tb/dut/control_unit/ResultSrc \
sim:/TOP_Tb/dut/control_unit/PCSrc \
sim:/TOP_Tb/dut/control_unit/ALUControl \
sim:/TOP_Tb/dut/control_unit/Branch \
sim:/TOP_Tb/dut/control_unit/jump \
sim:/TOP_Tb/dut/control_unit/ALUOp \
sim:/TOP_Tb/dut/control_unit/funct7_5 \
sim:/TOP_Tb/dut/control_unit/op_5
add wave -position insertpoint  \
sim:/TOP_Tb/dut/reg_file/Result \
sim:/TOP_Tb/dut/reg_file/reg_write \
sim:/TOP_Tb/dut/reg_file/read_data1 \
sim:/TOP_Tb/dut/reg_file/read_data2 \
sim:/TOP_Tb/dut/reg_file/regfile
add wave -position insertpoint  \
sim:/TOP_Tb/dut/alu/secA \
sim:/TOP_Tb/dut/alu/secB \
sim:/TOP_Tb/dut/alu/ALUResult \
sim:/TOP_Tb/dut/alu/zero
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/mem_read \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/mem_write \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/hit_miss \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/done \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/wr_en_dm \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/wr_en_cm \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/rd_en_dm \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/mem_to_cache_en \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/rd_en_cm \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/stall \
sim:/TOP_Tb/dut/data_mem/cache_ctrl/current_state
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/data_mem_cache/data_out \
sim:/TOP_Tb/dut/data_mem/data_mem_cache/done \
sim:/TOP_Tb/dut/data_mem/data_mem_cache/memory
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/data_mem_cache/wanted_address
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/cache_mem/hit_miss \
sim:/TOP_Tb/dut/data_mem/cache_mem/data_out \
sim:/TOP_Tb/dut/data_mem/cache_mem/cache_mem \
sim:/TOP_Tb/dut/data_mem/cache_mem/tag \
sim:/TOP_Tb/dut/data_mem/cache_mem/valid \
sim:/TOP_Tb/dut/data_mem/cache_mem/i
add wave -position insertpoint  \
sim:/TOP_Tb/dut/result_mux/Result
add wave -position insertpoint  \
sim:/TOP_Tb/dut/data_mem/data_mem_cache/counter
run -all