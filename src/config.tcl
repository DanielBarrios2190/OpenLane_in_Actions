set ::env(DESIGN_NAME) src

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/RV_SC_Top.v \
	$::env(DESIGN_DIR)/ALU.v \
	$::env(DESIGN_DIR)/ControlUnit.v \
	$::env(DESIGN_DIR)/DataMem.v \
	$::env(DESIGN_DIR)/Extend.v \ 
	$::env(DESIGN_DIR)/IODriver.v \
	$::env(DESIGN_DIR)/Register_File.v \
	$::env(DESIGN_DIR)/RV_SC_Top.v"
 
set ::env(DESIGN_IS_CORE) 0

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) "clk"
set ::env(CLOCK_PERIOD) "30.0"

set ::env(PL_TARGET_DENSITY) 0.75
set ::env(FP_CORE_UTIL) 85
