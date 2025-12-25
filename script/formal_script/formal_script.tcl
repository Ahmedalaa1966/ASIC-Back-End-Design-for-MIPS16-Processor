
set design mips_16


# Variables

set SSLIB "/home/IC/ref_flow/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM/NangateOpenCellLibrary_ss0p95v125c.db"
set TTLIB "/home/IC/ref_flow/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM/NangateOpenCellLibrary_tt1p1v25c.db"
set FFLIB "/home/IC/ref_flow/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM/NangateOpenCellLibrary_ff1p25vn40c.db"


# Synopsys setup variable
set synopsys_auto_setup true

# Formality Setup File
set_svf "/home/IC/ref_flow/syn/output/${design}.svf"


##################### Reference Container #####################


# Read Reference Design Verilog Files
read_verilog -container Ref "/home/IC/ref_flow/rtl/${design}.v"

# Read Reference technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

# set the top Reference Design 
set_reference_design mips_16
set_top mips_16



#################### Implementation Container #####################


# Read Implementation Design Files
read_verilog -container Imp -netlist "/home/IC/ref_flow/syn/output/${design}.v "

# Read Implementation technology libraries
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

# set the top Implementation Design
set_implementation_design mips_16
set_top mips_16

###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui
