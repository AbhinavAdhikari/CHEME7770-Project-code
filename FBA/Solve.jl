include("Include.jl")
include("Bounds.jl")
include("TXTLDictionary.jl")
using DelimitedFiles
# load the data dictionary -
data_dictionary = DataDictionary(0,0,0)
TXTL_dictionary = TXTLDictionary(0,0,0)

#Set objective reaction
data_dictionary["objective_coefficient_array"][378] = -1;
data_dictionary["objective_coefficient_array"][379] = -1;
data_dictionary["objective_coefficient_array"][380] = -1;
data_dictionary["objective_coefficient_array"][381] = -1;
data_dictionary["objective_coefficient_array"][382] = -1;
data_dictionary["objective_coefficient_array"][383] = -1;
data_dictionary["objective_coefficient_array"][384] = -1;
data_dictionary["objective_coefficient_array"][385] = -1;



#=============================Cases=========================================#
#Define case number
# 1 = Amino Acid Uptake & Synthesis
# 2 = Amino Acid Uptake w/o Synthesis
# 3 = Amino Acid Synthesis w/o Uptake


#Set Promoter
#1 = T7 Promoter model
#2 = P70a Promoter model
Promoter_model = 2
#===========================================================================#

#Set Plasmid Dose (nM)
plasmid_concentration = 5;
volume = TXTL_dictionary["volume"]
gene_copy_number = (volume/1e9)*(6.02e23)*plasmid_concentration;
TXTL_dictionary["gene_copies"] = gene_copy_number

#Set Glucose and Oxygen (mM/h)
data_dictionary["GlcUptake"] = 30
data_dictionary["Oxygen"] = 100;

# solve the lp problem -
data_dictionary = Bounds(data_dictionary,TXTL_dictionary);
(objective_value, flux_array, dual_array, uptake_array, exit_flag) = FluxDriver(data_dictionary)
