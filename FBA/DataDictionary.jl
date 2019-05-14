# ----------------------------------------------------------------------------------- #
# Copyright (c) 2019 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
#
# ----------------------------------------------------------------------------------- #
# Function: DataDictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2019-05-14T11:26:08.818
#
# Input arguments:
# time_start::Float64 => Simulation start time value (scalar) 
# time_stop::Float64 => Simulation stop time value (scalar) 
# time_step::Float64 => Simulation time step (scalar) 
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs 
# ----------------------------------------------------------------------------------- #
function DataDictionary(time_start,time_stop,time_step)

	# Load the stoichiometric network from disk - 
	stoichiometric_matrix = readdlm("Network.dat");

	# Setup default flux bounds array - 
	default_bounds_array = [
		0	100.0	;	# 1 M_atp_c+M_glc_D_c --> M_adp_c+M_g6p_c
		0	100.0	;	# 2 M_g6p_c --> M_f6p_c
		0	100.0	;	# 3 M_f6p_c --> M_g6p_c
		0	100.0	;	# 4 M_atp_c+M_f6p_c --> M_adp_c+M_fdp_c
		0	100.0	;	# 5 M_fdp_c+M_h2o_c --> M_f6p_c+M_pi_c
		0	100.0	;	# 6 M_fdp_c --> M_dhap_c+M_g3p_c
		0	100.0	;	# 7 M_dhap_c+M_g3p_c --> M_fdp_c
		0	100.0	;	# 8 M_dhap_c --> M_g3p_c
		0	100.0	;	# 9 M_g3p_c --> M_dhap_c
		0	100.0	;	# 10 M_g3p_c+M_nad_c+M_pi_c --> M_13dpg_c+M_h_c+M_nadh_c
		0	100.0	;	# 11 M_13dpg_c+M_h_c+M_nadh_c --> M_g3p_c+M_nad_c+M_pi_c
		0	100.0	;	# 12 M_13dpg_c+M_adp_c --> M_3pg_c+M_atp_c
		0	100.0	;	# 13 M_3pg_c+M_atp_c --> M_13dpg_c+M_adp_c
		0	100.0	;	# 14 M_3pg_c --> M_2pg_c
		0	100.0	;	# 15 M_2pg_c --> M_3pg_c
		0	100.0	;	# 16 M_2pg_c --> M_h2o_c+M_pep_c
		0	100.0	;	# 17 M_h2o_c+M_pep_c --> M_2pg_c
		0	100.0	;	# 18 M_adp_c+M_pep_c --> M_atp_c+M_pyr_c
		0	100.0	;	# 19 M_atp_c+M_oaa_c --> M_adp_c+M_co2_c+M_pep_c
		0	100.0	;	# 20 M_co2_c+M_h2o_c+M_pep_c --> M_oaa_c+M_pi_c
		0	100.0	;	# 21 M_coa_c+M_nad_c+M_pyr_c --> M_accoa_c+M_co2_c+M_nadh_c+M_h_c
		0	100.0	;	# 22 M_atp_c+M_h2o_c+M_pyr_c --> M_amp_c+M_pep_c+M_pi_c
		0	100.0	;	# 23 M_g6p_c+M_nadp_c --> M_6pgl_c+M_h_c+M_nadph_c
		0	100.0	;	# 24 M_6pgl_c+M_h_c+M_nadph_c --> M_g6p_c+M_nadp_c
		0	100.0	;	# 25 M_6pgl_c+M_h2o_c --> M_6pgc_c
		0	100.0	;	# 26 M_6pgc_c+M_nadp_c --> M_co2_c+M_nadph_c+M_ru5p_D_c+M_h_c
		0	100.0	;	# 27 M_ru5p_D_c --> M_xu5p_D_c
		0	100.0	;	# 28 M_xu5p_D_c --> M_ru5p_D_c
		0	100.0	;	# 29 M_r5p_c --> M_ru5p_D_c
		0	100.0	;	# 30 M_ru5p_D_c --> M_r5p_c
		0	100.0	;	# 31 M_g3p_c+M_s7p_c --> M_e4p_c+M_f6p_c
		0	100.0	;	# 32 M_e4p_c+M_f6p_c --> M_g3p_c+M_s7p_c
		0	100.0	;	# 33 M_r5p_c+M_xu5p_D_c --> M_g3p_c+M_s7p_c
		0	100.0	;	# 34 M_g3p_c+M_s7p_c --> M_r5p_c+M_xu5p_D_c
		0	100.0	;	# 35 M_e4p_c+M_xu5p_D_c --> M_f6p_c+M_g3p_c
		0	100.0	;	# 36 M_f6p_c+M_g3p_c --> M_e4p_c+M_xu5p_D_c
		0	100.0	;	# 37 M_6pgc_c --> M_2ddg6p_c+M_h2o_c
		0	100.0	;	# 38 M_2ddg6p_c --> M_g3p_c+M_pyr_c
		0	100.0	;	# 39 M_accoa_c+M_h2o_c+M_oaa_c --> M_cit_c+M_coa_c
		0	100.0	;	# 40 M_cit_c --> M_icit_c
		0	100.0	;	# 41 M_icit_c --> M_cit_c
		0	100.0	;	# 42 M_icit_c+M_nadp_c --> M_akg_c+M_co2_c+M_nadph_c+M_h_c
		0	100.0	;	# 43 M_akg_c+M_co2_c+M_nadph_c+M_h_c --> M_icit_c+M_nadp_c
		0	100.0	;	# 44 M_akg_c+M_coa_c+M_nad_c --> M_co2_c+M_nadh_c+M_succoa_c+M_h_c
		0	100.0	;	# 45 M_adp_c+M_pi_c+M_succoa_c --> M_atp_c+M_coa_c+M_succ_c
		0	100.0	;	# 46 M_q8_c+M_succ_c --> M_fum_c+M_q8h2_c
		0	100.0	;	# 47 M_fum_c+M_mql8_c --> M_mqn8_c+M_succ_c
		0	100.0	;	# 48 M_fum_c+M_h2o_c --> M_mal_L_c
		0	100.0	;	# 49 M_mal_L_c --> M_fum_c+M_h2o_c
		0	100.0	;	# 50 M_mal_L_c+M_nad_c --> M_oaa_c+M_h_c+M_nadh_c
		0	100.0	;	# 51 M_oaa_c+M_h_c+M_nadh_c --> M_mal_L_c+M_nad_c
		0	100.0	;	# 52 2.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+2.0*M_he_c
		0	100.0	;	# 53 4.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+4.0*M_he_c
		0	100.0	;	# 54 2.0*M_h_c+M_mql8_c+0.5*M_o2_c --> M_h2o_c+M_mqn8_c+2.0*M_he_c
		0	100.0	;	# 55 M_adp_c+M_pi_c+4.0*M_he_c --> M_atp_c+4.0*M_h_c+M_h2o_c
		0	100.0	;	# 56 3.0*M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c+2.0*M_he_c
		0	100.0	;	# 57 M_nad_c+M_nadph_c --> M_nadh_c+M_nadp_c
		0	100.0	;	# 58 M_nadh_c+M_nadp_c+2.0*M_he_c --> 2.0*M_h_c+M_nad_c+M_nadph_c
		0	100.0	;	# 59 M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c
		0	100.0	;	# 60 M_h_c+M_mqn8_c+M_nadh_c --> M_mql8_c+M_nad_c
		0	100.0	;	# 61 M_ppi_c+M_h2o_c --> 2.0*M_pi_c
		0	100.0	;	# 62 M_icit_c --> M_glx_c+M_succ_c
		0	100.0	;	# 63 M_accoa_c+M_glx_c+M_h2o_c --> M_coa_c+M_mal_L_c
		0	100.0	;	# 64 M_mal_L_c+M_nad_c --> M_co2_c+M_nadh_c+M_pyr_c+M_h_c
		0	100.0	;	# 65 M_mal_L_c+M_nadp_c --> M_co2_c+M_nadph_c+M_pyr_c+M_h_c
		0	100.0	;	# 66 M_accoa_c+M_pi_c --> M_actp_c+M_coa_c
		0	100.0	;	# 67 M_actp_c+M_coa_c --> M_accoa_c+M_pi_c
		0	100.0	;	# 68 M_actp_c+M_adp_c --> M_ac_c+M_atp_c
		0	100.0	;	# 69 M_ac_c+M_atp_c --> M_actp_c+M_adp_c
		0	100.0	;	# 70 M_ac_c+M_atp_c+M_coa_c --> M_accoa_c+M_amp_c+M_ppi_c
		0	100.0	;	# 71 M_accoa_c+2.0*M_h_c+2.0*M_nadh_c --> M_coa_c+M_etoh_c+2.0*M_nad_c
		0	100.0	;	# 72 M_coa_c+M_etoh_c+2.0*M_nad_c --> M_accoa_c+2.0*M_h_c+2.0*M_nadh_c
		0	100.0	;	# 73 M_pyr_c+M_nadh_c+M_h_c --> M_lac_D_c+M_nad_c
		0	100.0	;	# 74 M_lac_D_c+M_nad_c --> M_pyr_c+M_nadh_c+M_h_c
		0	100.0	;	# 75 M_coa_c+M_pyr_c --> M_accoa_c+M_for_c
		0	100.0	;	# 76 M_pyr_c+M_glu_L_c --> M_ala_L_c+M_akg_c
		0	100.0	;	# 77 M_ala_L_c+M_akg_c --> M_pyr_c+M_glu_L_c
		0	100.0	;	# 78 M_accoa_c+2.0*M_glu_L_c+3.0*M_atp_c+M_nadph_c+M_h_c+M_h2o_c+M_nh3_c+M_co2_c+M_asp_L_c --> M_coa_c+2.0*M_adp_c+2.0*M_pi_c+M_nadp_c+M_akg_c+M_ac_c+M_amp_c+M_ppi_c+M_fum_c+M_arg_L_c
		0	100.0	;	# 79 M_glu_L_c+M_oaa_c --> M_asp_L_c+M_akg_c
		0	100.0	;	# 80 M_asp_L_c+M_gln_L_c+M_h2o_c+M_atp_c --> M_asn_L_c+M_glu_L_c+M_ppi_c+M_amp_c
		0	100.0	;	# 81 M_asp_L_c+M_atp_c+M_nh3_c --> M_asn_L_c+M_ppi_c+M_amp_c
		0	100.0	;	# 82 M_ser_L_c+M_accoa_c+M_h2s_c --> M_cys_L_c+M_coa_c+M_ac_c
		0	100.0	;	# 83 M_gln_L_c+M_akg_c+M_nadph_c+M_h_c --> 2.0*M_glu_L_c+M_nadp_c
		0	100.0	;	# 84 M_akg_c+M_nadph_c+M_nh3_c+M_h_c --> M_glu_L_c+M_h2o_c+M_nadp_c
		0	100.0	;	# 85 M_glu_L_c+M_h2o_c+M_nadp_c --> M_akg_c+M_nadph_c+M_nh3_c+M_h_c
		0	100.0	;	# 86 M_glu_L_c+M_atp_c+M_nh3_c --> M_gln_L_c+M_adp_c+M_pi_c
		0	100.0	;	# 87 M_ser_L_c+M_thf_c --> M_gly_L_c+M_h2o_c+M_mlthf_c
		0	100.0	;	# 88 M_gln_L_c+M_r5p_c+2.0*M_atp_c+2.0*M_nad_c+3.0*M_h2o_c --> M_his_L_c+M_akg_c+M_aicar_c+2.0*M_nadh_c+M_amp_c+M_pi_c+2.0*M_ppi_c+2.0*M_h_c
		0	100.0	;	# 89 M_thr_L_c+M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c --> M_ile_L_c+M_h2o_c+M_nh3_c+M_co2_c+M_nadp_c+M_akg_c
		0	100.0	;	# 90 2.0*M_pyr_c+M_glu_L_c+M_nad_c+M_nadph_c+M_accoa_c --> M_leu_L_c+2.0*M_co2_c+M_nadp_c+M_coa_c+M_nadh_c+M_akg_c
		0	100.0	;	# 91 M_asp_L_c+M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_pyr_c+M_succoa_c+M_glu_L_c --> M_lys_L_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_coa_c+M_akg_c+M_succ_c+M_co2_c
		0	100.0	;	# 92 M_asp_L_c+M_cys_L_c+M_succoa_c+M_atp_c+2.0*M_nadph_c+M_5mthf_c+M_h2o_c+2.0*M_h_c --> M_met_L_c+M_coa_c+M_succ_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_thf_c+M_nh3_c+M_pyr_c
		0	100.0	;	# 93 M_chor_c+M_glu_L_c --> M_phe_L_c+M_co2_c+M_h2o_c+M_akg_c
		0	100.0	;	# 94 M_glu_L_c+M_atp_c+2.0*M_h_c+2.0*M_nadph_c --> M_pro_L_c+M_adp_c+2.0*M_nadp_c+M_pi_c+M_h2o_c
		0	100.0	;	# 95 M_3pg_c+M_nad_c+M_glu_L_c+M_h2o_c --> M_ser_L_c+M_nadh_c+M_h_c+M_akg_c+M_pi_c
		0	100.0	;	# 96 M_asp_L_c+2.0*M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_h2o_c --> M_thr_L_c+2.0*M_adp_c+2.0*M_pi_c+2.0*M_nadp_c
		0	100.0	;	# 97 M_chor_c+M_gln_L_c+M_ser_L_c+M_r5p_c+M_atp_c --> M_trp_L_c+M_glu_L_c+M_pyr_c+M_ppi_c+2.0*M_h2o_c+M_co2_c+M_g3p_c+M_amp_c
		0	100.0	;	# 98 M_chor_c+M_glu_L_c+M_nad_c --> M_tyr_L_c+M_akg_c+M_nadh_c+M_co2_c+M_h_c
		0	100.0	;	# 99 2.0*M_pyr_c+M_h_c+M_nadph_c+M_glu_L_c --> M_val_L_c+M_co2_c+M_nadp_c+M_h2o_c+M_akg_c
		0	100.0	;	# 100 M_arg_L_c+4.0*M_h2o_c+M_nad_c+M_akg_c+M_succoa_c --> M_h_c+M_co2_c+2.0*M_glu_L_c+2.0*M_nh3_c+M_nadh_c+M_succ_c+M_coa_c
		0	100.0	;	# 101 M_asp_L_c --> M_fum_c+M_nh3_c
		0	100.0	;	# 102 M_asn_L_c+M_amp_c+M_ppi_c --> M_nh3_c+M_asp_L_c+M_atp_c
		0	100.0	;	# 103 M_gly_L_c+M_accoa_c+M_o2_c+M_h2o_c --> M_coa_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c
		0	100.0	;	# 104 M_mglx_c+M_nad_c+M_h2o_c --> M_pyr_c+M_nadh_c+M_h_c
		0	100.0	;	# 105 M_ser_L_c --> M_nh3_c+M_pyr_c
		0	100.0	;	# 106 M_pro_L_c+M_q8_c+2.0*M_h2o_c+M_nad_c --> M_h_c+M_q8h2_c+M_nadh_c+M_glu_L_c
		0	100.0	;	# 107 M_thr_L_c+M_nad_c+M_coa_c --> M_nadh_c+M_h_c+M_accoa_c+M_gly_L_c
		0	100.0	;	# 108 M_thr_L_c+M_nad_c+M_o2_c+M_h2o_c --> M_nadh_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c+M_h_c
		0	100.0	;	# 109 M_thr_L_c+M_pi_c+M_adp_c --> M_nh3_c+M_for_c+M_atp_c+M_prop_c
		0	100.0	;	# 110 M_trp_L_c+M_h2o_c --> M_indole_c+M_nh3_c+M_pyr_c
		0	100.0	;	# 111 M_cys_L_c+M_h2o_c --> M_h2s_c+M_nh3_c+M_pyr_c
		0	100.0	;	# 112 M_lys_L_c --> M_co2_c+M_cadav_c
		0	100.0	;	# 113 M_gln_L_c+M_h2o_c --> M_nh3_c+M_glu_L_c
		0	100.0	;	# 114 M_glu_L_c --> M_co2_c+M_gaba_c
		0	100.0	;	# 115 M_gaba_c+M_akg_c+M_h2o_c+M_nad_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadh_c
		0	100.0	;	# 116 M_gaba_c+M_akg_c+M_h2o_c+M_nadp_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadph_c
		0	100.0	;	# 117 M_e4p_c+2.0*M_pep_c+M_nadph_c+M_atp_c+M_h_c --> M_chor_c+M_nadp_c+M_adp_c+4.0*M_pi_c
		0	100.0	;	# 118 M_gtp_c+4.0*M_h2o_c --> M_for_c+3.0*M_pi_c+M_glycoA_c+M_78mdp_c
		0	100.0	;	# 119 M_chor_c+M_gln_L_c --> M_4adochor_c+M_glu_L_c
		0	100.0	;	# 120 M_4adochor_c --> M_4abz_c+M_pyr_c
		0	100.0	;	# 121 M_4abz_c+M_78mdp_c --> M_78dhf_c+M_h2o_c
		0	100.0	;	# 122 M_78dhf_c+M_atp_c+M_glu_L_c --> M_adp_c+M_pi_c+M_dhf_c
		0	100.0	;	# 123 M_dhf_c+M_nadph_c+M_h_c --> M_thf_c+M_nadp_c
		0	100.0	;	# 124 M_gly_L_c+M_thf_c+M_nad_c --> M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c
		0	100.0	;	# 125 M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c --> M_gly_L_c+M_thf_c+M_nad_c
		0	100.0	;	# 126 M_mlthf_c+M_nadp_c --> M_methf_c+M_nadph_c
		0	100.0	;	# 127 M_methf_c+M_nadph_c --> M_mlthf_c+M_nadp_c
		0	100.0	;	# 128 M_h2o_c+M_methf_c --> M_10fthf_c+M_h_c
		0	100.0	;	# 129 M_10fthf_c+M_h_c --> M_h2o_c+M_methf_c
		0	100.0	;	# 130 M_mlthf_c+M_h_c+M_nadh_c --> M_5mthf_c+M_nad_c
		0	100.0	;	# 131 M_mlthf_c+M_h_c+M_nadph_c --> M_5mthf_c+M_nadp_c
		0	100.0	;	# 132 M_r5p_c+M_atp_c --> M_prpp_c+M_amp_c
		0	100.0	;	# 133 2.0*M_atp_c+M_gln_L_c+M_hco3_c+M_h2o_c+M_h_c --> 2.0*M_adp_c+M_glu_L_c+M_pi_c+M_clasp_c
		0	100.0	;	# 134 M_clasp_c+M_asp_L_c+M_q8_c --> M_or_c+M_q8h2_c+M_h2o_c+M_pi_c
		0	100.0	;	# 135 M_prpp_c+M_or_c --> M_omp_c+M_ppi_c
		0	100.0	;	# 136 M_omp_c --> M_ump_c+M_co2_c
		0	100.0	;	# 137 M_utp_c+M_atp_c+M_nh3_c --> M_ctp_c+M_adp_c+M_pi_c
		0	100.0	;	# 138 M_utp_c+M_gln_L_c+M_atp_c+M_h2o_c --> M_ctp_c+M_glu_L_c+M_adp_c+M_pi_c
		0	100.0	;	# 139 M_gln_L_c+M_prpp_c+M_h2o_c --> M_5pbdra+M_ppi_c+M_glu_L_c
		0	100.0	;	# 140 M_atp_c+M_5pbdra+M_gly_L_c --> M_adp_c+M_pi_c+M_gar_c
		0	100.0	;	# 141 M_10fthf_c+M_gar_c --> M_thf_c+M_fgar_c
		0	100.0	;	# 142 M_atp_c+M_fgar_c+M_gln_L_c+M_h2o_c --> M_adp_c+M_pi_c+M_fgam_c+M_glu_L_c
		0	100.0	;	# 143 M_atp_c+M_fgam_c --> M_adp_c+M_pi_c+M_air_c
		0	100.0	;	# 144 M_atp_c+M_air_c+M_hco3_c+M_h_c --> M_adp_c+M_pi_c+M_cair_c
		0	100.0	;	# 145 M_atp_c+M_cair_c+M_asp_L_c --> M_adp_c+M_pi_c+M_saicar_c
		0	100.0	;	# 146 M_saicar_c --> M_fum_c+M_aicar_c
		0	100.0	;	# 147 M_aicar_c+M_10fthf_c --> M_thf_c+M_faicar_c
		0	100.0	;	# 148 M_faicar_c --> M_imp_c+M_h2o_c
		0	100.0	;	# 149 M_imp_c+M_gtp_c+M_asp_L_c --> M_gdp_c+M_pi_c+M_fum_c+M_amp_c
		0	100.0	;	# 150 M_imp_c+M_nad_c+M_h2o_c --> M_xmp_c+M_nadh_c+M_h_c
		0	100.0	;	# 151 M_atp_c+M_xmp_c+M_gln_L_c+M_h2o_c --> M_amp_c+M_ppi_c+M_gmp_c+M_glu_L_c
		0	100.0	;	# 152 M_atp_c+M_h2o_c --> M_amp_c+M_ppi_c
		0	100.0	;	# 153 M_utp_c+M_h2o_c --> M_ump_c+M_ppi_c
		0	100.0	;	# 154 M_ctp_c+M_h2o_c --> M_cmp_c+M_ppi_c
		0	100.0	;	# 155 M_gtp_c+M_h2o_c --> M_gmp_c+M_ppi_c
		0	100.0	;	# 156 M_atp_c+M_h2o_c --> M_adp_c+M_pi_c
		0	100.0	;	# 157 M_utp_c+M_h2o_c --> M_udp_c+M_pi_c
		0	100.0	;	# 158 M_ctp_c+M_h2o_c --> M_cdp_c+M_pi_c
		0	100.0	;	# 159 M_gtp_c+M_h2o_c --> M_gdp_c+M_pi_c
		0	100.0	;	# 160 M_udp_c+M_atp_c --> M_utp_c+M_adp_c
		0	100.0	;	# 161 M_cdp_c+M_atp_c --> M_ctp_c+M_adp_c
		0	100.0	;	# 162 M_gdp_c+M_atp_c --> M_gtp_c+M_adp_c
		0	100.0	;	# 163 M_atp_c+M_ump_c --> M_adp_c+M_udp_c
		0	100.0	;	# 164 M_atp_c+M_cmp_c --> M_adp_c+M_cdp_c
		0	100.0	;	# 165 M_atp_c+M_gmp_c --> M_adp_c+M_gdp_c
		0	100.0	;	# 166 M_amp_c+M_atp_c --> 2.0*M_adp_c
		0	100.0	;	# 167 GENE_S38+RNAP --> OPEN_GENE_S38
		0	100.0	;	# 168 OPEN_GENE_S38+292.0*M_gtp_c+225.0*M_ctp_c+222.0*M_utp_c+254.0*M_atp_c+993.0*M_h2o_c --> mRNA_S38+GENE_S38+RNAP+993.0*M_ppi_c
		0	100.0	;	# 169 mRNA_S38 --> 292.0*M_gmp_c+225.0*M_cmp_c+222.0*M_ump_c+254.0*M_amp_c
		0	100.0	;	# 170 GENE_S28+RNAP --> OPEN_GENE_S28
		0	100.0	;	# 171 OPEN_GENE_S28+181.0*M_gtp_c+147.0*M_ctp_c+191.0*M_utp_c+219.0*M_atp_c+738.0*M_h2o_c --> mRNA_S28+GENE_S28+RNAP+738.0*M_ppi_c
		0	100.0	;	# 172 mRNA_S28 --> 181.0*M_gmp_c+147.0*M_cmp_c+191.0*M_ump_c+219.0*M_amp_c
		0	100.0	;	# 173 GENE_S19+RNAP --> OPEN_GENE_S19
		0	100.0	;	# 174 OPEN_GENE_S19+140.0*M_gtp_c+145.0*M_ctp_c+117.0*M_utp_c+120.0*M_atp_c+522.0*M_h2o_c --> mRNA_S19+GENE_S19+RNAP+522.0*M_ppi_c
		0	100.0	;	# 175 mRNA_S19 --> 140.0*M_gmp_c+145.0*M_cmp_c+117.0*M_ump_c+120.0*M_amp_c
		0	100.0	;	# 176 GENE_P38+RNAP --> OPEN_GENE_P38
		0	100.0	;	# 177 OPEN_GENE_P38+0.0*M_gtp_c+0.0*M_ctp_c+0.0*M_utp_c+0.0*M_atp_c+0.0*M_h2o_c --> mRNA_P38+GENE_P38+RNAP+0.0*M_ppi_c
		0	100.0	;	# 178 mRNA_P38 --> 0.0*M_gmp_c+0.0*M_cmp_c+0.0*M_ump_c+0.0*M_amp_c
		0	100.0	;	# 179 GENE_P28+RNAP --> OPEN_GENE_P28
		0	100.0	;	# 180 OPEN_GENE_P28+15.0*M_gtp_c+11.0*M_ctp_c+17.0*M_utp_c+12.0*M_atp_c+55.0*M_h2o_c --> mRNA_P28+GENE_P28+RNAP+55.0*M_ppi_c
		0	100.0	;	# 181 mRNA_P28 --> 15.0*M_gmp_c+11.0*M_cmp_c+17.0*M_ump_c+12.0*M_amp_c
		0	100.0	;	# 182 GENE_P19+RNAP --> OPEN_GENE_P19
		0	100.0	;	# 183 OPEN_GENE_P19+11.0*M_gtp_c+9.0*M_ctp_c+23.0*M_utp_c+14.0*M_atp_c+57.0*M_h2o_c --> mRNA_P19+GENE_P19+RNAP+57.0*M_ppi_c
		0	100.0	;	# 184 mRNA_P19 --> 11.0*M_gmp_c+9.0*M_cmp_c+23.0*M_ump_c+14.0*M_amp_c
		0	100.0	;	# 185 GENE_LACI+RNAP --> OPEN_GENE_LACI
		0	100.0	;	# 186 OPEN_GENE_LACI+314.0*M_gtp_c+296.0*M_ctp_c+234.0*M_utp_c+239.0*M_atp_c+1083.0*M_h2o_c --> mRNA_LACI+GENE_LACI+RNAP+1083.0*M_ppi_c
		0	100.0	;	# 187 mRNA_LACI --> 314.0*M_gmp_c+296.0*M_cmp_c+234.0*M_ump_c+239.0*M_amp_c
		0	100.0	;	# 188 GENE_GLUCAGON+RNAP --> OPEN_GENE_GLUCAGON
		0	100.0	;	# 189 OPEN_GENE_GLUCAGON+136.0*M_gtp_c+116.0*M_ctp_c+131.0*M_utp_c+160.0*M_atp_c+543.0*M_h2o_c --> mRNA_GLUCAGON+GENE_GLUCAGON+RNAP+543.0*M_ppi_c
		0	100.0	;	# 190 mRNA_GLUCAGON --> 136.0*M_gmp_c+116.0*M_cmp_c+131.0*M_ump_c+160.0*M_amp_c
		0	100.0	;	# 191 GENE_ENZYME+RNAP --> OPEN_GENE_ENZYME
		0	100.0	;	# 192 OPEN_GENE_ENZYME+1072.0*M_gtp_c+1049.0*M_ctp_c+1298.0*M_utp_c+1414.0*M_atp_c+4833.0*M_h2o_c --> mRNA_ENZYME+GENE_ENZYME+RNAP+4833.0*M_ppi_c
		0	100.0	;	# 193 mRNA_ENZYME --> 1072.0*M_gmp_c+1049.0*M_cmp_c+1298.0*M_ump_c+1414.0*M_amp_c
		0	100.0	;	# 194 GENE_CAP+RNAP --> OPEN_GENE_CAP
		0	100.0	;	# 195 OPEN_GENE_CAP+156.0*M_gtp_c+164.0*M_ctp_c+143.0*M_utp_c+170.0*M_atp_c+633.0*M_h2o_c --> mRNA_CAP+GENE_CAP+RNAP+633.0*M_ppi_c
		0	100.0	;	# 196 mRNA_CAP --> 156.0*M_gmp_c+164.0*M_cmp_c+143.0*M_ump_c+170.0*M_amp_c
		0	100.0	;	# 197 GENE_Insulin+RNAP --> OPEN_GENE_Insulin
		0	100.0	;	# 198 OPEN_GENE_Insulin+514.0*M_gtp_c+522.0*M_ctp_c+314.0*M_utp_c+272.0*M_atp_c+1622.0*M_h2o_c --> mRNA_Insulin+GENE_Insulin+RNAP+1622.0*M_ppi_c
		0	100.0	;	# 199 mRNA_Insulin --> 514.0*M_gmp_c+522.0*M_cmp_c+314.0*M_ump_c+272.0*M_amp_c
		0	100.0	;	# 200 mRNA_S38+RIBOSOME --> RIBOSOME_START_S38
		0	100.0	;	# 201 RIBOSOME_START_S38+660.0*M_gtp_c+660.0*M_h2o_c+24.0*M_ala_L_c_tRNA+34.0*M_arg_L_c_tRNA+13.0*M_asn_L_c_tRNA+23.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+41.0*M_glu_L_c_tRNA+15.0*M_gln_L_c_tRNA+19.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+19.0*M_ile_L_c_tRNA+44.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+9.0*M_phe_L_c_tRNA+8.0*M_pro_L_c_tRNA+13.0*M_ser_L_c_tRNA+17.0*M_thr_L_c_tRNA+3.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+20.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S38+PROTEIN_S38+660.0*M_gdp_c+660.0*M_pi_c+330.0*tRNA
		0	100.0	;	# 202 24.0*M_ala_L_c+24.0*M_atp_c+24.0*tRNA+24.0*M_h2o_c --> 24.0*M_ala_L_c_tRNA+24.0*M_amp_c+24.0*M_ppi_c
		0	100.0	;	# 203 34.0*M_arg_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_arg_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0	100.0	;	# 204 13.0*M_asn_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_asn_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 205 23.0*M_asp_L_c+23.0*M_atp_c+23.0*tRNA+23.0*M_h2o_c --> 23.0*M_asp_L_c_tRNA+23.0*M_amp_c+23.0*M_ppi_c
		0	100.0	;	# 206 0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c
		0	100.0	;	# 207 41.0*M_glu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_glu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c
		0	100.0	;	# 208 15.0*M_gln_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_gln_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0	100.0	;	# 209 19.0*M_gly_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_gly_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0	100.0	;	# 210 4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 211 19.0*M_ile_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ile_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0	100.0	;	# 212 44.0*M_leu_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_leu_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c
		0	100.0	;	# 213 12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0	100.0	;	# 214 5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 215 9.0*M_phe_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_phe_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 216 8.0*M_pro_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_pro_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 217 13.0*M_ser_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ser_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 218 17.0*M_thr_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_thr_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0	100.0	;	# 219 3.0*M_trp_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_trp_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0	100.0	;	# 220 7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 221 20.0*M_val_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_val_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0	100.0	;	# 222 mRNA_S28+RIBOSOME --> RIBOSOME_START_S28
		0	100.0	;	# 223 RIBOSOME_START_S28+490.0*M_gtp_c+490.0*M_h2o_c+19.0*M_ala_L_c_tRNA+13.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+20.0*M_asp_L_c_tRNA+M_cys_L_c_tRNA+18.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+25.0*M_leu_L_c_tRNA+13.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+7.0*M_pro_L_c_tRNA+21.0*M_ser_L_c_tRNA+7.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+18.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S28+PROTEIN_S28+490.0*M_gdp_c+490.0*M_pi_c+245.0*tRNA
		0	100.0	;	# 224 19.0*M_ala_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ala_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0	100.0	;	# 225 13.0*M_arg_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_arg_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 226 11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 227 20.0*M_asp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_asp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0	100.0	;	# 228 M_cys_L_c+M_atp_c+tRNA+M_h2o_c --> M_cys_L_c_tRNA+M_amp_c+M_ppi_c
		0	100.0	;	# 229 18.0*M_glu_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_glu_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 230 14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0	100.0	;	# 231 16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 232 6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 233 17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0	100.0	;	# 234 25.0*M_leu_L_c+25.0*M_atp_c+25.0*tRNA+25.0*M_h2o_c --> 25.0*M_leu_L_c_tRNA+25.0*M_amp_c+25.0*M_ppi_c
		0	100.0	;	# 235 13.0*M_lys_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_lys_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 236 5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 237 5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 238 7.0*M_pro_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_pro_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 239 21.0*M_ser_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_ser_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c
		0	100.0	;	# 240 7.0*M_thr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_thr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 241 2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 242 7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 243 18.0*M_val_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_val_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 244 mRNA_S19+RIBOSOME --> RIBOSOME_START_S19
		0	100.0	;	# 245 RIBOSOME_START_S19+346.0*M_gtp_c+346.0*M_h2o_c+14.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+2.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+2.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+5.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+5.0*M_ile_L_c_tRNA+28.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+7.0*M_phe_L_c_tRNA+4.0*M_pro_L_c_tRNA+16.0*M_ser_L_c_tRNA+13.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S19+PROTEIN_S19+346.0*M_gdp_c+346.0*M_pi_c+173.0*tRNA
		0	100.0	;	# 246 14.0*M_ala_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_ala_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0	100.0	;	# 247 11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 248 2.0*M_asn_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_asn_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 249 10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0	100.0	;	# 250 2.0*M_cys_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_cys_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 251 13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 252 5.0*M_gln_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_gln_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 253 9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 254 4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 255 5.0*M_ile_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_ile_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 256 28.0*M_leu_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_leu_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0	100.0	;	# 257 9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 258 6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 259 7.0*M_phe_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_phe_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 260 4.0*M_pro_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_pro_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 261 16.0*M_ser_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_ser_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 262 13.0*M_thr_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_thr_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 263 2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 264 5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 265 8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 266 mRNA_LACI+RIBOSOME --> RIBOSOME_START_LACI
		0	100.0	;	# 267 RIBOSOME_START_LACI+720.0*M_gtp_c+720.0*M_h2o_c+45.0*M_ala_L_c_tRNA+19.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+17.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+15.0*M_glu_L_c_tRNA+28.0*M_gln_L_c_tRNA+22.0*M_gly_L_c_tRNA+7.0*M_his_L_c_tRNA+18.0*M_ile_L_c_tRNA+41.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+10.0*M_met_L_c_tRNA+4.0*M_phe_L_c_tRNA+14.0*M_pro_L_c_tRNA+32.0*M_ser_L_c_tRNA+18.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+8.0*M_tyr_L_c_tRNA+34.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_LACI+PROTEIN_LACI+720.0*M_gdp_c+720.0*M_pi_c+360.0*tRNA
		0	100.0	;	# 268 45.0*M_ala_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_ala_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c
		0	100.0	;	# 269 19.0*M_arg_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_arg_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0	100.0	;	# 270 11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 271 17.0*M_asp_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_asp_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0	100.0	;	# 272 3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0	100.0	;	# 273 15.0*M_glu_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_glu_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0	100.0	;	# 274 28.0*M_gln_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_gln_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0	100.0	;	# 275 22.0*M_gly_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_gly_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0	100.0	;	# 276 7.0*M_his_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_his_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 277 18.0*M_ile_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_ile_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 278 41.0*M_leu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_leu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c
		0	100.0	;	# 279 12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0	100.0	;	# 280 10.0*M_met_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_met_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0	100.0	;	# 281 4.0*M_phe_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_phe_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 282 14.0*M_pro_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_pro_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0	100.0	;	# 283 32.0*M_ser_L_c+32.0*M_atp_c+32.0*tRNA+32.0*M_h2o_c --> 32.0*M_ser_L_c_tRNA+32.0*M_amp_c+32.0*M_ppi_c
		0	100.0	;	# 284 18.0*M_thr_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_thr_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 285 2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 286 8.0*M_tyr_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_tyr_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 287 34.0*M_val_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_val_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0	100.0	;	# 288 mRNA_GLUCAGON+RIBOSOME --> RIBOSOME_START_GLUCAGON
		0	100.0	;	# 289 RIBOSOME_START_GLUCAGON+360.0*M_gtp_c+360.0*M_h2o_c+13.0*M_ala_L_c_tRNA+16.0*M_arg_L_c_tRNA+8.0*M_asn_L_c_tRNA+16.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+10.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+8.0*M_ile_L_c_tRNA+12.0*M_leu_L_c_tRNA+10.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+3.0*M_pro_L_c_tRNA+17.0*M_ser_L_c_tRNA+9.0*M_thr_L_c_tRNA+4.0*M_trp_L_c_tRNA+4.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_GLUCAGON+PROTEIN_GLUCAGON+360.0*M_gdp_c+360.0*M_pi_c+180.0*tRNA
		0	100.0	;	# 290 13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 291 16.0*M_arg_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_arg_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 292 8.0*M_asn_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asn_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 293 16.0*M_asp_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_asp_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 294 0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c
		0	100.0	;	# 295 13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 296 10.0*M_gln_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_gln_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0	100.0	;	# 297 9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 298 4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 299 8.0*M_ile_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_ile_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 300 12.0*M_leu_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_leu_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0	100.0	;	# 301 10.0*M_lys_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_lys_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0	100.0	;	# 302 5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 303 11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 304 3.0*M_pro_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_pro_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0	100.0	;	# 305 17.0*M_ser_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ser_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0	100.0	;	# 306 9.0*M_thr_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_thr_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 307 4.0*M_trp_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_trp_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 308 4.0*M_tyr_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_tyr_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0	100.0	;	# 309 8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 310 mRNA_ENZYME+RIBOSOME --> RIBOSOME_START_ENZYME
		0	100.0	;	# 311 RIBOSOME_START_ENZYME+3220.0*M_gtp_c+3220.0*M_h2o_c+81.0*M_ala_L_c_tRNA+67.0*M_arg_L_c_tRNA+81.0*M_asn_L_c_tRNA+61.0*M_asp_L_c_tRNA+45.0*M_cys_L_c_tRNA+119.0*M_glu_L_c_tRNA+72.0*M_gln_L_c_tRNA+72.0*M_gly_L_c_tRNA+52.0*M_his_L_c_tRNA+116.0*M_ile_L_c_tRNA+192.0*M_leu_L_c_tRNA+109.0*M_lys_L_c_tRNA+65.0*M_met_L_c_tRNA+91.0*M_phe_L_c_tRNA+52.0*M_pro_L_c_tRNA+93.0*M_ser_L_c_tRNA+67.0*M_thr_L_c_tRNA+20.0*M_trp_L_c_tRNA+69.0*M_tyr_L_c_tRNA+86.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_ENZYME+PROTEIN_ENZYME+3220.0*M_gdp_c+3220.0*M_pi_c+1610.0*tRNA
		0	100.0	;	# 312 81.0*M_ala_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_ala_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c
		0	100.0	;	# 313 67.0*M_arg_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_arg_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c
		0	100.0	;	# 314 81.0*M_asn_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_asn_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c
		0	100.0	;	# 315 61.0*M_asp_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_asp_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c
		0	100.0	;	# 316 45.0*M_cys_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_cys_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c
		0	100.0	;	# 317 119.0*M_glu_L_c+119.0*M_atp_c+119.0*tRNA+119.0*M_h2o_c --> 119.0*M_glu_L_c_tRNA+119.0*M_amp_c+119.0*M_ppi_c
		0	100.0	;	# 318 72.0*M_gln_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gln_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c
		0	100.0	;	# 319 72.0*M_gly_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gly_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c
		0	100.0	;	# 320 52.0*M_his_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_his_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0	100.0	;	# 321 116.0*M_ile_L_c+116.0*M_atp_c+116.0*tRNA+116.0*M_h2o_c --> 116.0*M_ile_L_c_tRNA+116.0*M_amp_c+116.0*M_ppi_c
		0	100.0	;	# 322 192.0*M_leu_L_c+192.0*M_atp_c+192.0*tRNA+192.0*M_h2o_c --> 192.0*M_leu_L_c_tRNA+192.0*M_amp_c+192.0*M_ppi_c
		0	100.0	;	# 323 109.0*M_lys_L_c+109.0*M_atp_c+109.0*tRNA+109.0*M_h2o_c --> 109.0*M_lys_L_c_tRNA+109.0*M_amp_c+109.0*M_ppi_c
		0	100.0	;	# 324 65.0*M_met_L_c+65.0*M_atp_c+65.0*tRNA+65.0*M_h2o_c --> 65.0*M_met_L_c_tRNA+65.0*M_amp_c+65.0*M_ppi_c
		0	100.0	;	# 325 91.0*M_phe_L_c+91.0*M_atp_c+91.0*tRNA+91.0*M_h2o_c --> 91.0*M_phe_L_c_tRNA+91.0*M_amp_c+91.0*M_ppi_c
		0	100.0	;	# 326 52.0*M_pro_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_pro_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0	100.0	;	# 327 93.0*M_ser_L_c+93.0*M_atp_c+93.0*tRNA+93.0*M_h2o_c --> 93.0*M_ser_L_c_tRNA+93.0*M_amp_c+93.0*M_ppi_c
		0	100.0	;	# 328 67.0*M_thr_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_thr_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c
		0	100.0	;	# 329 20.0*M_trp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_trp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0	100.0	;	# 330 69.0*M_tyr_L_c+69.0*M_atp_c+69.0*tRNA+69.0*M_h2o_c --> 69.0*M_tyr_L_c_tRNA+69.0*M_amp_c+69.0*M_ppi_c
		0	100.0	;	# 331 86.0*M_val_L_c+86.0*M_atp_c+86.0*tRNA+86.0*M_h2o_c --> 86.0*M_val_L_c_tRNA+86.0*M_amp_c+86.0*M_ppi_c
		0	100.0	;	# 332 mRNA_CAP+RIBOSOME --> RIBOSOME_START_CAP
		0	100.0	;	# 333 RIBOSOME_START_CAP+420.0*M_gtp_c+420.0*M_h2o_c+13.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+5.0*M_asn_L_c_tRNA+8.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+16.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+22.0*M_leu_L_c_tRNA+15.0*M_lys_L_c_tRNA+7.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+6.0*M_pro_L_c_tRNA+12.0*M_ser_L_c_tRNA+12.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+6.0*M_tyr_L_c_tRNA+14.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_CAP+PROTEIN_CAP+420.0*M_gdp_c+420.0*M_pi_c+210.0*tRNA
		0	100.0	;	# 334 13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0	100.0	;	# 335 11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 336 5.0*M_asn_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_asn_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 337 8.0*M_asp_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asp_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0	100.0	;	# 338 3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0	100.0	;	# 339 16.0*M_glu_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_glu_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 340 14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0	100.0	;	# 341 16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0	100.0	;	# 342 6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 343 17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0	100.0	;	# 344 22.0*M_leu_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_leu_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0	100.0	;	# 345 15.0*M_lys_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_lys_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0	100.0	;	# 346 7.0*M_met_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_met_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0	100.0	;	# 347 5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 348 6.0*M_pro_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_pro_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 349 12.0*M_ser_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_ser_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0	100.0	;	# 350 12.0*M_thr_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_thr_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0	100.0	;	# 351 2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0	100.0	;	# 352 6.0*M_tyr_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_tyr_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 353 14.0*M_val_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_val_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0	100.0	;	# 354 mRNA_Insulin+RIBOSOME --> RIBOSOME_START_Insulin
		0	100.0	;	# 355 RIBOSOME_START_Insulin+1048.0*M_gtp_c+1048.0*M_h2o_c+52.0*M_ala_L_c_tRNA+44.0*M_arg_L_c_tRNA+6.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+28.0*M_cys_L_c_tRNA+27.0*M_glu_L_c_tRNA+21.0*M_gln_L_c_tRNA+61.0*M_gly_L_c_tRNA+18.0*M_his_L_c_tRNA+3.0*M_ile_L_c_tRNA+71.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+58.0*M_pro_L_c_tRNA+34.0*M_ser_L_c_tRNA+20.0*M_thr_L_c_tRNA+18.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+22.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_Insulin+PROTEIN_Insulin+1048.0*M_gdp_c+1048.0*M_pi_c+524.0*tRNA
		0	100.0	;	# 356 52.0*M_ala_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_ala_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0	100.0	;	# 357 44.0*M_arg_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_arg_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c
		0	100.0	;	# 358 6.0*M_asn_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_asn_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 359 10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0	100.0	;	# 360 28.0*M_cys_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_cys_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0	100.0	;	# 361 27.0*M_glu_L_c+27.0*M_atp_c+27.0*tRNA+27.0*M_h2o_c --> 27.0*M_glu_L_c_tRNA+27.0*M_amp_c+27.0*M_ppi_c
		0	100.0	;	# 362 21.0*M_gln_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_gln_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c
		0	100.0	;	# 363 61.0*M_gly_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_gly_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c
		0	100.0	;	# 364 18.0*M_his_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_his_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 365 3.0*M_ile_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_ile_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0	100.0	;	# 366 71.0*M_leu_L_c+71.0*M_atp_c+71.0*tRNA+71.0*M_h2o_c --> 71.0*M_leu_L_c_tRNA+71.0*M_amp_c+71.0*M_ppi_c
		0	100.0	;	# 367 9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0	100.0	;	# 368 6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0	100.0	;	# 369 11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0	100.0	;	# 370 58.0*M_pro_L_c+58.0*M_atp_c+58.0*tRNA+58.0*M_h2o_c --> 58.0*M_pro_L_c_tRNA+58.0*M_amp_c+58.0*M_ppi_c
		0	100.0	;	# 371 34.0*M_ser_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_ser_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0	100.0	;	# 372 20.0*M_thr_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_thr_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0	100.0	;	# 373 18.0*M_trp_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_trp_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0	100.0	;	# 374 5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0	100.0	;	# 375 22.0*M_val_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_val_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0	100.0	;	# 376 [] --> tRNA_c
		0	100.0	;	# 377 tRNA_c --> []
		0	100.0	;	# 378 PROTEIN_S38 --> []
		0	100.0	;	# 379 PROTEIN_S28 --> []
		0	100.0	;	# 380 PROTEIN_S19 --> []
		0	100.0	;	# 381 PROTEIN_LACI --> []
		0	100.0	;	# 382 PROTEIN_ENZYME --> []
		0	100.0	;	# 383 PROTEIN_CAP --> []
		0	100.0	;	# 384 PROTEIN_Glucagon --> []
		0	100.0	;	# 385 PROTEIN_Insulin --> []
		0	100.0	;	# 386 cAMP --> []
		0	100.0	;	# 387 [] --> M_o2_c
		0	100.0	;	# 388 M_co2_c --> []
		0	100.0	;	# 389 M_h_c --> []
		0	100.0	;	# 390 [] --> M_h_c
		0	100.0	;	# 391 [] --> M_h2s_c
		0	100.0	;	# 392 M_h2s_c --> []
		0	100.0	;	# 393 [] --> M_h2o_c
		0	100.0	;	# 394 M_h2o_c --> []
		0	100.0	;	# 395 [] --> M_pi_c
		0	100.0	;	# 396 M_pi_c --> []
		0	100.0	;	# 397 [] --> M_nh3_c
		0	100.0	;	# 398 M_nh3_c --> []
		0	100.0	;	# 399 [] --> M_glc_D_c
		0	100.0	;	# 400 [] --> M_hco3_c
		0	100.0	;	# 401 M_hco3_c --> []
		0	100.0	;	# 402 M_pyr_c --> []
		0	100.0	;	# 403 [] --> M_pyr_c
		0	100.0	;	# 404 M_ac_c --> []
		0	100.0	;	# 405 M_lac_D_c --> []
		0	100.0	;	# 406 M_succ_c --> []
		0	100.0	;	# 407 M_mal_L_c --> []
		0	100.0	;	# 408 M_fum_c --> []
		0	100.0	;	# 409 M_etoh_c --> []
		0	100.0	;	# 410 M_mglx_c --> []
		0	100.0	;	# 411 M_prop_c --> []
		0	100.0	;	# 412 M_indole_c --> []
		0	100.0	;	# 413 M_cadav_c --> []
		0	100.0	;	# 414 M_gaba_c --> []
		0	100.0	;	# 415 M_glycoA_c --> []
		0	100.0	;	# 416 [] --> M_ala_L_c
		0	100.0	;	# 417 M_ala_L_c --> []
		0	100.0	;	# 418 [] --> M_arg_L_c
		0	100.0	;	# 419 M_arg_L_c --> []
		0	100.0	;	# 420 [] --> M_asn_L_c
		0	100.0	;	# 421 M_asn_L_c --> []
		0	100.0	;	# 422 [] --> M_asp_L_c
		0	100.0	;	# 423 M_asp_L_c --> []
		0	100.0	;	# 424 [] --> M_cys_L_c
		0	100.0	;	# 425 M_cys_L_c --> []
		0	100.0	;	# 426 [] --> M_glu_L_c
		0	100.0	;	# 427 M_glu_L_c --> []
		0	100.0	;	# 428 [] --> M_gln_L_c
		0	100.0	;	# 429 M_gln_L_c --> []
		0	100.0	;	# 430 [] --> M_gly_L_c
		0	100.0	;	# 431 M_gly_L_c --> []
		0	100.0	;	# 432 [] --> M_his_L_c
		0	100.0	;	# 433 M_his_L_c --> []
		0	100.0	;	# 434 [] --> M_ile_L_c
		0	100.0	;	# 435 M_ile_L_c --> []
		0	100.0	;	# 436 [] --> M_leu_L_c
		0	100.0	;	# 437 M_leu_L_c --> []
		0	100.0	;	# 438 [] --> M_lys_L_c
		0	100.0	;	# 439 M_lys_L_c --> []
		0	100.0	;	# 440 [] --> M_met_L_c
		0	100.0	;	# 441 M_met_L_c --> []
		0	100.0	;	# 442 [] --> M_phe_L_c
		0	100.0	;	# 443 M_phe_L_c --> []
		0	100.0	;	# 444 [] --> M_pro_L_c
		0	100.0	;	# 445 M_pro_L_c --> []
		0	100.0	;	# 446 [] --> M_ser_L_c
		0	100.0	;	# 447 M_ser_L_c --> []
		0	100.0	;	# 448 [] --> M_thr_L_c
		0	100.0	;	# 449 M_thr_L_c --> []
		0	100.0	;	# 450 [] --> M_trp_L_c
		0	100.0	;	# 451 M_trp_L_c --> []
		0	100.0	;	# 452 [] --> M_tyr_L_c
		0	100.0	;	# 453 M_tyr_L_c --> []
		0	100.0	;	# 454 [] --> M_val_L_c
		0	100.0	;	# 455 M_val_L_c --> []
	];

	# Setup default species bounds array - 
	species_bounds_array = [
		0.0	0.0	;	# 1 GENE_CAP
		0.0	0.0	;	# 2 GENE_ENZYME
		0.0	0.0	;	# 3 GENE_GLUCAGON
		0.0	0.0	;	# 4 GENE_Insulin
		0.0	0.0	;	# 5 GENE_LACI
		0.0	0.0	;	# 6 GENE_P19
		0.0	0.0	;	# 7 GENE_P28
		0.0	0.0	;	# 8 GENE_P38
		0.0	0.0	;	# 9 GENE_S19
		0.0	0.0	;	# 10 GENE_S28
		0.0	0.0	;	# 11 GENE_S38
		0.0	0.0	;	# 12 M_10fthf_c
		0.0	0.0	;	# 13 M_13dpg_c
		0.0	0.0	;	# 14 M_2ddg6p_c
		0.0	0.0	;	# 15 M_2pg_c
		0.0	0.0	;	# 16 M_3pg_c
		0.0	0.0	;	# 17 M_4abz_c
		0.0	0.0	;	# 18 M_4adochor_c
		0.0	0.0	;	# 19 M_5mthf_c
		0.0	0.0	;	# 20 M_5pbdra
		0.0	0.0	;	# 21 M_6pgc_c
		0.0	0.0	;	# 22 M_6pgl_c
		0.0	0.0	;	# 23 M_78dhf_c
		0.0	0.0	;	# 24 M_78mdp_c
		0.0	0.0	;	# 25 M_ac_c
		0.0	0.0	;	# 26 M_accoa_c
		0.0	0.0	;	# 27 M_actp_c
		0.0	0.0	;	# 28 M_adp_c
		0.0	0.0	;	# 29 M_aicar_c
		0.0	0.0	;	# 30 M_air_c
		0.0	0.0	;	# 31 M_akg_c
		0.0	0.0	;	# 32 M_ala_L_c
		0.0	0.0	;	# 33 M_ala_L_c_tRNA
		0.0	0.0	;	# 34 M_amp_c
		0.0	0.0	;	# 35 M_arg_L_c
		0.0	0.0	;	# 36 M_arg_L_c_tRNA
		0.0	0.0	;	# 37 M_asn_L_c
		0.0	0.0	;	# 38 M_asn_L_c_tRNA
		0.0	0.0	;	# 39 M_asp_L_c
		0.0	0.0	;	# 40 M_asp_L_c_tRNA
		0.0	0.0	;	# 41 M_atp_c
		0.0	0.0	;	# 42 M_cadav_c
		0.0	0.0	;	# 43 M_cair_c
		0.0	0.0	;	# 44 M_cdp_c
		0.0	0.0	;	# 45 M_chor_c
		0.0	0.0	;	# 46 M_cit_c
		0.0	0.0	;	# 47 M_clasp_c
		0.0	0.0	;	# 48 M_cmp_c
		0.0	0.0	;	# 49 M_co2_c
		0.0	0.0	;	# 50 M_coa_c
		0.0	0.0	;	# 51 M_ctp_c
		0.0	0.0	;	# 52 M_cys_L_c
		0.0	0.0	;	# 53 M_cys_L_c_tRNA
		0.0	0.0	;	# 54 M_dhap_c
		0.0	0.0	;	# 55 M_dhf_c
		0.0	0.0	;	# 56 M_e4p_c
		0.0	0.0	;	# 57 M_etoh_c
		0.0	0.0	;	# 58 M_f6p_c
		0.0	0.0	;	# 59 M_faicar_c
		0.0	0.0	;	# 60 M_fdp_c
		0.0	0.0	;	# 61 M_fgam_c
		0.0	0.0	;	# 62 M_fgar_c
		0.0	0.0	;	# 63 M_for_c
		0.0	0.0	;	# 64 M_fum_c
		0.0	0.0	;	# 65 M_g3p_c
		0.0	0.0	;	# 66 M_g6p_c
		0.0	0.0	;	# 67 M_gaba_c
		0.0	0.0	;	# 68 M_gar_c
		0.0	0.0	;	# 69 M_gdp_c
		0.0	0.0	;	# 70 M_glc_D_c
		0.0	0.0	;	# 71 M_gln_L_c
		0.0	0.0	;	# 72 M_gln_L_c_tRNA
		0.0	0.0	;	# 73 M_glu_L_c
		0.0	0.0	;	# 74 M_glu_L_c_tRNA
		0.0	0.0	;	# 75 M_glx_c
		0.0	0.0	;	# 76 M_gly_L_c
		0.0	0.0	;	# 77 M_gly_L_c_tRNA
		0.0	0.0	;	# 78 M_glycoA_c
		0.0	0.0	;	# 79 M_gmp_c
		0.0	0.0	;	# 80 M_gtp_c
		0.0	0.0	;	# 81 M_h2o2_c
		0.0	0.0	;	# 82 M_h2o_c
		0.0	0.0	;	# 83 M_h2s_c
		0.0	0.0	;	# 84 M_h_c
		0.0	0.0	;	# 85 M_hco3_c
		0.0	0.0	;	# 86 M_he_c
		0.0	0.0	;	# 87 M_his_L_c
		0.0	0.0	;	# 88 M_his_L_c_tRNA
		0.0	0.0	;	# 89 M_icit_c
		0.0	0.0	;	# 90 M_ile_L_c
		0.0	0.0	;	# 91 M_ile_L_c_tRNA
		0.0	0.0	;	# 92 M_imp_c
		0.0	0.0	;	# 93 M_indole_c
		0.0	0.0	;	# 94 M_lac_D_c
		0.0	0.0	;	# 95 M_leu_L_c
		0.0	0.0	;	# 96 M_leu_L_c_tRNA
		0.0	0.0	;	# 97 M_lys_L_c
		0.0	0.0	;	# 98 M_lys_L_c_tRNA
		0.0	0.0	;	# 99 M_mal_L_c
		0.0	0.0	;	# 100 M_met_L_c
		0.0	0.0	;	# 101 M_met_L_c_tRNA
		0.0	0.0	;	# 102 M_methf_c
		0.0	0.0	;	# 103 M_mglx_c
		0.0	0.0	;	# 104 M_mlthf_c
		0.0	0.0	;	# 105 M_mql8_c
		0.0	0.0	;	# 106 M_mqn8_c
		0.0	0.0	;	# 107 M_nad_c
		0.0	0.0	;	# 108 M_nadh_c
		0.0	0.0	;	# 109 M_nadp_c
		0.0	0.0	;	# 110 M_nadph_c
		0.0	0.0	;	# 111 M_nh3_c
		0.0	0.0	;	# 112 M_o2_c
		0.0	0.0	;	# 113 M_oaa_c
		0.0	0.0	;	# 114 M_omp_c
		0.0	0.0	;	# 115 M_or_c
		0.0	0.0	;	# 116 M_pep_c
		0.0	0.0	;	# 117 M_phe_L_c
		0.0	0.0	;	# 118 M_phe_L_c_tRNA
		0.0	0.0	;	# 119 M_pi_c
		0.0	0.0	;	# 120 M_ppi_c
		0.0	0.0	;	# 121 M_pro_L_c
		0.0	0.0	;	# 122 M_pro_L_c_tRNA
		0.0	0.0	;	# 123 M_prop_c
		0.0	0.0	;	# 124 M_prpp_c
		0.0	0.0	;	# 125 M_pyr_c
		0.0	0.0	;	# 126 M_q8_c
		0.0	0.0	;	# 127 M_q8h2_c
		0.0	0.0	;	# 128 M_r5p_c
		0.0	0.0	;	# 129 M_ru5p_D_c
		0.0	0.0	;	# 130 M_s7p_c
		0.0	0.0	;	# 131 M_saicar_c
		0.0	0.0	;	# 132 M_ser_L_c
		0.0	0.0	;	# 133 M_ser_L_c_tRNA
		0.0	0.0	;	# 134 M_succ_c
		0.0	0.0	;	# 135 M_succoa_c
		0.0	0.0	;	# 136 M_thf_c
		0.0	0.0	;	# 137 M_thr_L_c
		0.0	0.0	;	# 138 M_thr_L_c_tRNA
		0.0	0.0	;	# 139 M_trp_L_c
		0.0	0.0	;	# 140 M_trp_L_c_tRNA
		0.0	0.0	;	# 141 M_tyr_L_c
		0.0	0.0	;	# 142 M_tyr_L_c_tRNA
		0.0	0.0	;	# 143 M_udp_c
		0.0	0.0	;	# 144 M_ump_c
		0.0	0.0	;	# 145 M_utp_c
		0.0	0.0	;	# 146 M_val_L_c
		0.0	0.0	;	# 147 M_val_L_c_tRNA
		0.0	0.0	;	# 148 M_xmp_c
		0.0	0.0	;	# 149 M_xu5p_D_c
		0.0	0.0	;	# 150 OPEN_GENE_CAP
		0.0	0.0	;	# 151 OPEN_GENE_ENZYME
		0.0	0.0	;	# 152 OPEN_GENE_GLUCAGON
		0.0	0.0	;	# 153 OPEN_GENE_Insulin
		0.0	0.0	;	# 154 OPEN_GENE_LACI
		0.0	0.0	;	# 155 OPEN_GENE_P19
		0.0	0.0	;	# 156 OPEN_GENE_P28
		0.0	0.0	;	# 157 OPEN_GENE_P38
		0.0	0.0	;	# 158 OPEN_GENE_S19
		0.0	0.0	;	# 159 OPEN_GENE_S28
		0.0	0.0	;	# 160 OPEN_GENE_S38
		0.0	0.0	;	# 161 PROTEIN_CAP
		0.0	0.0	;	# 162 PROTEIN_ENZYME
		0.0	0.0	;	# 163 PROTEIN_GLUCAGON
		0.0	0.0	;	# 164 PROTEIN_Glucagon
		0.0	0.0	;	# 165 PROTEIN_Insulin
		0.0	0.0	;	# 166 PROTEIN_LACI
		0.0	0.0	;	# 167 PROTEIN_S19
		0.0	0.0	;	# 168 PROTEIN_S28
		0.0	0.0	;	# 169 PROTEIN_S38
		0.0	0.0	;	# 170 RIBOSOME
		0.0	0.0	;	# 171 RIBOSOME_START_CAP
		0.0	0.0	;	# 172 RIBOSOME_START_ENZYME
		0.0	0.0	;	# 173 RIBOSOME_START_GLUCAGON
		0.0	0.0	;	# 174 RIBOSOME_START_Insulin
		0.0	0.0	;	# 175 RIBOSOME_START_LACI
		0.0	0.0	;	# 176 RIBOSOME_START_S19
		0.0	0.0	;	# 177 RIBOSOME_START_S28
		0.0	0.0	;	# 178 RIBOSOME_START_S38
		0.0	0.0	;	# 179 RNAP
		0.0	0.0	;	# 180 cAMP
		0.0	0.0	;	# 181 mRNA_CAP
		0.0	0.0	;	# 182 mRNA_ENZYME
		0.0	0.0	;	# 183 mRNA_GLUCAGON
		0.0	0.0	;	# 184 mRNA_Insulin
		0.0	0.0	;	# 185 mRNA_LACI
		0.0	0.0	;	# 186 mRNA_P19
		0.0	0.0	;	# 187 mRNA_P28
		0.0	0.0	;	# 188 mRNA_P38
		0.0	0.0	;	# 189 mRNA_S19
		0.0	0.0	;	# 190 mRNA_S28
		0.0	0.0	;	# 191 mRNA_S38
		0.0	0.0	;	# 192 tRNA
		0.0	0.0	;	# 193 tRNA_c
	];

	# Setup the objective coefficient array - 
	objective_coefficient_array = [
		0.0	;	# 1 R_glk_atp::M_atp_c+M_glc_D_c --> M_adp_c+M_g6p_c
		0.0	;	# 2 R_pgi::M_g6p_c --> M_f6p_c
		0.0	;	# 3 R_pgi_reverse::M_f6p_c --> M_g6p_c
		0.0	;	# 4 R_pfk::M_atp_c+M_f6p_c --> M_adp_c+M_fdp_c
		0.0	;	# 5 R_fdp::M_fdp_c+M_h2o_c --> M_f6p_c+M_pi_c
		0.0	;	# 6 R_fbaA::M_fdp_c --> M_dhap_c+M_g3p_c
		0.0	;	# 7 R_fbaA_reverse::M_dhap_c+M_g3p_c --> M_fdp_c
		0.0	;	# 8 R_tpiA::M_dhap_c --> M_g3p_c
		0.0	;	# 9 R_tpiA_reverse::M_g3p_c --> M_dhap_c
		0.0	;	# 10 R_gapA::M_g3p_c+M_nad_c+M_pi_c --> M_13dpg_c+M_h_c+M_nadh_c
		0.0	;	# 11 R_gapA_reverse::M_13dpg_c+M_h_c+M_nadh_c --> M_g3p_c+M_nad_c+M_pi_c
		0.0	;	# 12 R_pgk::M_13dpg_c+M_adp_c --> M_3pg_c+M_atp_c
		0.0	;	# 13 R_pgk_reverse::M_3pg_c+M_atp_c --> M_13dpg_c+M_adp_c
		0.0	;	# 14 R_gpm::M_3pg_c --> M_2pg_c
		0.0	;	# 15 R_gpm_reverse::M_2pg_c --> M_3pg_c
		0.0	;	# 16 R_eno::M_2pg_c --> M_h2o_c+M_pep_c
		0.0	;	# 17 R_eno_reverse::M_h2o_c+M_pep_c --> M_2pg_c
		0.0	;	# 18 R_pyk::M_adp_c+M_pep_c --> M_atp_c+M_pyr_c
		0.0	;	# 19 R_pck::M_atp_c+M_oaa_c --> M_adp_c+M_co2_c+M_pep_c
		0.0	;	# 20 R_ppc::M_co2_c+M_h2o_c+M_pep_c --> M_oaa_c+M_pi_c
		0.0	;	# 21 R_pdh::M_coa_c+M_nad_c+M_pyr_c --> M_accoa_c+M_co2_c+M_nadh_c+M_h_c
		0.0	;	# 22 R_pps::M_atp_c+M_h2o_c+M_pyr_c --> M_amp_c+M_pep_c+M_pi_c
		0.0	;	# 23 R_zwf::M_g6p_c+M_nadp_c --> M_6pgl_c+M_h_c+M_nadph_c
		0.0	;	# 24 R_zwf_reverse::M_6pgl_c+M_h_c+M_nadph_c --> M_g6p_c+M_nadp_c
		0.0	;	# 25 R_pgl::M_6pgl_c+M_h2o_c --> M_6pgc_c
		0.0	;	# 26 R_gnd::M_6pgc_c+M_nadp_c --> M_co2_c+M_nadph_c+M_ru5p_D_c+M_h_c
		0.0	;	# 27 R_rpe::M_ru5p_D_c --> M_xu5p_D_c
		0.0	;	# 28 R_rpe_reverse::M_xu5p_D_c --> M_ru5p_D_c
		0.0	;	# 29 R_rpi::M_r5p_c --> M_ru5p_D_c
		0.0	;	# 30 R_rpi_reverse::M_ru5p_D_c --> M_r5p_c
		0.0	;	# 31 R_talAB::M_g3p_c+M_s7p_c --> M_e4p_c+M_f6p_c
		0.0	;	# 32 R_talAB_reverse::M_e4p_c+M_f6p_c --> M_g3p_c+M_s7p_c
		0.0	;	# 33 R_tkt1::M_r5p_c+M_xu5p_D_c --> M_g3p_c+M_s7p_c
		0.0	;	# 34 R_tkt1_reverse::M_g3p_c+M_s7p_c --> M_r5p_c+M_xu5p_D_c
		0.0	;	# 35 R_tkt2::M_e4p_c+M_xu5p_D_c --> M_f6p_c+M_g3p_c
		0.0	;	# 36 R_tkt2_reverse::M_f6p_c+M_g3p_c --> M_e4p_c+M_xu5p_D_c
		0.0	;	# 37 R_edd::M_6pgc_c --> M_2ddg6p_c+M_h2o_c
		0.0	;	# 38 R_eda::M_2ddg6p_c --> M_g3p_c+M_pyr_c
		0.0	;	# 39 R_gltA::M_accoa_c+M_h2o_c+M_oaa_c --> M_cit_c+M_coa_c
		0.0	;	# 40 R_acn::M_cit_c --> M_icit_c
		0.0	;	# 41 R_acn_reverse::M_icit_c --> M_cit_c
		0.0	;	# 42 R_icd::M_icit_c+M_nadp_c --> M_akg_c+M_co2_c+M_nadph_c+M_h_c
		0.0	;	# 43 R_icd_reverse::M_akg_c+M_co2_c+M_nadph_c+M_h_c --> M_icit_c+M_nadp_c
		0.0	;	# 44 R_sucAB::M_akg_c+M_coa_c+M_nad_c --> M_co2_c+M_nadh_c+M_succoa_c+M_h_c
		0.0	;	# 45 R_sucCD::M_adp_c+M_pi_c+M_succoa_c --> M_atp_c+M_coa_c+M_succ_c
		0.0	;	# 46 R_sdh::M_q8_c+M_succ_c --> M_fum_c+M_q8h2_c
		0.0	;	# 47 R_frd::M_fum_c+M_mql8_c --> M_mqn8_c+M_succ_c
		0.0	;	# 48 R_fum::M_fum_c+M_h2o_c --> M_mal_L_c
		0.0	;	# 49 R_fum_reverse::M_mal_L_c --> M_fum_c+M_h2o_c
		0.0	;	# 50 R_mdh::M_mal_L_c+M_nad_c --> M_oaa_c+M_h_c+M_nadh_c
		0.0	;	# 51 R_mdh_reverse::M_oaa_c+M_h_c+M_nadh_c --> M_mal_L_c+M_nad_c
		0.0	;	# 52 R_cyd::2.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+2.0*M_he_c
		0.0	;	# 53 R_cyo::4.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+4.0*M_he_c
		0.0	;	# 54 R_app::2.0*M_h_c+M_mql8_c+0.5*M_o2_c --> M_h2o_c+M_mqn8_c+2.0*M_he_c
		0.0	;	# 55 R_atp::M_adp_c+M_pi_c+4.0*M_he_c --> M_atp_c+4.0*M_h_c+M_h2o_c
		0.0	;	# 56 R_nuo::3.0*M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c+2.0*M_he_c
		0.0	;	# 57 R_pnt1::M_nad_c+M_nadph_c --> M_nadh_c+M_nadp_c
		0.0	;	# 58 R_pnt2::M_nadh_c+M_nadp_c+2.0*M_he_c --> 2.0*M_h_c+M_nad_c+M_nadph_c
		0.0	;	# 59 R_ndh1::M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c
		0.0	;	# 60 R_ndh2::M_h_c+M_mqn8_c+M_nadh_c --> M_mql8_c+M_nad_c
		0.0	;	# 61 R_ppa::M_ppi_c+M_h2o_c --> 2.0*M_pi_c
		0.0	;	# 62 R_aceA::M_icit_c --> M_glx_c+M_succ_c
		0.0	;	# 63 R_aceB::M_accoa_c+M_glx_c+M_h2o_c --> M_coa_c+M_mal_L_c
		0.0	;	# 64 R_maeA::M_mal_L_c+M_nad_c --> M_co2_c+M_nadh_c+M_pyr_c+M_h_c
		0.0	;	# 65 R_maeB::M_mal_L_c+M_nadp_c --> M_co2_c+M_nadph_c+M_pyr_c+M_h_c
		0.0	;	# 66 R_pta::M_accoa_c+M_pi_c --> M_actp_c+M_coa_c
		0.0	;	# 67 R_pta_reverse::M_actp_c+M_coa_c --> M_accoa_c+M_pi_c
		0.0	;	# 68 R_ackA::M_actp_c+M_adp_c --> M_ac_c+M_atp_c
		0.0	;	# 69 R_ackA_reverse::M_ac_c+M_atp_c --> M_actp_c+M_adp_c
		0.0	;	# 70 R_acs::M_ac_c+M_atp_c+M_coa_c --> M_accoa_c+M_amp_c+M_ppi_c
		0.0	;	# 71 R_adhE::M_accoa_c+2.0*M_h_c+2.0*M_nadh_c --> M_coa_c+M_etoh_c+2.0*M_nad_c
		0.0	;	# 72 R_adhE_reverse::M_coa_c+M_etoh_c+2.0*M_nad_c --> M_accoa_c+2.0*M_h_c+2.0*M_nadh_c
		0.0	;	# 73 R_ldh::M_pyr_c+M_nadh_c+M_h_c --> M_lac_D_c+M_nad_c
		0.0	;	# 74 R_ldh_reverse::M_lac_D_c+M_nad_c --> M_pyr_c+M_nadh_c+M_h_c
		0.0	;	# 75 R_pflAB::M_coa_c+M_pyr_c --> M_accoa_c+M_for_c
		0.0	;	# 76 R_alaAC::M_pyr_c+M_glu_L_c --> M_ala_L_c+M_akg_c
		0.0	;	# 77 R_alaAC_reverse::M_ala_L_c+M_akg_c --> M_pyr_c+M_glu_L_c
		0.0	;	# 78 R_arg::M_accoa_c+2.0*M_glu_L_c+3.0*M_atp_c+M_nadph_c+M_h_c+M_h2o_c+M_nh3_c+M_co2_c+M_asp_L_c --> M_coa_c+2.0*M_adp_c+2.0*M_pi_c+M_nadp_c+M_akg_c+M_ac_c+M_amp_c+M_ppi_c+M_fum_c+M_arg_L_c
		0.0	;	# 79 R_aspC::M_glu_L_c+M_oaa_c --> M_asp_L_c+M_akg_c
		0.0	;	# 80 R_asnB::M_asp_L_c+M_gln_L_c+M_h2o_c+M_atp_c --> M_asn_L_c+M_glu_L_c+M_ppi_c+M_amp_c
		0.0	;	# 81 R_asnA::M_asp_L_c+M_atp_c+M_nh3_c --> M_asn_L_c+M_ppi_c+M_amp_c
		0.0	;	# 82 R_cysEMK::M_ser_L_c+M_accoa_c+M_h2s_c --> M_cys_L_c+M_coa_c+M_ac_c
		0.0	;	# 83 R_gltBD::M_gln_L_c+M_akg_c+M_nadph_c+M_h_c --> 2.0*M_glu_L_c+M_nadp_c
		0.0	;	# 84 R_gdhA::M_akg_c+M_nadph_c+M_nh3_c+M_h_c --> M_glu_L_c+M_h2o_c+M_nadp_c
		0.0	;	# 85 R_gdhA_reverse::M_glu_L_c+M_h2o_c+M_nadp_c --> M_akg_c+M_nadph_c+M_nh3_c+M_h_c
		0.0	;	# 86 R_glnA::M_glu_L_c+M_atp_c+M_nh3_c --> M_gln_L_c+M_adp_c+M_pi_c
		0.0	;	# 87 R_glyA::M_ser_L_c+M_thf_c --> M_gly_L_c+M_h2o_c+M_mlthf_c
		0.0	;	# 88 R_his::M_gln_L_c+M_r5p_c+2.0*M_atp_c+2.0*M_nad_c+3.0*M_h2o_c --> M_his_L_c+M_akg_c+M_aicar_c+2.0*M_nadh_c+M_amp_c+M_pi_c+2.0*M_ppi_c+2.0*M_h_c
		0.0	;	# 89 R_ile::M_thr_L_c+M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c --> M_ile_L_c+M_h2o_c+M_nh3_c+M_co2_c+M_nadp_c+M_akg_c
		0.0	;	# 90 R_leu::2.0*M_pyr_c+M_glu_L_c+M_nad_c+M_nadph_c+M_accoa_c --> M_leu_L_c+2.0*M_co2_c+M_nadp_c+M_coa_c+M_nadh_c+M_akg_c
		0.0	;	# 91 R_lys::M_asp_L_c+M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_pyr_c+M_succoa_c+M_glu_L_c --> M_lys_L_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_coa_c+M_akg_c+M_succ_c+M_co2_c
		0.0	;	# 92 R_met::M_asp_L_c+M_cys_L_c+M_succoa_c+M_atp_c+2.0*M_nadph_c+M_5mthf_c+M_h2o_c+2.0*M_h_c --> M_met_L_c+M_coa_c+M_succ_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_thf_c+M_nh3_c+M_pyr_c
		0.0	;	# 93 R_phe::M_chor_c+M_glu_L_c --> M_phe_L_c+M_co2_c+M_h2o_c+M_akg_c
		0.0	;	# 94 R_pro::M_glu_L_c+M_atp_c+2.0*M_h_c+2.0*M_nadph_c --> M_pro_L_c+M_adp_c+2.0*M_nadp_c+M_pi_c+M_h2o_c
		0.0	;	# 95 R_serABC::M_3pg_c+M_nad_c+M_glu_L_c+M_h2o_c --> M_ser_L_c+M_nadh_c+M_h_c+M_akg_c+M_pi_c
		0.0	;	# 96 R_thr::M_asp_L_c+2.0*M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_h2o_c --> M_thr_L_c+2.0*M_adp_c+2.0*M_pi_c+2.0*M_nadp_c
		0.0	;	# 97 R_trp::M_chor_c+M_gln_L_c+M_ser_L_c+M_r5p_c+M_atp_c --> M_trp_L_c+M_glu_L_c+M_pyr_c+M_ppi_c+2.0*M_h2o_c+M_co2_c+M_g3p_c+M_amp_c
		0.0	;	# 98 R_tyr::M_chor_c+M_glu_L_c+M_nad_c --> M_tyr_L_c+M_akg_c+M_nadh_c+M_co2_c+M_h_c
		0.0	;	# 99 R_val::2.0*M_pyr_c+M_h_c+M_nadph_c+M_glu_L_c --> M_val_L_c+M_co2_c+M_nadp_c+M_h2o_c+M_akg_c
		0.0	;	# 100 R_arg_deg::M_arg_L_c+4.0*M_h2o_c+M_nad_c+M_akg_c+M_succoa_c --> M_h_c+M_co2_c+2.0*M_glu_L_c+2.0*M_nh3_c+M_nadh_c+M_succ_c+M_coa_c
		0.0	;	# 101 R_asp_deg::M_asp_L_c --> M_fum_c+M_nh3_c
		0.0	;	# 102 R_asn_deg::M_asn_L_c+M_amp_c+M_ppi_c --> M_nh3_c+M_asp_L_c+M_atp_c
		0.0	;	# 103 R_gly_deg::M_gly_L_c+M_accoa_c+M_o2_c+M_h2o_c --> M_coa_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c
		0.0	;	# 104 R_mglx_deg::M_mglx_c+M_nad_c+M_h2o_c --> M_pyr_c+M_nadh_c+M_h_c
		0.0	;	# 105 R_ser_deg::M_ser_L_c --> M_nh3_c+M_pyr_c
		0.0	;	# 106 R_pro_deg::M_pro_L_c+M_q8_c+2.0*M_h2o_c+M_nad_c --> M_h_c+M_q8h2_c+M_nadh_c+M_glu_L_c
		0.0	;	# 107 R_thr_deg1::M_thr_L_c+M_nad_c+M_coa_c --> M_nadh_c+M_h_c+M_accoa_c+M_gly_L_c
		0.0	;	# 108 R_thr_deg2::M_thr_L_c+M_nad_c+M_o2_c+M_h2o_c --> M_nadh_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c+M_h_c
		0.0	;	# 109 R_thr_deg3::M_thr_L_c+M_pi_c+M_adp_c --> M_nh3_c+M_for_c+M_atp_c+M_prop_c
		0.0	;	# 110 R_trp_deg::M_trp_L_c+M_h2o_c --> M_indole_c+M_nh3_c+M_pyr_c
		0.0	;	# 111 R_cys_deg::M_cys_L_c+M_h2o_c --> M_h2s_c+M_nh3_c+M_pyr_c
		0.0	;	# 112 R_lys_deg::M_lys_L_c --> M_co2_c+M_cadav_c
		0.0	;	# 113 R_gln_deg::M_gln_L_c+M_h2o_c --> M_nh3_c+M_glu_L_c
		0.0	;	# 114 R_glu_deg::M_glu_L_c --> M_co2_c+M_gaba_c
		0.0	;	# 115 R_gaba_deg1::M_gaba_c+M_akg_c+M_h2o_c+M_nad_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadh_c
		0.0	;	# 116 R_gaba_deg2::M_gaba_c+M_akg_c+M_h2o_c+M_nadp_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadph_c
		0.0	;	# 117 R_chor::M_e4p_c+2.0*M_pep_c+M_nadph_c+M_atp_c+M_h_c --> M_chor_c+M_nadp_c+M_adp_c+4.0*M_pi_c
		0.0	;	# 118 R_fol_e::M_gtp_c+4.0*M_h2o_c --> M_for_c+3.0*M_pi_c+M_glycoA_c+M_78mdp_c
		0.0	;	# 119 R_fol_1::M_chor_c+M_gln_L_c --> M_4adochor_c+M_glu_L_c
		0.0	;	# 120 R_fol_2a::M_4adochor_c --> M_4abz_c+M_pyr_c
		0.0	;	# 121 R_fol_2b::M_4abz_c+M_78mdp_c --> M_78dhf_c+M_h2o_c
		0.0	;	# 122 R_fol_3::M_78dhf_c+M_atp_c+M_glu_L_c --> M_adp_c+M_pi_c+M_dhf_c
		0.0	;	# 123 R_fol_4::M_dhf_c+M_nadph_c+M_h_c --> M_thf_c+M_nadp_c
		0.0	;	# 124 R_gly_fol::M_gly_L_c+M_thf_c+M_nad_c --> M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c
		0.0	;	# 125 R_gly_fol_reverse::M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c --> M_gly_L_c+M_thf_c+M_nad_c
		0.0	;	# 126 R_mthfd::M_mlthf_c+M_nadp_c --> M_methf_c+M_nadph_c
		0.0	;	# 127 R_mthfd_reverse::M_methf_c+M_nadph_c --> M_mlthf_c+M_nadp_c
		0.0	;	# 128 R_mthfc::M_h2o_c+M_methf_c --> M_10fthf_c+M_h_c
		0.0	;	# 129 R_mthfc_reverse::M_10fthf_c+M_h_c --> M_h2o_c+M_methf_c
		0.0	;	# 130 R_mthfr2a::M_mlthf_c+M_h_c+M_nadh_c --> M_5mthf_c+M_nad_c
		0.0	;	# 131 R_mthfr2b::M_mlthf_c+M_h_c+M_nadph_c --> M_5mthf_c+M_nadp_c
		0.0	;	# 132 R_prpp_syn::M_r5p_c+M_atp_c --> M_prpp_c+M_amp_c
		0.0	;	# 133 R_or_syn_1::2.0*M_atp_c+M_gln_L_c+M_hco3_c+M_h2o_c+M_h_c --> 2.0*M_adp_c+M_glu_L_c+M_pi_c+M_clasp_c
		0.0	;	# 134 R_or_syn_2::M_clasp_c+M_asp_L_c+M_q8_c --> M_or_c+M_q8h2_c+M_h2o_c+M_pi_c
		0.0	;	# 135 R_omp_syn::M_prpp_c+M_or_c --> M_omp_c+M_ppi_c
		0.0	;	# 136 R_ump_syn::M_omp_c --> M_ump_c+M_co2_c
		0.0	;	# 137 R_ctp_1::M_utp_c+M_atp_c+M_nh3_c --> M_ctp_c+M_adp_c+M_pi_c
		0.0	;	# 138 R_ctp_2::M_utp_c+M_gln_L_c+M_atp_c+M_h2o_c --> M_ctp_c+M_glu_L_c+M_adp_c+M_pi_c
		0.0	;	# 139 R_A_syn_1::M_gln_L_c+M_prpp_c+M_h2o_c --> M_5pbdra+M_ppi_c+M_glu_L_c
		0.0	;	# 140 R_A_syn_2::M_atp_c+M_5pbdra+M_gly_L_c --> M_adp_c+M_pi_c+M_gar_c
		0.0	;	# 141 R_A_syn_3::M_10fthf_c+M_gar_c --> M_thf_c+M_fgar_c
		0.0	;	# 142 R_A_syn_4::M_atp_c+M_fgar_c+M_gln_L_c+M_h2o_c --> M_adp_c+M_pi_c+M_fgam_c+M_glu_L_c
		0.0	;	# 143 R_A_syn_5::M_atp_c+M_fgam_c --> M_adp_c+M_pi_c+M_air_c
		0.0	;	# 144 R_A_syn_6::M_atp_c+M_air_c+M_hco3_c+M_h_c --> M_adp_c+M_pi_c+M_cair_c
		0.0	;	# 145 R_A_syn_7::M_atp_c+M_cair_c+M_asp_L_c --> M_adp_c+M_pi_c+M_saicar_c
		0.0	;	# 146 R_A_syn_8::M_saicar_c --> M_fum_c+M_aicar_c
		0.0	;	# 147 R_A_syn_9::M_aicar_c+M_10fthf_c --> M_thf_c+M_faicar_c
		0.0	;	# 148 R_A_syn_10::M_faicar_c --> M_imp_c+M_h2o_c
		0.0	;	# 149 R_A_syn_12::M_imp_c+M_gtp_c+M_asp_L_c --> M_gdp_c+M_pi_c+M_fum_c+M_amp_c
		0.0	;	# 150 R_xmp_syn::M_imp_c+M_nad_c+M_h2o_c --> M_xmp_c+M_nadh_c+M_h_c
		0.0	;	# 151 R_gmp_syn::M_atp_c+M_xmp_c+M_gln_L_c+M_h2o_c --> M_amp_c+M_ppi_c+M_gmp_c+M_glu_L_c
		0.0	;	# 152 R_atp_amp::M_atp_c+M_h2o_c --> M_amp_c+M_ppi_c
		0.0	;	# 153 R_utp_ump::M_utp_c+M_h2o_c --> M_ump_c+M_ppi_c
		0.0	;	# 154 R_ctp_cmp::M_ctp_c+M_h2o_c --> M_cmp_c+M_ppi_c
		0.0	;	# 155 R_gtp_gmp::M_gtp_c+M_h2o_c --> M_gmp_c+M_ppi_c
		0.0	;	# 156 R_atp_adp::M_atp_c+M_h2o_c --> M_adp_c+M_pi_c
		0.0	;	# 157 R_utp_adp::M_utp_c+M_h2o_c --> M_udp_c+M_pi_c
		0.0	;	# 158 R_ctp_adp::M_ctp_c+M_h2o_c --> M_cdp_c+M_pi_c
		0.0	;	# 159 R_gtp_adp::M_gtp_c+M_h2o_c --> M_gdp_c+M_pi_c
		0.0	;	# 160 R_udp_utp::M_udp_c+M_atp_c --> M_utp_c+M_adp_c
		0.0	;	# 161 R_cdp_ctp::M_cdp_c+M_atp_c --> M_ctp_c+M_adp_c
		0.0	;	# 162 R_gdp_gtp::M_gdp_c+M_atp_c --> M_gtp_c+M_adp_c
		0.0	;	# 163 R_atp_ump::M_atp_c+M_ump_c --> M_adp_c+M_udp_c
		0.0	;	# 164 R_atp_cmp::M_atp_c+M_cmp_c --> M_adp_c+M_cdp_c
		0.0	;	# 165 R_atp_gmp::M_atp_c+M_gmp_c --> M_adp_c+M_gdp_c
		0.0	;	# 166 R_adk_atp::M_amp_c+M_atp_c --> 2.0*M_adp_c
		0.0	;	# 167 transcriptional_initiation_S38::GENE_S38+RNAP --> OPEN_GENE_S38
		0.0	;	# 168 transcription_S38::OPEN_GENE_S38+292.0*M_gtp_c+225.0*M_ctp_c+222.0*M_utp_c+254.0*M_atp_c+993.0*M_h2o_c --> mRNA_S38+GENE_S38+RNAP+993.0*M_ppi_c
		0.0	;	# 169 mRNA_degradation_S38::mRNA_S38 --> 292.0*M_gmp_c+225.0*M_cmp_c+222.0*M_ump_c+254.0*M_amp_c
		0.0	;	# 170 transcriptional_initiation_S28::GENE_S28+RNAP --> OPEN_GENE_S28
		0.0	;	# 171 transcription_S28::OPEN_GENE_S28+181.0*M_gtp_c+147.0*M_ctp_c+191.0*M_utp_c+219.0*M_atp_c+738.0*M_h2o_c --> mRNA_S28+GENE_S28+RNAP+738.0*M_ppi_c
		0.0	;	# 172 mRNA_degradation_S28::mRNA_S28 --> 181.0*M_gmp_c+147.0*M_cmp_c+191.0*M_ump_c+219.0*M_amp_c
		0.0	;	# 173 transcriptional_initiation_S19::GENE_S19+RNAP --> OPEN_GENE_S19
		0.0	;	# 174 transcription_S19::OPEN_GENE_S19+140.0*M_gtp_c+145.0*M_ctp_c+117.0*M_utp_c+120.0*M_atp_c+522.0*M_h2o_c --> mRNA_S19+GENE_S19+RNAP+522.0*M_ppi_c
		0.0	;	# 175 mRNA_degradation_S19::mRNA_S19 --> 140.0*M_gmp_c+145.0*M_cmp_c+117.0*M_ump_c+120.0*M_amp_c
		0.0	;	# 176 transcriptional_initiation_P38::GENE_P38+RNAP --> OPEN_GENE_P38
		0.0	;	# 177 transcription_P38::OPEN_GENE_P38+0.0*M_gtp_c+0.0*M_ctp_c+0.0*M_utp_c+0.0*M_atp_c+0.0*M_h2o_c --> mRNA_P38+GENE_P38+RNAP+0.0*M_ppi_c
		0.0	;	# 178 mRNA_degradation_P38::mRNA_P38 --> 0.0*M_gmp_c+0.0*M_cmp_c+0.0*M_ump_c+0.0*M_amp_c
		0.0	;	# 179 transcriptional_initiation_P28::GENE_P28+RNAP --> OPEN_GENE_P28
		0.0	;	# 180 transcription_P28::OPEN_GENE_P28+15.0*M_gtp_c+11.0*M_ctp_c+17.0*M_utp_c+12.0*M_atp_c+55.0*M_h2o_c --> mRNA_P28+GENE_P28+RNAP+55.0*M_ppi_c
		0.0	;	# 181 mRNA_degradation_P28::mRNA_P28 --> 15.0*M_gmp_c+11.0*M_cmp_c+17.0*M_ump_c+12.0*M_amp_c
		0.0	;	# 182 transcriptional_initiation_P19::GENE_P19+RNAP --> OPEN_GENE_P19
		0.0	;	# 183 transcription_P19::OPEN_GENE_P19+11.0*M_gtp_c+9.0*M_ctp_c+23.0*M_utp_c+14.0*M_atp_c+57.0*M_h2o_c --> mRNA_P19+GENE_P19+RNAP+57.0*M_ppi_c
		0.0	;	# 184 mRNA_degradation_P19::mRNA_P19 --> 11.0*M_gmp_c+9.0*M_cmp_c+23.0*M_ump_c+14.0*M_amp_c
		0.0	;	# 185 transcriptional_initiation_LACI::GENE_LACI+RNAP --> OPEN_GENE_LACI
		0.0	;	# 186 transcription_LACI::OPEN_GENE_LACI+314.0*M_gtp_c+296.0*M_ctp_c+234.0*M_utp_c+239.0*M_atp_c+1083.0*M_h2o_c --> mRNA_LACI+GENE_LACI+RNAP+1083.0*M_ppi_c
		0.0	;	# 187 mRNA_degradation_LACI::mRNA_LACI --> 314.0*M_gmp_c+296.0*M_cmp_c+234.0*M_ump_c+239.0*M_amp_c
		0.0	;	# 188 transcriptional_initiation_GLUCAGON::GENE_GLUCAGON+RNAP --> OPEN_GENE_GLUCAGON
		0.0	;	# 189 transcription_GLUCAGON::OPEN_GENE_GLUCAGON+136.0*M_gtp_c+116.0*M_ctp_c+131.0*M_utp_c+160.0*M_atp_c+543.0*M_h2o_c --> mRNA_GLUCAGON+GENE_GLUCAGON+RNAP+543.0*M_ppi_c
		0.0	;	# 190 mRNA_degradation_GLUCAGON::mRNA_GLUCAGON --> 136.0*M_gmp_c+116.0*M_cmp_c+131.0*M_ump_c+160.0*M_amp_c
		0.0	;	# 191 transcriptional_initiation_ENZYME::GENE_ENZYME+RNAP --> OPEN_GENE_ENZYME
		0.0	;	# 192 transcription_ENZYME::OPEN_GENE_ENZYME+1072.0*M_gtp_c+1049.0*M_ctp_c+1298.0*M_utp_c+1414.0*M_atp_c+4833.0*M_h2o_c --> mRNA_ENZYME+GENE_ENZYME+RNAP+4833.0*M_ppi_c
		0.0	;	# 193 mRNA_degradation_ENZYME::mRNA_ENZYME --> 1072.0*M_gmp_c+1049.0*M_cmp_c+1298.0*M_ump_c+1414.0*M_amp_c
		0.0	;	# 194 transcriptional_initiation_CAP::GENE_CAP+RNAP --> OPEN_GENE_CAP
		0.0	;	# 195 transcription_CAP::OPEN_GENE_CAP+156.0*M_gtp_c+164.0*M_ctp_c+143.0*M_utp_c+170.0*M_atp_c+633.0*M_h2o_c --> mRNA_CAP+GENE_CAP+RNAP+633.0*M_ppi_c
		0.0	;	# 196 mRNA_degradation_CAP::mRNA_CAP --> 156.0*M_gmp_c+164.0*M_cmp_c+143.0*M_ump_c+170.0*M_amp_c
		0.0	;	# 197 transcriptional_initiation_Insulin::GENE_Insulin+RNAP --> OPEN_GENE_Insulin
		0.0	;	# 198 transcription_Insulin::OPEN_GENE_Insulin+514.0*M_gtp_c+522.0*M_ctp_c+314.0*M_utp_c+272.0*M_atp_c+1622.0*M_h2o_c --> mRNA_Insulin+GENE_Insulin+RNAP+1622.0*M_ppi_c
		0.0	;	# 199 mRNA_degradation_Insulin::mRNA_Insulin --> 514.0*M_gmp_c+522.0*M_cmp_c+314.0*M_ump_c+272.0*M_amp_c
		0.0	;	# 200 translation_initiation_S38::mRNA_S38+RIBOSOME --> RIBOSOME_START_S38
		0.0	;	# 201 translation_S38::RIBOSOME_START_S38+660.0*M_gtp_c+660.0*M_h2o_c+24.0*M_ala_L_c_tRNA+34.0*M_arg_L_c_tRNA+13.0*M_asn_L_c_tRNA+23.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+41.0*M_glu_L_c_tRNA+15.0*M_gln_L_c_tRNA+19.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+19.0*M_ile_L_c_tRNA+44.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+9.0*M_phe_L_c_tRNA+8.0*M_pro_L_c_tRNA+13.0*M_ser_L_c_tRNA+17.0*M_thr_L_c_tRNA+3.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+20.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S38+PROTEIN_S38+660.0*M_gdp_c+660.0*M_pi_c+330.0*tRNA
		0.0	;	# 202 tRNA_charging_M_ala_L_c_S38::24.0*M_ala_L_c+24.0*M_atp_c+24.0*tRNA+24.0*M_h2o_c --> 24.0*M_ala_L_c_tRNA+24.0*M_amp_c+24.0*M_ppi_c
		0.0	;	# 203 tRNA_charging_M_arg_L_c_S38::34.0*M_arg_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_arg_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0.0	;	# 204 tRNA_charging_M_asn_L_c_S38::13.0*M_asn_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_asn_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 205 tRNA_charging_M_asp_L_c_S38::23.0*M_asp_L_c+23.0*M_atp_c+23.0*tRNA+23.0*M_h2o_c --> 23.0*M_asp_L_c_tRNA+23.0*M_amp_c+23.0*M_ppi_c
		0.0	;	# 206 tRNA_charging_M_cys_L_c_S38::0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c
		0.0	;	# 207 tRNA_charging_M_glu_L_c_S38::41.0*M_glu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_glu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c
		0.0	;	# 208 tRNA_charging_M_gln_L_c_S38::15.0*M_gln_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_gln_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0.0	;	# 209 tRNA_charging_M_gly_L_c_S38::19.0*M_gly_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_gly_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0.0	;	# 210 tRNA_charging_M_his_L_c_S38::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 211 tRNA_charging_M_ile_L_c_S38::19.0*M_ile_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ile_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0.0	;	# 212 tRNA_charging_M_leu_L_c_S38::44.0*M_leu_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_leu_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c
		0.0	;	# 213 tRNA_charging_M_lys_L_c_S38::12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0.0	;	# 214 tRNA_charging_M_met_L_c_S38::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 215 tRNA_charging_M_phe_L_c_S38::9.0*M_phe_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_phe_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 216 tRNA_charging_M_pro_L_c_S38::8.0*M_pro_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_pro_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 217 tRNA_charging_M_ser_L_c_S38::13.0*M_ser_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ser_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 218 tRNA_charging_M_thr_L_c_S38::17.0*M_thr_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_thr_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0.0	;	# 219 tRNA_charging_M_trp_L_c_S38::3.0*M_trp_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_trp_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0.0	;	# 220 tRNA_charging_M_tyr_L_c_S38::7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 221 tRNA_charging_M_val_L_c_S38::20.0*M_val_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_val_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0.0	;	# 222 translation_initiation_S28::mRNA_S28+RIBOSOME --> RIBOSOME_START_S28
		0.0	;	# 223 translation_S28::RIBOSOME_START_S28+490.0*M_gtp_c+490.0*M_h2o_c+19.0*M_ala_L_c_tRNA+13.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+20.0*M_asp_L_c_tRNA+M_cys_L_c_tRNA+18.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+25.0*M_leu_L_c_tRNA+13.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+7.0*M_pro_L_c_tRNA+21.0*M_ser_L_c_tRNA+7.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+18.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S28+PROTEIN_S28+490.0*M_gdp_c+490.0*M_pi_c+245.0*tRNA
		0.0	;	# 224 tRNA_charging_M_ala_L_c_S28::19.0*M_ala_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ala_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0.0	;	# 225 tRNA_charging_M_arg_L_c_S28::13.0*M_arg_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_arg_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 226 tRNA_charging_M_asn_L_c_S28::11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 227 tRNA_charging_M_asp_L_c_S28::20.0*M_asp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_asp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0.0	;	# 228 tRNA_charging_M_cys_L_c_S28::M_cys_L_c+M_atp_c+tRNA+M_h2o_c --> M_cys_L_c_tRNA+M_amp_c+M_ppi_c
		0.0	;	# 229 tRNA_charging_M_glu_L_c_S28::18.0*M_glu_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_glu_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 230 tRNA_charging_M_gln_L_c_S28::14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0.0	;	# 231 tRNA_charging_M_gly_L_c_S28::16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 232 tRNA_charging_M_his_L_c_S28::6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 233 tRNA_charging_M_ile_L_c_S28::17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0.0	;	# 234 tRNA_charging_M_leu_L_c_S28::25.0*M_leu_L_c+25.0*M_atp_c+25.0*tRNA+25.0*M_h2o_c --> 25.0*M_leu_L_c_tRNA+25.0*M_amp_c+25.0*M_ppi_c
		0.0	;	# 235 tRNA_charging_M_lys_L_c_S28::13.0*M_lys_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_lys_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 236 tRNA_charging_M_met_L_c_S28::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 237 tRNA_charging_M_phe_L_c_S28::5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 238 tRNA_charging_M_pro_L_c_S28::7.0*M_pro_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_pro_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 239 tRNA_charging_M_ser_L_c_S28::21.0*M_ser_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_ser_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c
		0.0	;	# 240 tRNA_charging_M_thr_L_c_S28::7.0*M_thr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_thr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 241 tRNA_charging_M_trp_L_c_S28::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 242 tRNA_charging_M_tyr_L_c_S28::7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 243 tRNA_charging_M_val_L_c_S28::18.0*M_val_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_val_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 244 translation_initiation_S19::mRNA_S19+RIBOSOME --> RIBOSOME_START_S19
		0.0	;	# 245 translation_S19::RIBOSOME_START_S19+346.0*M_gtp_c+346.0*M_h2o_c+14.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+2.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+2.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+5.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+5.0*M_ile_L_c_tRNA+28.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+7.0*M_phe_L_c_tRNA+4.0*M_pro_L_c_tRNA+16.0*M_ser_L_c_tRNA+13.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S19+PROTEIN_S19+346.0*M_gdp_c+346.0*M_pi_c+173.0*tRNA
		0.0	;	# 246 tRNA_charging_M_ala_L_c_S19::14.0*M_ala_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_ala_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0.0	;	# 247 tRNA_charging_M_arg_L_c_S19::11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 248 tRNA_charging_M_asn_L_c_S19::2.0*M_asn_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_asn_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 249 tRNA_charging_M_asp_L_c_S19::10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0.0	;	# 250 tRNA_charging_M_cys_L_c_S19::2.0*M_cys_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_cys_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 251 tRNA_charging_M_glu_L_c_S19::13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 252 tRNA_charging_M_gln_L_c_S19::5.0*M_gln_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_gln_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 253 tRNA_charging_M_gly_L_c_S19::9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 254 tRNA_charging_M_his_L_c_S19::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 255 tRNA_charging_M_ile_L_c_S19::5.0*M_ile_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_ile_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 256 tRNA_charging_M_leu_L_c_S19::28.0*M_leu_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_leu_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0.0	;	# 257 tRNA_charging_M_lys_L_c_S19::9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 258 tRNA_charging_M_met_L_c_S19::6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 259 tRNA_charging_M_phe_L_c_S19::7.0*M_phe_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_phe_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 260 tRNA_charging_M_pro_L_c_S19::4.0*M_pro_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_pro_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 261 tRNA_charging_M_ser_L_c_S19::16.0*M_ser_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_ser_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 262 tRNA_charging_M_thr_L_c_S19::13.0*M_thr_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_thr_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 263 tRNA_charging_M_trp_L_c_S19::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 264 tRNA_charging_M_tyr_L_c_S19::5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 265 tRNA_charging_M_val_L_c_S19::8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 266 translation_initiation_LACI::mRNA_LACI+RIBOSOME --> RIBOSOME_START_LACI
		0.0	;	# 267 translation_LACI::RIBOSOME_START_LACI+720.0*M_gtp_c+720.0*M_h2o_c+45.0*M_ala_L_c_tRNA+19.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+17.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+15.0*M_glu_L_c_tRNA+28.0*M_gln_L_c_tRNA+22.0*M_gly_L_c_tRNA+7.0*M_his_L_c_tRNA+18.0*M_ile_L_c_tRNA+41.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+10.0*M_met_L_c_tRNA+4.0*M_phe_L_c_tRNA+14.0*M_pro_L_c_tRNA+32.0*M_ser_L_c_tRNA+18.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+8.0*M_tyr_L_c_tRNA+34.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_LACI+PROTEIN_LACI+720.0*M_gdp_c+720.0*M_pi_c+360.0*tRNA
		0.0	;	# 268 tRNA_charging_M_ala_L_c_LACI::45.0*M_ala_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_ala_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c
		0.0	;	# 269 tRNA_charging_M_arg_L_c_LACI::19.0*M_arg_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_arg_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c
		0.0	;	# 270 tRNA_charging_M_asn_L_c_LACI::11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 271 tRNA_charging_M_asp_L_c_LACI::17.0*M_asp_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_asp_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0.0	;	# 272 tRNA_charging_M_cys_L_c_LACI::3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0.0	;	# 273 tRNA_charging_M_glu_L_c_LACI::15.0*M_glu_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_glu_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0.0	;	# 274 tRNA_charging_M_gln_L_c_LACI::28.0*M_gln_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_gln_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0.0	;	# 275 tRNA_charging_M_gly_L_c_LACI::22.0*M_gly_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_gly_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0.0	;	# 276 tRNA_charging_M_his_L_c_LACI::7.0*M_his_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_his_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 277 tRNA_charging_M_ile_L_c_LACI::18.0*M_ile_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_ile_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 278 tRNA_charging_M_leu_L_c_LACI::41.0*M_leu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_leu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c
		0.0	;	# 279 tRNA_charging_M_lys_L_c_LACI::12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0.0	;	# 280 tRNA_charging_M_met_L_c_LACI::10.0*M_met_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_met_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0.0	;	# 281 tRNA_charging_M_phe_L_c_LACI::4.0*M_phe_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_phe_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 282 tRNA_charging_M_pro_L_c_LACI::14.0*M_pro_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_pro_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0.0	;	# 283 tRNA_charging_M_ser_L_c_LACI::32.0*M_ser_L_c+32.0*M_atp_c+32.0*tRNA+32.0*M_h2o_c --> 32.0*M_ser_L_c_tRNA+32.0*M_amp_c+32.0*M_ppi_c
		0.0	;	# 284 tRNA_charging_M_thr_L_c_LACI::18.0*M_thr_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_thr_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 285 tRNA_charging_M_trp_L_c_LACI::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 286 tRNA_charging_M_tyr_L_c_LACI::8.0*M_tyr_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_tyr_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 287 tRNA_charging_M_val_L_c_LACI::34.0*M_val_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_val_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0.0	;	# 288 translation_initiation_GLUCAGON::mRNA_GLUCAGON+RIBOSOME --> RIBOSOME_START_GLUCAGON
		0.0	;	# 289 translation_GLUCAGON::RIBOSOME_START_GLUCAGON+360.0*M_gtp_c+360.0*M_h2o_c+13.0*M_ala_L_c_tRNA+16.0*M_arg_L_c_tRNA+8.0*M_asn_L_c_tRNA+16.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+10.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+8.0*M_ile_L_c_tRNA+12.0*M_leu_L_c_tRNA+10.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+3.0*M_pro_L_c_tRNA+17.0*M_ser_L_c_tRNA+9.0*M_thr_L_c_tRNA+4.0*M_trp_L_c_tRNA+4.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_GLUCAGON+PROTEIN_GLUCAGON+360.0*M_gdp_c+360.0*M_pi_c+180.0*tRNA
		0.0	;	# 290 tRNA_charging_M_ala_L_c_GLUCAGON::13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 291 tRNA_charging_M_arg_L_c_GLUCAGON::16.0*M_arg_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_arg_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 292 tRNA_charging_M_asn_L_c_GLUCAGON::8.0*M_asn_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asn_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 293 tRNA_charging_M_asp_L_c_GLUCAGON::16.0*M_asp_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_asp_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 294 tRNA_charging_M_cys_L_c_GLUCAGON::0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c
		0.0	;	# 295 tRNA_charging_M_glu_L_c_GLUCAGON::13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 296 tRNA_charging_M_gln_L_c_GLUCAGON::10.0*M_gln_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_gln_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0.0	;	# 297 tRNA_charging_M_gly_L_c_GLUCAGON::9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 298 tRNA_charging_M_his_L_c_GLUCAGON::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 299 tRNA_charging_M_ile_L_c_GLUCAGON::8.0*M_ile_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_ile_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 300 tRNA_charging_M_leu_L_c_GLUCAGON::12.0*M_leu_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_leu_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0.0	;	# 301 tRNA_charging_M_lys_L_c_GLUCAGON::10.0*M_lys_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_lys_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0.0	;	# 302 tRNA_charging_M_met_L_c_GLUCAGON::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 303 tRNA_charging_M_phe_L_c_GLUCAGON::11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 304 tRNA_charging_M_pro_L_c_GLUCAGON::3.0*M_pro_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_pro_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0.0	;	# 305 tRNA_charging_M_ser_L_c_GLUCAGON::17.0*M_ser_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ser_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0.0	;	# 306 tRNA_charging_M_thr_L_c_GLUCAGON::9.0*M_thr_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_thr_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 307 tRNA_charging_M_trp_L_c_GLUCAGON::4.0*M_trp_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_trp_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 308 tRNA_charging_M_tyr_L_c_GLUCAGON::4.0*M_tyr_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_tyr_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c
		0.0	;	# 309 tRNA_charging_M_val_L_c_GLUCAGON::8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 310 translation_initiation_ENZYME::mRNA_ENZYME+RIBOSOME --> RIBOSOME_START_ENZYME
		0.0	;	# 311 translation_ENZYME::RIBOSOME_START_ENZYME+3220.0*M_gtp_c+3220.0*M_h2o_c+81.0*M_ala_L_c_tRNA+67.0*M_arg_L_c_tRNA+81.0*M_asn_L_c_tRNA+61.0*M_asp_L_c_tRNA+45.0*M_cys_L_c_tRNA+119.0*M_glu_L_c_tRNA+72.0*M_gln_L_c_tRNA+72.0*M_gly_L_c_tRNA+52.0*M_his_L_c_tRNA+116.0*M_ile_L_c_tRNA+192.0*M_leu_L_c_tRNA+109.0*M_lys_L_c_tRNA+65.0*M_met_L_c_tRNA+91.0*M_phe_L_c_tRNA+52.0*M_pro_L_c_tRNA+93.0*M_ser_L_c_tRNA+67.0*M_thr_L_c_tRNA+20.0*M_trp_L_c_tRNA+69.0*M_tyr_L_c_tRNA+86.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_ENZYME+PROTEIN_ENZYME+3220.0*M_gdp_c+3220.0*M_pi_c+1610.0*tRNA
		0.0	;	# 312 tRNA_charging_M_ala_L_c_ENZYME::81.0*M_ala_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_ala_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c
		0.0	;	# 313 tRNA_charging_M_arg_L_c_ENZYME::67.0*M_arg_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_arg_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c
		0.0	;	# 314 tRNA_charging_M_asn_L_c_ENZYME::81.0*M_asn_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_asn_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c
		0.0	;	# 315 tRNA_charging_M_asp_L_c_ENZYME::61.0*M_asp_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_asp_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c
		0.0	;	# 316 tRNA_charging_M_cys_L_c_ENZYME::45.0*M_cys_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_cys_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c
		0.0	;	# 317 tRNA_charging_M_glu_L_c_ENZYME::119.0*M_glu_L_c+119.0*M_atp_c+119.0*tRNA+119.0*M_h2o_c --> 119.0*M_glu_L_c_tRNA+119.0*M_amp_c+119.0*M_ppi_c
		0.0	;	# 318 tRNA_charging_M_gln_L_c_ENZYME::72.0*M_gln_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gln_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c
		0.0	;	# 319 tRNA_charging_M_gly_L_c_ENZYME::72.0*M_gly_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gly_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c
		0.0	;	# 320 tRNA_charging_M_his_L_c_ENZYME::52.0*M_his_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_his_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0.0	;	# 321 tRNA_charging_M_ile_L_c_ENZYME::116.0*M_ile_L_c+116.0*M_atp_c+116.0*tRNA+116.0*M_h2o_c --> 116.0*M_ile_L_c_tRNA+116.0*M_amp_c+116.0*M_ppi_c
		0.0	;	# 322 tRNA_charging_M_leu_L_c_ENZYME::192.0*M_leu_L_c+192.0*M_atp_c+192.0*tRNA+192.0*M_h2o_c --> 192.0*M_leu_L_c_tRNA+192.0*M_amp_c+192.0*M_ppi_c
		0.0	;	# 323 tRNA_charging_M_lys_L_c_ENZYME::109.0*M_lys_L_c+109.0*M_atp_c+109.0*tRNA+109.0*M_h2o_c --> 109.0*M_lys_L_c_tRNA+109.0*M_amp_c+109.0*M_ppi_c
		0.0	;	# 324 tRNA_charging_M_met_L_c_ENZYME::65.0*M_met_L_c+65.0*M_atp_c+65.0*tRNA+65.0*M_h2o_c --> 65.0*M_met_L_c_tRNA+65.0*M_amp_c+65.0*M_ppi_c
		0.0	;	# 325 tRNA_charging_M_phe_L_c_ENZYME::91.0*M_phe_L_c+91.0*M_atp_c+91.0*tRNA+91.0*M_h2o_c --> 91.0*M_phe_L_c_tRNA+91.0*M_amp_c+91.0*M_ppi_c
		0.0	;	# 326 tRNA_charging_M_pro_L_c_ENZYME::52.0*M_pro_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_pro_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0.0	;	# 327 tRNA_charging_M_ser_L_c_ENZYME::93.0*M_ser_L_c+93.0*M_atp_c+93.0*tRNA+93.0*M_h2o_c --> 93.0*M_ser_L_c_tRNA+93.0*M_amp_c+93.0*M_ppi_c
		0.0	;	# 328 tRNA_charging_M_thr_L_c_ENZYME::67.0*M_thr_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_thr_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c
		0.0	;	# 329 tRNA_charging_M_trp_L_c_ENZYME::20.0*M_trp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_trp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0.0	;	# 330 tRNA_charging_M_tyr_L_c_ENZYME::69.0*M_tyr_L_c+69.0*M_atp_c+69.0*tRNA+69.0*M_h2o_c --> 69.0*M_tyr_L_c_tRNA+69.0*M_amp_c+69.0*M_ppi_c
		0.0	;	# 331 tRNA_charging_M_val_L_c_ENZYME::86.0*M_val_L_c+86.0*M_atp_c+86.0*tRNA+86.0*M_h2o_c --> 86.0*M_val_L_c_tRNA+86.0*M_amp_c+86.0*M_ppi_c
		0.0	;	# 332 translation_initiation_CAP::mRNA_CAP+RIBOSOME --> RIBOSOME_START_CAP
		0.0	;	# 333 translation_CAP::RIBOSOME_START_CAP+420.0*M_gtp_c+420.0*M_h2o_c+13.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+5.0*M_asn_L_c_tRNA+8.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+16.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+22.0*M_leu_L_c_tRNA+15.0*M_lys_L_c_tRNA+7.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+6.0*M_pro_L_c_tRNA+12.0*M_ser_L_c_tRNA+12.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+6.0*M_tyr_L_c_tRNA+14.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_CAP+PROTEIN_CAP+420.0*M_gdp_c+420.0*M_pi_c+210.0*tRNA
		0.0	;	# 334 tRNA_charging_M_ala_L_c_CAP::13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c
		0.0	;	# 335 tRNA_charging_M_arg_L_c_CAP::11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 336 tRNA_charging_M_asn_L_c_CAP::5.0*M_asn_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_asn_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 337 tRNA_charging_M_asp_L_c_CAP::8.0*M_asp_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asp_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c
		0.0	;	# 338 tRNA_charging_M_cys_L_c_CAP::3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0.0	;	# 339 tRNA_charging_M_glu_L_c_CAP::16.0*M_glu_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_glu_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 340 tRNA_charging_M_gln_L_c_CAP::14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0.0	;	# 341 tRNA_charging_M_gly_L_c_CAP::16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c
		0.0	;	# 342 tRNA_charging_M_his_L_c_CAP::6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 343 tRNA_charging_M_ile_L_c_CAP::17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c
		0.0	;	# 344 tRNA_charging_M_leu_L_c_CAP::22.0*M_leu_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_leu_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0.0	;	# 345 tRNA_charging_M_lys_L_c_CAP::15.0*M_lys_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_lys_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c
		0.0	;	# 346 tRNA_charging_M_met_L_c_CAP::7.0*M_met_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_met_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c
		0.0	;	# 347 tRNA_charging_M_phe_L_c_CAP::5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 348 tRNA_charging_M_pro_L_c_CAP::6.0*M_pro_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_pro_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 349 tRNA_charging_M_ser_L_c_CAP::12.0*M_ser_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_ser_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0.0	;	# 350 tRNA_charging_M_thr_L_c_CAP::12.0*M_thr_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_thr_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c
		0.0	;	# 351 tRNA_charging_M_trp_L_c_CAP::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c
		0.0	;	# 352 tRNA_charging_M_tyr_L_c_CAP::6.0*M_tyr_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_tyr_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 353 tRNA_charging_M_val_L_c_CAP::14.0*M_val_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_val_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c
		0.0	;	# 354 translation_initiation_Insulin::mRNA_Insulin+RIBOSOME --> RIBOSOME_START_Insulin
		0.0	;	# 355 translation_Insulin::RIBOSOME_START_Insulin+1048.0*M_gtp_c+1048.0*M_h2o_c+52.0*M_ala_L_c_tRNA+44.0*M_arg_L_c_tRNA+6.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+28.0*M_cys_L_c_tRNA+27.0*M_glu_L_c_tRNA+21.0*M_gln_L_c_tRNA+61.0*M_gly_L_c_tRNA+18.0*M_his_L_c_tRNA+3.0*M_ile_L_c_tRNA+71.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+58.0*M_pro_L_c_tRNA+34.0*M_ser_L_c_tRNA+20.0*M_thr_L_c_tRNA+18.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+22.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_Insulin+PROTEIN_Insulin+1048.0*M_gdp_c+1048.0*M_pi_c+524.0*tRNA
		0.0	;	# 356 tRNA_charging_M_ala_L_c_Insulin::52.0*M_ala_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_ala_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c
		0.0	;	# 357 tRNA_charging_M_arg_L_c_Insulin::44.0*M_arg_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_arg_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c
		0.0	;	# 358 tRNA_charging_M_asn_L_c_Insulin::6.0*M_asn_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_asn_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 359 tRNA_charging_M_asp_L_c_Insulin::10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c
		0.0	;	# 360 tRNA_charging_M_cys_L_c_Insulin::28.0*M_cys_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_cys_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c
		0.0	;	# 361 tRNA_charging_M_glu_L_c_Insulin::27.0*M_glu_L_c+27.0*M_atp_c+27.0*tRNA+27.0*M_h2o_c --> 27.0*M_glu_L_c_tRNA+27.0*M_amp_c+27.0*M_ppi_c
		0.0	;	# 362 tRNA_charging_M_gln_L_c_Insulin::21.0*M_gln_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_gln_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c
		0.0	;	# 363 tRNA_charging_M_gly_L_c_Insulin::61.0*M_gly_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_gly_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c
		0.0	;	# 364 tRNA_charging_M_his_L_c_Insulin::18.0*M_his_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_his_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 365 tRNA_charging_M_ile_L_c_Insulin::3.0*M_ile_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_ile_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c
		0.0	;	# 366 tRNA_charging_M_leu_L_c_Insulin::71.0*M_leu_L_c+71.0*M_atp_c+71.0*tRNA+71.0*M_h2o_c --> 71.0*M_leu_L_c_tRNA+71.0*M_amp_c+71.0*M_ppi_c
		0.0	;	# 367 tRNA_charging_M_lys_L_c_Insulin::9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c
		0.0	;	# 368 tRNA_charging_M_met_L_c_Insulin::6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c
		0.0	;	# 369 tRNA_charging_M_phe_L_c_Insulin::11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c
		0.0	;	# 370 tRNA_charging_M_pro_L_c_Insulin::58.0*M_pro_L_c+58.0*M_atp_c+58.0*tRNA+58.0*M_h2o_c --> 58.0*M_pro_L_c_tRNA+58.0*M_amp_c+58.0*M_ppi_c
		0.0	;	# 371 tRNA_charging_M_ser_L_c_Insulin::34.0*M_ser_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_ser_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c
		0.0	;	# 372 tRNA_charging_M_thr_L_c_Insulin::20.0*M_thr_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_thr_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c
		0.0	;	# 373 tRNA_charging_M_trp_L_c_Insulin::18.0*M_trp_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_trp_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c
		0.0	;	# 374 tRNA_charging_M_tyr_L_c_Insulin::5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c
		0.0	;	# 375 tRNA_charging_M_val_L_c_Insulin::22.0*M_val_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_val_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c
		0.0	;	# 376 tRNA_c_exchange::[] --> tRNA_c
		0.0	;	# 377 tRNA_c_exchange_reverse::tRNA_c --> []
		0.0	;	# 378 PROTEIN_export_S38::PROTEIN_S38 --> []
		0.0	;	# 379 PROTEIN_export_S28::PROTEIN_S28 --> []
		0.0	;	# 380 PROTEIN_export_S19::PROTEIN_S19 --> []
		0.0	;	# 381 PROTEIN_export_LACI::PROTEIN_LACI --> []
		0.0	;	# 382 PROTEIN_export_ENZYME::PROTEIN_ENZYME --> []
		0.0	;	# 383 PROTEIN_export_CAP::PROTEIN_CAP --> []
		0.0	;	# 384 PROTEIN_export_Glucagon::PROTEIN_Glucagon --> []
		0.0	;	# 385 PROTEIN_export_Insulin::PROTEIN_Insulin --> []
		0.0	;	# 386 PROTEIN_export_cAMP::cAMP --> []
		0.0	;	# 387 M_o2_c_exchange::[] --> M_o2_c
		0.0	;	# 388 M_co2_c_exchange::M_co2_c --> []
		0.0	;	# 389 M_h_c_exchange::M_h_c --> []
		0.0	;	# 390 M_h_c_exchange_reverse::[] --> M_h_c
		0.0	;	# 391 M_h2s_c_exchange::[] --> M_h2s_c
		0.0	;	# 392 M_h2s_c_exchange_reverse::M_h2s_c --> []
		0.0	;	# 393 M_h2o_c_exchange::[] --> M_h2o_c
		0.0	;	# 394 M_h2o_c_exchange_reverse::M_h2o_c --> []
		0.0	;	# 395 M_pi_c_exchange::[] --> M_pi_c
		0.0	;	# 396 M_pi_c_exchange_reverse::M_pi_c --> []
		0.0	;	# 397 M_nh3_c_exchange::[] --> M_nh3_c
		0.0	;	# 398 M_nh3_c_exchange_reverse::M_nh3_c --> []
		0.0	;	# 399 M_glc_D_c_exchange::[] --> M_glc_D_c
		0.0	;	# 400 M_hco3_c_exchange::[] --> M_hco3_c
		0.0	;	# 401 M_hco3_c_exchange_reverse::M_hco3_c --> []
		0.0	;	# 402 M_pyr_c_exchange::M_pyr_c --> []
		0.0	;	# 403 M_pyr_c_exchange_reverse::[] --> M_pyr_c
		0.0	;	# 404 M_ac_c_exchange::M_ac_c --> []
		0.0	;	# 405 M_lac_D_c_exchange::M_lac_D_c --> []
		0.0	;	# 406 M_succ_c_exchange::M_succ_c --> []
		0.0	;	# 407 M_mal_L_c_exchange::M_mal_L_c --> []
		0.0	;	# 408 M_fum_c_exchange::M_fum_c --> []
		0.0	;	# 409 M_etoh_c_exchange::M_etoh_c --> []
		0.0	;	# 410 M_mglx_c_exchange::M_mglx_c --> []
		0.0	;	# 411 M_prop_c_exchange::M_prop_c --> []
		0.0	;	# 412 M_indole_c_exchange::M_indole_c --> []
		0.0	;	# 413 M_cadav_c_exchange::M_cadav_c --> []
		0.0	;	# 414 M_gaba_c_exchange::M_gaba_c --> []
		0.0	;	# 415 M_glycoA_c_exchange::M_glycoA_c --> []
		0.0	;	# 416 M_ala_L_c_exchange::[] --> M_ala_L_c
		0.0	;	# 417 M_ala_L_c_exchange_reverse::M_ala_L_c --> []
		0.0	;	# 418 M_arg_L_c_exchange::[] --> M_arg_L_c
		0.0	;	# 419 M_arg_L_c_exchange_reverse::M_arg_L_c --> []
		0.0	;	# 420 M_asn_L_c_exchange::[] --> M_asn_L_c
		0.0	;	# 421 M_asn_L_c_exchange_reverse::M_asn_L_c --> []
		0.0	;	# 422 M_asp_L_c_exchange::[] --> M_asp_L_c
		0.0	;	# 423 M_asp_L_c_exchange_reverse::M_asp_L_c --> []
		0.0	;	# 424 M_cys_L_c_exchange::[] --> M_cys_L_c
		0.0	;	# 425 M_cys_L_c_exchange_reverse::M_cys_L_c --> []
		0.0	;	# 426 M_glu_L_c_exchange::[] --> M_glu_L_c
		0.0	;	# 427 M_glu_L_c_exchange_reverse::M_glu_L_c --> []
		0.0	;	# 428 M_gln_L_c_exchange::[] --> M_gln_L_c
		0.0	;	# 429 M_gln_L_c_exchange_reverse::M_gln_L_c --> []
		0.0	;	# 430 M_gly_L_c_exchange::[] --> M_gly_L_c
		0.0	;	# 431 M_gly_L_c_exchange_reverse::M_gly_L_c --> []
		0.0	;	# 432 M_his_L_c_exchange::[] --> M_his_L_c
		0.0	;	# 433 M_his_L_c_exchange_reverse::M_his_L_c --> []
		0.0	;	# 434 M_ile_L_c_exchange::[] --> M_ile_L_c
		0.0	;	# 435 M_ile_L_c_exchange_reverse::M_ile_L_c --> []
		0.0	;	# 436 M_leu_L_c_exchange::[] --> M_leu_L_c
		0.0	;	# 437 M_leu_L_c_exchange_reverse::M_leu_L_c --> []
		0.0	;	# 438 M_lys_L_c_exchange::[] --> M_lys_L_c
		0.0	;	# 439 M_lys_L_c_exchange_reverse::M_lys_L_c --> []
		0.0	;	# 440 M_met_L_c_exchange::[] --> M_met_L_c
		0.0	;	# 441 M_met_L_c_exchange_reverse::M_met_L_c --> []
		0.0	;	# 442 M_phe_L_c_exchange::[] --> M_phe_L_c
		0.0	;	# 443 M_phe_L_c_exchange_reverse::M_phe_L_c --> []
		0.0	;	# 444 M_pro_L_c_exchange::[] --> M_pro_L_c
		0.0	;	# 445 M_pro_L_c_exchange_reverse::M_pro_L_c --> []
		0.0	;	# 446 M_ser_L_c_exchange::[] --> M_ser_L_c
		0.0	;	# 447 M_ser_L_c_exchange_reverse::M_ser_L_c --> []
		0.0	;	# 448 M_thr_L_c_exchange::[] --> M_thr_L_c
		0.0	;	# 449 M_thr_L_c_exchange_reverse::M_thr_L_c --> []
		0.0	;	# 450 M_trp_L_c_exchange::[] --> M_trp_L_c
		0.0	;	# 451 M_trp_L_c_exchange_reverse::M_trp_L_c --> []
		0.0	;	# 452 M_tyr_L_c_exchange::[] --> M_tyr_L_c
		0.0	;	# 453 M_tyr_L_c_exchange_reverse::M_tyr_L_c --> []
		0.0	;	# 454 M_val_L_c_exchange::[] --> M_val_L_c
		0.0	;	# 455 M_val_L_c_exchange_reverse::M_val_L_c --> []
	];

	# Min/Max flag - default is minimum - 
	is_minimum_flag = true

	# List of reation strings - used to write flux report 
	list_of_reaction_strings = [
		"R_glk_atp::M_atp_c+M_glc_D_c --> M_adp_c+M_g6p_c"
		"R_pgi::M_g6p_c --> M_f6p_c"
		"R_pgi_reverse::M_f6p_c --> M_g6p_c"
		"R_pfk::M_atp_c+M_f6p_c --> M_adp_c+M_fdp_c"
		"R_fdp::M_fdp_c+M_h2o_c --> M_f6p_c+M_pi_c"
		"R_fbaA::M_fdp_c --> M_dhap_c+M_g3p_c"
		"R_fbaA_reverse::M_dhap_c+M_g3p_c --> M_fdp_c"
		"R_tpiA::M_dhap_c --> M_g3p_c"
		"R_tpiA_reverse::M_g3p_c --> M_dhap_c"
		"R_gapA::M_g3p_c+M_nad_c+M_pi_c --> M_13dpg_c+M_h_c+M_nadh_c"
		"R_gapA_reverse::M_13dpg_c+M_h_c+M_nadh_c --> M_g3p_c+M_nad_c+M_pi_c"
		"R_pgk::M_13dpg_c+M_adp_c --> M_3pg_c+M_atp_c"
		"R_pgk_reverse::M_3pg_c+M_atp_c --> M_13dpg_c+M_adp_c"
		"R_gpm::M_3pg_c --> M_2pg_c"
		"R_gpm_reverse::M_2pg_c --> M_3pg_c"
		"R_eno::M_2pg_c --> M_h2o_c+M_pep_c"
		"R_eno_reverse::M_h2o_c+M_pep_c --> M_2pg_c"
		"R_pyk::M_adp_c+M_pep_c --> M_atp_c+M_pyr_c"
		"R_pck::M_atp_c+M_oaa_c --> M_adp_c+M_co2_c+M_pep_c"
		"R_ppc::M_co2_c+M_h2o_c+M_pep_c --> M_oaa_c+M_pi_c"
		"R_pdh::M_coa_c+M_nad_c+M_pyr_c --> M_accoa_c+M_co2_c+M_nadh_c+M_h_c"
		"R_pps::M_atp_c+M_h2o_c+M_pyr_c --> M_amp_c+M_pep_c+M_pi_c"
		"R_zwf::M_g6p_c+M_nadp_c --> M_6pgl_c+M_h_c+M_nadph_c"
		"R_zwf_reverse::M_6pgl_c+M_h_c+M_nadph_c --> M_g6p_c+M_nadp_c"
		"R_pgl::M_6pgl_c+M_h2o_c --> M_6pgc_c"
		"R_gnd::M_6pgc_c+M_nadp_c --> M_co2_c+M_nadph_c+M_ru5p_D_c+M_h_c"
		"R_rpe::M_ru5p_D_c --> M_xu5p_D_c"
		"R_rpe_reverse::M_xu5p_D_c --> M_ru5p_D_c"
		"R_rpi::M_r5p_c --> M_ru5p_D_c"
		"R_rpi_reverse::M_ru5p_D_c --> M_r5p_c"
		"R_talAB::M_g3p_c+M_s7p_c --> M_e4p_c+M_f6p_c"
		"R_talAB_reverse::M_e4p_c+M_f6p_c --> M_g3p_c+M_s7p_c"
		"R_tkt1::M_r5p_c+M_xu5p_D_c --> M_g3p_c+M_s7p_c"
		"R_tkt1_reverse::M_g3p_c+M_s7p_c --> M_r5p_c+M_xu5p_D_c"
		"R_tkt2::M_e4p_c+M_xu5p_D_c --> M_f6p_c+M_g3p_c"
		"R_tkt2_reverse::M_f6p_c+M_g3p_c --> M_e4p_c+M_xu5p_D_c"
		"R_edd::M_6pgc_c --> M_2ddg6p_c+M_h2o_c"
		"R_eda::M_2ddg6p_c --> M_g3p_c+M_pyr_c"
		"R_gltA::M_accoa_c+M_h2o_c+M_oaa_c --> M_cit_c+M_coa_c"
		"R_acn::M_cit_c --> M_icit_c"
		"R_acn_reverse::M_icit_c --> M_cit_c"
		"R_icd::M_icit_c+M_nadp_c --> M_akg_c+M_co2_c+M_nadph_c+M_h_c"
		"R_icd_reverse::M_akg_c+M_co2_c+M_nadph_c+M_h_c --> M_icit_c+M_nadp_c"
		"R_sucAB::M_akg_c+M_coa_c+M_nad_c --> M_co2_c+M_nadh_c+M_succoa_c+M_h_c"
		"R_sucCD::M_adp_c+M_pi_c+M_succoa_c --> M_atp_c+M_coa_c+M_succ_c"
		"R_sdh::M_q8_c+M_succ_c --> M_fum_c+M_q8h2_c"
		"R_frd::M_fum_c+M_mql8_c --> M_mqn8_c+M_succ_c"
		"R_fum::M_fum_c+M_h2o_c --> M_mal_L_c"
		"R_fum_reverse::M_mal_L_c --> M_fum_c+M_h2o_c"
		"R_mdh::M_mal_L_c+M_nad_c --> M_oaa_c+M_h_c+M_nadh_c"
		"R_mdh_reverse::M_oaa_c+M_h_c+M_nadh_c --> M_mal_L_c+M_nad_c"
		"R_cyd::2.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+2.0*M_he_c"
		"R_cyo::4.0*M_h_c+0.5*M_o2_c+M_q8h2_c --> M_h2o_c+M_q8_c+4.0*M_he_c"
		"R_app::2.0*M_h_c+M_mql8_c+0.5*M_o2_c --> M_h2o_c+M_mqn8_c+2.0*M_he_c"
		"R_atp::M_adp_c+M_pi_c+4.0*M_he_c --> M_atp_c+4.0*M_h_c+M_h2o_c"
		"R_nuo::3.0*M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c+2.0*M_he_c"
		"R_pnt1::M_nad_c+M_nadph_c --> M_nadh_c+M_nadp_c"
		"R_pnt2::M_nadh_c+M_nadp_c+2.0*M_he_c --> 2.0*M_h_c+M_nad_c+M_nadph_c"
		"R_ndh1::M_h_c+M_nadh_c+M_q8_c --> M_nad_c+M_q8h2_c"
		"R_ndh2::M_h_c+M_mqn8_c+M_nadh_c --> M_mql8_c+M_nad_c"
		"R_ppa::M_ppi_c+M_h2o_c --> 2.0*M_pi_c"
		"R_aceA::M_icit_c --> M_glx_c+M_succ_c"
		"R_aceB::M_accoa_c+M_glx_c+M_h2o_c --> M_coa_c+M_mal_L_c"
		"R_maeA::M_mal_L_c+M_nad_c --> M_co2_c+M_nadh_c+M_pyr_c+M_h_c"
		"R_maeB::M_mal_L_c+M_nadp_c --> M_co2_c+M_nadph_c+M_pyr_c+M_h_c"
		"R_pta::M_accoa_c+M_pi_c --> M_actp_c+M_coa_c"
		"R_pta_reverse::M_actp_c+M_coa_c --> M_accoa_c+M_pi_c"
		"R_ackA::M_actp_c+M_adp_c --> M_ac_c+M_atp_c"
		"R_ackA_reverse::M_ac_c+M_atp_c --> M_actp_c+M_adp_c"
		"R_acs::M_ac_c+M_atp_c+M_coa_c --> M_accoa_c+M_amp_c+M_ppi_c"
		"R_adhE::M_accoa_c+2.0*M_h_c+2.0*M_nadh_c --> M_coa_c+M_etoh_c+2.0*M_nad_c"
		"R_adhE_reverse::M_coa_c+M_etoh_c+2.0*M_nad_c --> M_accoa_c+2.0*M_h_c+2.0*M_nadh_c"
		"R_ldh::M_pyr_c+M_nadh_c+M_h_c --> M_lac_D_c+M_nad_c"
		"R_ldh_reverse::M_lac_D_c+M_nad_c --> M_pyr_c+M_nadh_c+M_h_c"
		"R_pflAB::M_coa_c+M_pyr_c --> M_accoa_c+M_for_c"
		"R_alaAC::M_pyr_c+M_glu_L_c --> M_ala_L_c+M_akg_c"
		"R_alaAC_reverse::M_ala_L_c+M_akg_c --> M_pyr_c+M_glu_L_c"
		"R_arg::M_accoa_c+2.0*M_glu_L_c+3.0*M_atp_c+M_nadph_c+M_h_c+M_h2o_c+M_nh3_c+M_co2_c+M_asp_L_c --> M_coa_c+2.0*M_adp_c+2.0*M_pi_c+M_nadp_c+M_akg_c+M_ac_c+M_amp_c+M_ppi_c+M_fum_c+M_arg_L_c"
		"R_aspC::M_glu_L_c+M_oaa_c --> M_asp_L_c+M_akg_c"
		"R_asnB::M_asp_L_c+M_gln_L_c+M_h2o_c+M_atp_c --> M_asn_L_c+M_glu_L_c+M_ppi_c+M_amp_c"
		"R_asnA::M_asp_L_c+M_atp_c+M_nh3_c --> M_asn_L_c+M_ppi_c+M_amp_c"
		"R_cysEMK::M_ser_L_c+M_accoa_c+M_h2s_c --> M_cys_L_c+M_coa_c+M_ac_c"
		"R_gltBD::M_gln_L_c+M_akg_c+M_nadph_c+M_h_c --> 2.0*M_glu_L_c+M_nadp_c"
		"R_gdhA::M_akg_c+M_nadph_c+M_nh3_c+M_h_c --> M_glu_L_c+M_h2o_c+M_nadp_c"
		"R_gdhA_reverse::M_glu_L_c+M_h2o_c+M_nadp_c --> M_akg_c+M_nadph_c+M_nh3_c+M_h_c"
		"R_glnA::M_glu_L_c+M_atp_c+M_nh3_c --> M_gln_L_c+M_adp_c+M_pi_c"
		"R_glyA::M_ser_L_c+M_thf_c --> M_gly_L_c+M_h2o_c+M_mlthf_c"
		"R_his::M_gln_L_c+M_r5p_c+2.0*M_atp_c+2.0*M_nad_c+3.0*M_h2o_c --> M_his_L_c+M_akg_c+M_aicar_c+2.0*M_nadh_c+M_amp_c+M_pi_c+2.0*M_ppi_c+2.0*M_h_c"
		"R_ile::M_thr_L_c+M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c --> M_ile_L_c+M_h2o_c+M_nh3_c+M_co2_c+M_nadp_c+M_akg_c"
		"R_leu::2.0*M_pyr_c+M_glu_L_c+M_nad_c+M_nadph_c+M_accoa_c --> M_leu_L_c+2.0*M_co2_c+M_nadp_c+M_coa_c+M_nadh_c+M_akg_c"
		"R_lys::M_asp_L_c+M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_pyr_c+M_succoa_c+M_glu_L_c --> M_lys_L_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_coa_c+M_akg_c+M_succ_c+M_co2_c"
		"R_met::M_asp_L_c+M_cys_L_c+M_succoa_c+M_atp_c+2.0*M_nadph_c+M_5mthf_c+M_h2o_c+2.0*M_h_c --> M_met_L_c+M_coa_c+M_succ_c+M_adp_c+M_pi_c+2.0*M_nadp_c+M_thf_c+M_nh3_c+M_pyr_c"
		"R_phe::M_chor_c+M_glu_L_c --> M_phe_L_c+M_co2_c+M_h2o_c+M_akg_c"
		"R_pro::M_glu_L_c+M_atp_c+2.0*M_h_c+2.0*M_nadph_c --> M_pro_L_c+M_adp_c+2.0*M_nadp_c+M_pi_c+M_h2o_c"
		"R_serABC::M_3pg_c+M_nad_c+M_glu_L_c+M_h2o_c --> M_ser_L_c+M_nadh_c+M_h_c+M_akg_c+M_pi_c"
		"R_thr::M_asp_L_c+2.0*M_atp_c+2.0*M_nadph_c+2.0*M_h_c+M_h2o_c --> M_thr_L_c+2.0*M_adp_c+2.0*M_pi_c+2.0*M_nadp_c"
		"R_trp::M_chor_c+M_gln_L_c+M_ser_L_c+M_r5p_c+M_atp_c --> M_trp_L_c+M_glu_L_c+M_pyr_c+M_ppi_c+2.0*M_h2o_c+M_co2_c+M_g3p_c+M_amp_c"
		"R_tyr::M_chor_c+M_glu_L_c+M_nad_c --> M_tyr_L_c+M_akg_c+M_nadh_c+M_co2_c+M_h_c"
		"R_val::2.0*M_pyr_c+M_h_c+M_nadph_c+M_glu_L_c --> M_val_L_c+M_co2_c+M_nadp_c+M_h2o_c+M_akg_c"
		"R_arg_deg::M_arg_L_c+4.0*M_h2o_c+M_nad_c+M_akg_c+M_succoa_c --> M_h_c+M_co2_c+2.0*M_glu_L_c+2.0*M_nh3_c+M_nadh_c+M_succ_c+M_coa_c"
		"R_asp_deg::M_asp_L_c --> M_fum_c+M_nh3_c"
		"R_asn_deg::M_asn_L_c+M_amp_c+M_ppi_c --> M_nh3_c+M_asp_L_c+M_atp_c"
		"R_gly_deg::M_gly_L_c+M_accoa_c+M_o2_c+M_h2o_c --> M_coa_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c"
		"R_mglx_deg::M_mglx_c+M_nad_c+M_h2o_c --> M_pyr_c+M_nadh_c+M_h_c"
		"R_ser_deg::M_ser_L_c --> M_nh3_c+M_pyr_c"
		"R_pro_deg::M_pro_L_c+M_q8_c+2.0*M_h2o_c+M_nad_c --> M_h_c+M_q8h2_c+M_nadh_c+M_glu_L_c"
		"R_thr_deg1::M_thr_L_c+M_nad_c+M_coa_c --> M_nadh_c+M_h_c+M_accoa_c+M_gly_L_c"
		"R_thr_deg2::M_thr_L_c+M_nad_c+M_o2_c+M_h2o_c --> M_nadh_c+M_co2_c+M_h2o2_c+M_nh3_c+M_mglx_c+M_h_c"
		"R_thr_deg3::M_thr_L_c+M_pi_c+M_adp_c --> M_nh3_c+M_for_c+M_atp_c+M_prop_c"
		"R_trp_deg::M_trp_L_c+M_h2o_c --> M_indole_c+M_nh3_c+M_pyr_c"
		"R_cys_deg::M_cys_L_c+M_h2o_c --> M_h2s_c+M_nh3_c+M_pyr_c"
		"R_lys_deg::M_lys_L_c --> M_co2_c+M_cadav_c"
		"R_gln_deg::M_gln_L_c+M_h2o_c --> M_nh3_c+M_glu_L_c"
		"R_glu_deg::M_glu_L_c --> M_co2_c+M_gaba_c"
		"R_gaba_deg1::M_gaba_c+M_akg_c+M_h2o_c+M_nad_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadh_c"
		"R_gaba_deg2::M_gaba_c+M_akg_c+M_h2o_c+M_nadp_c --> M_succ_c+M_glu_L_c+M_h_c+M_nadph_c"
		"R_chor::M_e4p_c+2.0*M_pep_c+M_nadph_c+M_atp_c+M_h_c --> M_chor_c+M_nadp_c+M_adp_c+4.0*M_pi_c"
		"R_fol_e::M_gtp_c+4.0*M_h2o_c --> M_for_c+3.0*M_pi_c+M_glycoA_c+M_78mdp_c"
		"R_fol_1::M_chor_c+M_gln_L_c --> M_4adochor_c+M_glu_L_c"
		"R_fol_2a::M_4adochor_c --> M_4abz_c+M_pyr_c"
		"R_fol_2b::M_4abz_c+M_78mdp_c --> M_78dhf_c+M_h2o_c"
		"R_fol_3::M_78dhf_c+M_atp_c+M_glu_L_c --> M_adp_c+M_pi_c+M_dhf_c"
		"R_fol_4::M_dhf_c+M_nadph_c+M_h_c --> M_thf_c+M_nadp_c"
		"R_gly_fol::M_gly_L_c+M_thf_c+M_nad_c --> M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c"
		"R_gly_fol_reverse::M_mlthf_c+M_nh3_c+M_co2_c+M_nadh_c+M_h_c --> M_gly_L_c+M_thf_c+M_nad_c"
		"R_mthfd::M_mlthf_c+M_nadp_c --> M_methf_c+M_nadph_c"
		"R_mthfd_reverse::M_methf_c+M_nadph_c --> M_mlthf_c+M_nadp_c"
		"R_mthfc::M_h2o_c+M_methf_c --> M_10fthf_c+M_h_c"
		"R_mthfc_reverse::M_10fthf_c+M_h_c --> M_h2o_c+M_methf_c"
		"R_mthfr2a::M_mlthf_c+M_h_c+M_nadh_c --> M_5mthf_c+M_nad_c"
		"R_mthfr2b::M_mlthf_c+M_h_c+M_nadph_c --> M_5mthf_c+M_nadp_c"
		"R_prpp_syn::M_r5p_c+M_atp_c --> M_prpp_c+M_amp_c"
		"R_or_syn_1::2.0*M_atp_c+M_gln_L_c+M_hco3_c+M_h2o_c+M_h_c --> 2.0*M_adp_c+M_glu_L_c+M_pi_c+M_clasp_c"
		"R_or_syn_2::M_clasp_c+M_asp_L_c+M_q8_c --> M_or_c+M_q8h2_c+M_h2o_c+M_pi_c"
		"R_omp_syn::M_prpp_c+M_or_c --> M_omp_c+M_ppi_c"
		"R_ump_syn::M_omp_c --> M_ump_c+M_co2_c"
		"R_ctp_1::M_utp_c+M_atp_c+M_nh3_c --> M_ctp_c+M_adp_c+M_pi_c"
		"R_ctp_2::M_utp_c+M_gln_L_c+M_atp_c+M_h2o_c --> M_ctp_c+M_glu_L_c+M_adp_c+M_pi_c"
		"R_A_syn_1::M_gln_L_c+M_prpp_c+M_h2o_c --> M_5pbdra+M_ppi_c+M_glu_L_c"
		"R_A_syn_2::M_atp_c+M_5pbdra+M_gly_L_c --> M_adp_c+M_pi_c+M_gar_c"
		"R_A_syn_3::M_10fthf_c+M_gar_c --> M_thf_c+M_fgar_c"
		"R_A_syn_4::M_atp_c+M_fgar_c+M_gln_L_c+M_h2o_c --> M_adp_c+M_pi_c+M_fgam_c+M_glu_L_c"
		"R_A_syn_5::M_atp_c+M_fgam_c --> M_adp_c+M_pi_c+M_air_c"
		"R_A_syn_6::M_atp_c+M_air_c+M_hco3_c+M_h_c --> M_adp_c+M_pi_c+M_cair_c"
		"R_A_syn_7::M_atp_c+M_cair_c+M_asp_L_c --> M_adp_c+M_pi_c+M_saicar_c"
		"R_A_syn_8::M_saicar_c --> M_fum_c+M_aicar_c"
		"R_A_syn_9::M_aicar_c+M_10fthf_c --> M_thf_c+M_faicar_c"
		"R_A_syn_10::M_faicar_c --> M_imp_c+M_h2o_c"
		"R_A_syn_12::M_imp_c+M_gtp_c+M_asp_L_c --> M_gdp_c+M_pi_c+M_fum_c+M_amp_c"
		"R_xmp_syn::M_imp_c+M_nad_c+M_h2o_c --> M_xmp_c+M_nadh_c+M_h_c"
		"R_gmp_syn::M_atp_c+M_xmp_c+M_gln_L_c+M_h2o_c --> M_amp_c+M_ppi_c+M_gmp_c+M_glu_L_c"
		"R_atp_amp::M_atp_c+M_h2o_c --> M_amp_c+M_ppi_c"
		"R_utp_ump::M_utp_c+M_h2o_c --> M_ump_c+M_ppi_c"
		"R_ctp_cmp::M_ctp_c+M_h2o_c --> M_cmp_c+M_ppi_c"
		"R_gtp_gmp::M_gtp_c+M_h2o_c --> M_gmp_c+M_ppi_c"
		"R_atp_adp::M_atp_c+M_h2o_c --> M_adp_c+M_pi_c"
		"R_utp_adp::M_utp_c+M_h2o_c --> M_udp_c+M_pi_c"
		"R_ctp_adp::M_ctp_c+M_h2o_c --> M_cdp_c+M_pi_c"
		"R_gtp_adp::M_gtp_c+M_h2o_c --> M_gdp_c+M_pi_c"
		"R_udp_utp::M_udp_c+M_atp_c --> M_utp_c+M_adp_c"
		"R_cdp_ctp::M_cdp_c+M_atp_c --> M_ctp_c+M_adp_c"
		"R_gdp_gtp::M_gdp_c+M_atp_c --> M_gtp_c+M_adp_c"
		"R_atp_ump::M_atp_c+M_ump_c --> M_adp_c+M_udp_c"
		"R_atp_cmp::M_atp_c+M_cmp_c --> M_adp_c+M_cdp_c"
		"R_atp_gmp::M_atp_c+M_gmp_c --> M_adp_c+M_gdp_c"
		"R_adk_atp::M_amp_c+M_atp_c --> 2.0*M_adp_c"
		"transcriptional_initiation_S38::GENE_S38+RNAP --> OPEN_GENE_S38"
		"transcription_S38::OPEN_GENE_S38+292.0*M_gtp_c+225.0*M_ctp_c+222.0*M_utp_c+254.0*M_atp_c+993.0*M_h2o_c --> mRNA_S38+GENE_S38+RNAP+993.0*M_ppi_c"
		"mRNA_degradation_S38::mRNA_S38 --> 292.0*M_gmp_c+225.0*M_cmp_c+222.0*M_ump_c+254.0*M_amp_c"
		"transcriptional_initiation_S28::GENE_S28+RNAP --> OPEN_GENE_S28"
		"transcription_S28::OPEN_GENE_S28+181.0*M_gtp_c+147.0*M_ctp_c+191.0*M_utp_c+219.0*M_atp_c+738.0*M_h2o_c --> mRNA_S28+GENE_S28+RNAP+738.0*M_ppi_c"
		"mRNA_degradation_S28::mRNA_S28 --> 181.0*M_gmp_c+147.0*M_cmp_c+191.0*M_ump_c+219.0*M_amp_c"
		"transcriptional_initiation_S19::GENE_S19+RNAP --> OPEN_GENE_S19"
		"transcription_S19::OPEN_GENE_S19+140.0*M_gtp_c+145.0*M_ctp_c+117.0*M_utp_c+120.0*M_atp_c+522.0*M_h2o_c --> mRNA_S19+GENE_S19+RNAP+522.0*M_ppi_c"
		"mRNA_degradation_S19::mRNA_S19 --> 140.0*M_gmp_c+145.0*M_cmp_c+117.0*M_ump_c+120.0*M_amp_c"
		"transcriptional_initiation_P38::GENE_P38+RNAP --> OPEN_GENE_P38"
		"transcription_P38::OPEN_GENE_P38+0.0*M_gtp_c+0.0*M_ctp_c+0.0*M_utp_c+0.0*M_atp_c+0.0*M_h2o_c --> mRNA_P38+GENE_P38+RNAP+0.0*M_ppi_c"
		"mRNA_degradation_P38::mRNA_P38 --> 0.0*M_gmp_c+0.0*M_cmp_c+0.0*M_ump_c+0.0*M_amp_c"
		"transcriptional_initiation_P28::GENE_P28+RNAP --> OPEN_GENE_P28"
		"transcription_P28::OPEN_GENE_P28+15.0*M_gtp_c+11.0*M_ctp_c+17.0*M_utp_c+12.0*M_atp_c+55.0*M_h2o_c --> mRNA_P28+GENE_P28+RNAP+55.0*M_ppi_c"
		"mRNA_degradation_P28::mRNA_P28 --> 15.0*M_gmp_c+11.0*M_cmp_c+17.0*M_ump_c+12.0*M_amp_c"
		"transcriptional_initiation_P19::GENE_P19+RNAP --> OPEN_GENE_P19"
		"transcription_P19::OPEN_GENE_P19+11.0*M_gtp_c+9.0*M_ctp_c+23.0*M_utp_c+14.0*M_atp_c+57.0*M_h2o_c --> mRNA_P19+GENE_P19+RNAP+57.0*M_ppi_c"
		"mRNA_degradation_P19::mRNA_P19 --> 11.0*M_gmp_c+9.0*M_cmp_c+23.0*M_ump_c+14.0*M_amp_c"
		"transcriptional_initiation_LACI::GENE_LACI+RNAP --> OPEN_GENE_LACI"
		"transcription_LACI::OPEN_GENE_LACI+314.0*M_gtp_c+296.0*M_ctp_c+234.0*M_utp_c+239.0*M_atp_c+1083.0*M_h2o_c --> mRNA_LACI+GENE_LACI+RNAP+1083.0*M_ppi_c"
		"mRNA_degradation_LACI::mRNA_LACI --> 314.0*M_gmp_c+296.0*M_cmp_c+234.0*M_ump_c+239.0*M_amp_c"
		"transcriptional_initiation_GLUCAGON::GENE_GLUCAGON+RNAP --> OPEN_GENE_GLUCAGON"
		"transcription_GLUCAGON::OPEN_GENE_GLUCAGON+136.0*M_gtp_c+116.0*M_ctp_c+131.0*M_utp_c+160.0*M_atp_c+543.0*M_h2o_c --> mRNA_GLUCAGON+GENE_GLUCAGON+RNAP+543.0*M_ppi_c"
		"mRNA_degradation_GLUCAGON::mRNA_GLUCAGON --> 136.0*M_gmp_c+116.0*M_cmp_c+131.0*M_ump_c+160.0*M_amp_c"
		"transcriptional_initiation_ENZYME::GENE_ENZYME+RNAP --> OPEN_GENE_ENZYME"
		"transcription_ENZYME::OPEN_GENE_ENZYME+1072.0*M_gtp_c+1049.0*M_ctp_c+1298.0*M_utp_c+1414.0*M_atp_c+4833.0*M_h2o_c --> mRNA_ENZYME+GENE_ENZYME+RNAP+4833.0*M_ppi_c"
		"mRNA_degradation_ENZYME::mRNA_ENZYME --> 1072.0*M_gmp_c+1049.0*M_cmp_c+1298.0*M_ump_c+1414.0*M_amp_c"
		"transcriptional_initiation_CAP::GENE_CAP+RNAP --> OPEN_GENE_CAP"
		"transcription_CAP::OPEN_GENE_CAP+156.0*M_gtp_c+164.0*M_ctp_c+143.0*M_utp_c+170.0*M_atp_c+633.0*M_h2o_c --> mRNA_CAP+GENE_CAP+RNAP+633.0*M_ppi_c"
		"mRNA_degradation_CAP::mRNA_CAP --> 156.0*M_gmp_c+164.0*M_cmp_c+143.0*M_ump_c+170.0*M_amp_c"
		"transcriptional_initiation_Insulin::GENE_Insulin+RNAP --> OPEN_GENE_Insulin"
		"transcription_Insulin::OPEN_GENE_Insulin+514.0*M_gtp_c+522.0*M_ctp_c+314.0*M_utp_c+272.0*M_atp_c+1622.0*M_h2o_c --> mRNA_Insulin+GENE_Insulin+RNAP+1622.0*M_ppi_c"
		"mRNA_degradation_Insulin::mRNA_Insulin --> 514.0*M_gmp_c+522.0*M_cmp_c+314.0*M_ump_c+272.0*M_amp_c"
		"translation_initiation_S38::mRNA_S38+RIBOSOME --> RIBOSOME_START_S38"
		"translation_S38::RIBOSOME_START_S38+660.0*M_gtp_c+660.0*M_h2o_c+24.0*M_ala_L_c_tRNA+34.0*M_arg_L_c_tRNA+13.0*M_asn_L_c_tRNA+23.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+41.0*M_glu_L_c_tRNA+15.0*M_gln_L_c_tRNA+19.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+19.0*M_ile_L_c_tRNA+44.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+9.0*M_phe_L_c_tRNA+8.0*M_pro_L_c_tRNA+13.0*M_ser_L_c_tRNA+17.0*M_thr_L_c_tRNA+3.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+20.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S38+PROTEIN_S38+660.0*M_gdp_c+660.0*M_pi_c+330.0*tRNA"
		"tRNA_charging_M_ala_L_c_S38::24.0*M_ala_L_c+24.0*M_atp_c+24.0*tRNA+24.0*M_h2o_c --> 24.0*M_ala_L_c_tRNA+24.0*M_amp_c+24.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_S38::34.0*M_arg_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_arg_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_S38::13.0*M_asn_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_asn_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_S38::23.0*M_asp_L_c+23.0*M_atp_c+23.0*tRNA+23.0*M_h2o_c --> 23.0*M_asp_L_c_tRNA+23.0*M_amp_c+23.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_S38::0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_S38::41.0*M_glu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_glu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_S38::15.0*M_gln_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_gln_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_S38::19.0*M_gly_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_gly_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_S38::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_S38::19.0*M_ile_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ile_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_S38::44.0*M_leu_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_leu_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_S38::12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_S38::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_S38::9.0*M_phe_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_phe_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_S38::8.0*M_pro_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_pro_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_S38::13.0*M_ser_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ser_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_S38::17.0*M_thr_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_thr_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_S38::3.0*M_trp_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_trp_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_S38::7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_S38::20.0*M_val_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_val_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c"
		"translation_initiation_S28::mRNA_S28+RIBOSOME --> RIBOSOME_START_S28"
		"translation_S28::RIBOSOME_START_S28+490.0*M_gtp_c+490.0*M_h2o_c+19.0*M_ala_L_c_tRNA+13.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+20.0*M_asp_L_c_tRNA+M_cys_L_c_tRNA+18.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+25.0*M_leu_L_c_tRNA+13.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+7.0*M_pro_L_c_tRNA+21.0*M_ser_L_c_tRNA+7.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+7.0*M_tyr_L_c_tRNA+18.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S28+PROTEIN_S28+490.0*M_gdp_c+490.0*M_pi_c+245.0*tRNA"
		"tRNA_charging_M_ala_L_c_S28::19.0*M_ala_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_ala_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_S28::13.0*M_arg_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_arg_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_S28::11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_S28::20.0*M_asp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_asp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_S28::M_cys_L_c+M_atp_c+tRNA+M_h2o_c --> M_cys_L_c_tRNA+M_amp_c+M_ppi_c"
		"tRNA_charging_M_glu_L_c_S28::18.0*M_glu_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_glu_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_S28::14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_S28::16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_S28::6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_S28::17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_S28::25.0*M_leu_L_c+25.0*M_atp_c+25.0*tRNA+25.0*M_h2o_c --> 25.0*M_leu_L_c_tRNA+25.0*M_amp_c+25.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_S28::13.0*M_lys_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_lys_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_S28::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_S28::5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_S28::7.0*M_pro_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_pro_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_S28::21.0*M_ser_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_ser_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_S28::7.0*M_thr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_thr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_S28::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_S28::7.0*M_tyr_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_tyr_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_S28::18.0*M_val_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_val_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"translation_initiation_S19::mRNA_S19+RIBOSOME --> RIBOSOME_START_S19"
		"translation_S19::RIBOSOME_START_S19+346.0*M_gtp_c+346.0*M_h2o_c+14.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+2.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+2.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+5.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+5.0*M_ile_L_c_tRNA+28.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+7.0*M_phe_L_c_tRNA+4.0*M_pro_L_c_tRNA+16.0*M_ser_L_c_tRNA+13.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_S19+PROTEIN_S19+346.0*M_gdp_c+346.0*M_pi_c+173.0*tRNA"
		"tRNA_charging_M_ala_L_c_S19::14.0*M_ala_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_ala_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_S19::11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_S19::2.0*M_asn_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_asn_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_S19::10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_S19::2.0*M_cys_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_cys_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_S19::13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_S19::5.0*M_gln_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_gln_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_S19::9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_S19::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_S19::5.0*M_ile_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_ile_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_S19::28.0*M_leu_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_leu_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_S19::9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_S19::6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_S19::7.0*M_phe_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_phe_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_S19::4.0*M_pro_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_pro_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_S19::16.0*M_ser_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_ser_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_S19::13.0*M_thr_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_thr_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_S19::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_S19::5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_S19::8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"translation_initiation_LACI::mRNA_LACI+RIBOSOME --> RIBOSOME_START_LACI"
		"translation_LACI::RIBOSOME_START_LACI+720.0*M_gtp_c+720.0*M_h2o_c+45.0*M_ala_L_c_tRNA+19.0*M_arg_L_c_tRNA+11.0*M_asn_L_c_tRNA+17.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+15.0*M_glu_L_c_tRNA+28.0*M_gln_L_c_tRNA+22.0*M_gly_L_c_tRNA+7.0*M_his_L_c_tRNA+18.0*M_ile_L_c_tRNA+41.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+10.0*M_met_L_c_tRNA+4.0*M_phe_L_c_tRNA+14.0*M_pro_L_c_tRNA+32.0*M_ser_L_c_tRNA+18.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+8.0*M_tyr_L_c_tRNA+34.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_LACI+PROTEIN_LACI+720.0*M_gdp_c+720.0*M_pi_c+360.0*tRNA"
		"tRNA_charging_M_ala_L_c_LACI::45.0*M_ala_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_ala_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_LACI::19.0*M_arg_L_c+19.0*M_atp_c+19.0*tRNA+19.0*M_h2o_c --> 19.0*M_arg_L_c_tRNA+19.0*M_amp_c+19.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_LACI::11.0*M_asn_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_asn_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_LACI::17.0*M_asp_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_asp_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_LACI::3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_LACI::15.0*M_glu_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_glu_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_LACI::28.0*M_gln_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_gln_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_LACI::22.0*M_gly_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_gly_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_LACI::7.0*M_his_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_his_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_LACI::18.0*M_ile_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_ile_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_LACI::41.0*M_leu_L_c+41.0*M_atp_c+41.0*tRNA+41.0*M_h2o_c --> 41.0*M_leu_L_c_tRNA+41.0*M_amp_c+41.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_LACI::12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_LACI::10.0*M_met_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_met_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_LACI::4.0*M_phe_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_phe_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_LACI::14.0*M_pro_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_pro_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_LACI::32.0*M_ser_L_c+32.0*M_atp_c+32.0*tRNA+32.0*M_h2o_c --> 32.0*M_ser_L_c_tRNA+32.0*M_amp_c+32.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_LACI::18.0*M_thr_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_thr_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_LACI::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_LACI::8.0*M_tyr_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_tyr_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_LACI::34.0*M_val_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_val_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c"
		"translation_initiation_GLUCAGON::mRNA_GLUCAGON+RIBOSOME --> RIBOSOME_START_GLUCAGON"
		"translation_GLUCAGON::RIBOSOME_START_GLUCAGON+360.0*M_gtp_c+360.0*M_h2o_c+13.0*M_ala_L_c_tRNA+16.0*M_arg_L_c_tRNA+8.0*M_asn_L_c_tRNA+16.0*M_asp_L_c_tRNA+0.0*M_cys_L_c_tRNA+13.0*M_glu_L_c_tRNA+10.0*M_gln_L_c_tRNA+9.0*M_gly_L_c_tRNA+4.0*M_his_L_c_tRNA+8.0*M_ile_L_c_tRNA+12.0*M_leu_L_c_tRNA+10.0*M_lys_L_c_tRNA+5.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+3.0*M_pro_L_c_tRNA+17.0*M_ser_L_c_tRNA+9.0*M_thr_L_c_tRNA+4.0*M_trp_L_c_tRNA+4.0*M_tyr_L_c_tRNA+8.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_GLUCAGON+PROTEIN_GLUCAGON+360.0*M_gdp_c+360.0*M_pi_c+180.0*tRNA"
		"tRNA_charging_M_ala_L_c_GLUCAGON::13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_GLUCAGON::16.0*M_arg_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_arg_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_GLUCAGON::8.0*M_asn_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asn_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_GLUCAGON::16.0*M_asp_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_asp_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_GLUCAGON::0.0*M_cys_L_c+0.0*M_atp_c+0.0*tRNA+0.0*M_h2o_c --> 0.0*M_cys_L_c_tRNA+0.0*M_amp_c+0.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_GLUCAGON::13.0*M_glu_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_glu_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_GLUCAGON::10.0*M_gln_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_gln_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_GLUCAGON::9.0*M_gly_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_gly_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_GLUCAGON::4.0*M_his_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_his_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_GLUCAGON::8.0*M_ile_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_ile_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_GLUCAGON::12.0*M_leu_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_leu_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_GLUCAGON::10.0*M_lys_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_lys_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_GLUCAGON::5.0*M_met_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_met_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_GLUCAGON::11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_GLUCAGON::3.0*M_pro_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_pro_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_GLUCAGON::17.0*M_ser_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ser_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_GLUCAGON::9.0*M_thr_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_thr_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_GLUCAGON::4.0*M_trp_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_trp_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_GLUCAGON::4.0*M_tyr_L_c+4.0*M_atp_c+4.0*tRNA+4.0*M_h2o_c --> 4.0*M_tyr_L_c_tRNA+4.0*M_amp_c+4.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_GLUCAGON::8.0*M_val_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_val_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"translation_initiation_ENZYME::mRNA_ENZYME+RIBOSOME --> RIBOSOME_START_ENZYME"
		"translation_ENZYME::RIBOSOME_START_ENZYME+3220.0*M_gtp_c+3220.0*M_h2o_c+81.0*M_ala_L_c_tRNA+67.0*M_arg_L_c_tRNA+81.0*M_asn_L_c_tRNA+61.0*M_asp_L_c_tRNA+45.0*M_cys_L_c_tRNA+119.0*M_glu_L_c_tRNA+72.0*M_gln_L_c_tRNA+72.0*M_gly_L_c_tRNA+52.0*M_his_L_c_tRNA+116.0*M_ile_L_c_tRNA+192.0*M_leu_L_c_tRNA+109.0*M_lys_L_c_tRNA+65.0*M_met_L_c_tRNA+91.0*M_phe_L_c_tRNA+52.0*M_pro_L_c_tRNA+93.0*M_ser_L_c_tRNA+67.0*M_thr_L_c_tRNA+20.0*M_trp_L_c_tRNA+69.0*M_tyr_L_c_tRNA+86.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_ENZYME+PROTEIN_ENZYME+3220.0*M_gdp_c+3220.0*M_pi_c+1610.0*tRNA"
		"tRNA_charging_M_ala_L_c_ENZYME::81.0*M_ala_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_ala_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_ENZYME::67.0*M_arg_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_arg_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_ENZYME::81.0*M_asn_L_c+81.0*M_atp_c+81.0*tRNA+81.0*M_h2o_c --> 81.0*M_asn_L_c_tRNA+81.0*M_amp_c+81.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_ENZYME::61.0*M_asp_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_asp_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_ENZYME::45.0*M_cys_L_c+45.0*M_atp_c+45.0*tRNA+45.0*M_h2o_c --> 45.0*M_cys_L_c_tRNA+45.0*M_amp_c+45.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_ENZYME::119.0*M_glu_L_c+119.0*M_atp_c+119.0*tRNA+119.0*M_h2o_c --> 119.0*M_glu_L_c_tRNA+119.0*M_amp_c+119.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_ENZYME::72.0*M_gln_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gln_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_ENZYME::72.0*M_gly_L_c+72.0*M_atp_c+72.0*tRNA+72.0*M_h2o_c --> 72.0*M_gly_L_c_tRNA+72.0*M_amp_c+72.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_ENZYME::52.0*M_his_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_his_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_ENZYME::116.0*M_ile_L_c+116.0*M_atp_c+116.0*tRNA+116.0*M_h2o_c --> 116.0*M_ile_L_c_tRNA+116.0*M_amp_c+116.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_ENZYME::192.0*M_leu_L_c+192.0*M_atp_c+192.0*tRNA+192.0*M_h2o_c --> 192.0*M_leu_L_c_tRNA+192.0*M_amp_c+192.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_ENZYME::109.0*M_lys_L_c+109.0*M_atp_c+109.0*tRNA+109.0*M_h2o_c --> 109.0*M_lys_L_c_tRNA+109.0*M_amp_c+109.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_ENZYME::65.0*M_met_L_c+65.0*M_atp_c+65.0*tRNA+65.0*M_h2o_c --> 65.0*M_met_L_c_tRNA+65.0*M_amp_c+65.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_ENZYME::91.0*M_phe_L_c+91.0*M_atp_c+91.0*tRNA+91.0*M_h2o_c --> 91.0*M_phe_L_c_tRNA+91.0*M_amp_c+91.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_ENZYME::52.0*M_pro_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_pro_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_ENZYME::93.0*M_ser_L_c+93.0*M_atp_c+93.0*tRNA+93.0*M_h2o_c --> 93.0*M_ser_L_c_tRNA+93.0*M_amp_c+93.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_ENZYME::67.0*M_thr_L_c+67.0*M_atp_c+67.0*tRNA+67.0*M_h2o_c --> 67.0*M_thr_L_c_tRNA+67.0*M_amp_c+67.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_ENZYME::20.0*M_trp_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_trp_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_ENZYME::69.0*M_tyr_L_c+69.0*M_atp_c+69.0*tRNA+69.0*M_h2o_c --> 69.0*M_tyr_L_c_tRNA+69.0*M_amp_c+69.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_ENZYME::86.0*M_val_L_c+86.0*M_atp_c+86.0*tRNA+86.0*M_h2o_c --> 86.0*M_val_L_c_tRNA+86.0*M_amp_c+86.0*M_ppi_c"
		"translation_initiation_CAP::mRNA_CAP+RIBOSOME --> RIBOSOME_START_CAP"
		"translation_CAP::RIBOSOME_START_CAP+420.0*M_gtp_c+420.0*M_h2o_c+13.0*M_ala_L_c_tRNA+11.0*M_arg_L_c_tRNA+5.0*M_asn_L_c_tRNA+8.0*M_asp_L_c_tRNA+3.0*M_cys_L_c_tRNA+16.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+16.0*M_gly_L_c_tRNA+6.0*M_his_L_c_tRNA+17.0*M_ile_L_c_tRNA+22.0*M_leu_L_c_tRNA+15.0*M_lys_L_c_tRNA+7.0*M_met_L_c_tRNA+5.0*M_phe_L_c_tRNA+6.0*M_pro_L_c_tRNA+12.0*M_ser_L_c_tRNA+12.0*M_thr_L_c_tRNA+2.0*M_trp_L_c_tRNA+6.0*M_tyr_L_c_tRNA+14.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_CAP+PROTEIN_CAP+420.0*M_gdp_c+420.0*M_pi_c+210.0*tRNA"
		"tRNA_charging_M_ala_L_c_CAP::13.0*M_ala_L_c+13.0*M_atp_c+13.0*tRNA+13.0*M_h2o_c --> 13.0*M_ala_L_c_tRNA+13.0*M_amp_c+13.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_CAP::11.0*M_arg_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_arg_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_CAP::5.0*M_asn_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_asn_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_CAP::8.0*M_asp_L_c+8.0*M_atp_c+8.0*tRNA+8.0*M_h2o_c --> 8.0*M_asp_L_c_tRNA+8.0*M_amp_c+8.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_CAP::3.0*M_cys_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_cys_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_CAP::16.0*M_glu_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_glu_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_CAP::14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_CAP::16.0*M_gly_L_c+16.0*M_atp_c+16.0*tRNA+16.0*M_h2o_c --> 16.0*M_gly_L_c_tRNA+16.0*M_amp_c+16.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_CAP::6.0*M_his_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_his_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_CAP::17.0*M_ile_L_c+17.0*M_atp_c+17.0*tRNA+17.0*M_h2o_c --> 17.0*M_ile_L_c_tRNA+17.0*M_amp_c+17.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_CAP::22.0*M_leu_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_leu_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_CAP::15.0*M_lys_L_c+15.0*M_atp_c+15.0*tRNA+15.0*M_h2o_c --> 15.0*M_lys_L_c_tRNA+15.0*M_amp_c+15.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_CAP::7.0*M_met_L_c+7.0*M_atp_c+7.0*tRNA+7.0*M_h2o_c --> 7.0*M_met_L_c_tRNA+7.0*M_amp_c+7.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_CAP::5.0*M_phe_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_phe_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_CAP::6.0*M_pro_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_pro_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_CAP::12.0*M_ser_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_ser_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_CAP::12.0*M_thr_L_c+12.0*M_atp_c+12.0*tRNA+12.0*M_h2o_c --> 12.0*M_thr_L_c_tRNA+12.0*M_amp_c+12.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_CAP::2.0*M_trp_L_c+2.0*M_atp_c+2.0*tRNA+2.0*M_h2o_c --> 2.0*M_trp_L_c_tRNA+2.0*M_amp_c+2.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_CAP::6.0*M_tyr_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_tyr_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_CAP::14.0*M_val_L_c+14.0*M_atp_c+14.0*tRNA+14.0*M_h2o_c --> 14.0*M_val_L_c_tRNA+14.0*M_amp_c+14.0*M_ppi_c"
		"translation_initiation_Insulin::mRNA_Insulin+RIBOSOME --> RIBOSOME_START_Insulin"
		"translation_Insulin::RIBOSOME_START_Insulin+1048.0*M_gtp_c+1048.0*M_h2o_c+52.0*M_ala_L_c_tRNA+44.0*M_arg_L_c_tRNA+6.0*M_asn_L_c_tRNA+10.0*M_asp_L_c_tRNA+28.0*M_cys_L_c_tRNA+27.0*M_glu_L_c_tRNA+21.0*M_gln_L_c_tRNA+61.0*M_gly_L_c_tRNA+18.0*M_his_L_c_tRNA+3.0*M_ile_L_c_tRNA+71.0*M_leu_L_c_tRNA+9.0*M_lys_L_c_tRNA+6.0*M_met_L_c_tRNA+11.0*M_phe_L_c_tRNA+58.0*M_pro_L_c_tRNA+34.0*M_ser_L_c_tRNA+20.0*M_thr_L_c_tRNA+18.0*M_trp_L_c_tRNA+5.0*M_tyr_L_c_tRNA+22.0*M_val_L_c_tRNA --> RIBOSOME+mRNA_Insulin+PROTEIN_Insulin+1048.0*M_gdp_c+1048.0*M_pi_c+524.0*tRNA"
		"tRNA_charging_M_ala_L_c_Insulin::52.0*M_ala_L_c+52.0*M_atp_c+52.0*tRNA+52.0*M_h2o_c --> 52.0*M_ala_L_c_tRNA+52.0*M_amp_c+52.0*M_ppi_c"
		"tRNA_charging_M_arg_L_c_Insulin::44.0*M_arg_L_c+44.0*M_atp_c+44.0*tRNA+44.0*M_h2o_c --> 44.0*M_arg_L_c_tRNA+44.0*M_amp_c+44.0*M_ppi_c"
		"tRNA_charging_M_asn_L_c_Insulin::6.0*M_asn_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_asn_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_asp_L_c_Insulin::10.0*M_asp_L_c+10.0*M_atp_c+10.0*tRNA+10.0*M_h2o_c --> 10.0*M_asp_L_c_tRNA+10.0*M_amp_c+10.0*M_ppi_c"
		"tRNA_charging_M_cys_L_c_Insulin::28.0*M_cys_L_c+28.0*M_atp_c+28.0*tRNA+28.0*M_h2o_c --> 28.0*M_cys_L_c_tRNA+28.0*M_amp_c+28.0*M_ppi_c"
		"tRNA_charging_M_glu_L_c_Insulin::27.0*M_glu_L_c+27.0*M_atp_c+27.0*tRNA+27.0*M_h2o_c --> 27.0*M_glu_L_c_tRNA+27.0*M_amp_c+27.0*M_ppi_c"
		"tRNA_charging_M_gln_L_c_Insulin::21.0*M_gln_L_c+21.0*M_atp_c+21.0*tRNA+21.0*M_h2o_c --> 21.0*M_gln_L_c_tRNA+21.0*M_amp_c+21.0*M_ppi_c"
		"tRNA_charging_M_gly_L_c_Insulin::61.0*M_gly_L_c+61.0*M_atp_c+61.0*tRNA+61.0*M_h2o_c --> 61.0*M_gly_L_c_tRNA+61.0*M_amp_c+61.0*M_ppi_c"
		"tRNA_charging_M_his_L_c_Insulin::18.0*M_his_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_his_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"tRNA_charging_M_ile_L_c_Insulin::3.0*M_ile_L_c+3.0*M_atp_c+3.0*tRNA+3.0*M_h2o_c --> 3.0*M_ile_L_c_tRNA+3.0*M_amp_c+3.0*M_ppi_c"
		"tRNA_charging_M_leu_L_c_Insulin::71.0*M_leu_L_c+71.0*M_atp_c+71.0*tRNA+71.0*M_h2o_c --> 71.0*M_leu_L_c_tRNA+71.0*M_amp_c+71.0*M_ppi_c"
		"tRNA_charging_M_lys_L_c_Insulin::9.0*M_lys_L_c+9.0*M_atp_c+9.0*tRNA+9.0*M_h2o_c --> 9.0*M_lys_L_c_tRNA+9.0*M_amp_c+9.0*M_ppi_c"
		"tRNA_charging_M_met_L_c_Insulin::6.0*M_met_L_c+6.0*M_atp_c+6.0*tRNA+6.0*M_h2o_c --> 6.0*M_met_L_c_tRNA+6.0*M_amp_c+6.0*M_ppi_c"
		"tRNA_charging_M_phe_L_c_Insulin::11.0*M_phe_L_c+11.0*M_atp_c+11.0*tRNA+11.0*M_h2o_c --> 11.0*M_phe_L_c_tRNA+11.0*M_amp_c+11.0*M_ppi_c"
		"tRNA_charging_M_pro_L_c_Insulin::58.0*M_pro_L_c+58.0*M_atp_c+58.0*tRNA+58.0*M_h2o_c --> 58.0*M_pro_L_c_tRNA+58.0*M_amp_c+58.0*M_ppi_c"
		"tRNA_charging_M_ser_L_c_Insulin::34.0*M_ser_L_c+34.0*M_atp_c+34.0*tRNA+34.0*M_h2o_c --> 34.0*M_ser_L_c_tRNA+34.0*M_amp_c+34.0*M_ppi_c"
		"tRNA_charging_M_thr_L_c_Insulin::20.0*M_thr_L_c+20.0*M_atp_c+20.0*tRNA+20.0*M_h2o_c --> 20.0*M_thr_L_c_tRNA+20.0*M_amp_c+20.0*M_ppi_c"
		"tRNA_charging_M_trp_L_c_Insulin::18.0*M_trp_L_c+18.0*M_atp_c+18.0*tRNA+18.0*M_h2o_c --> 18.0*M_trp_L_c_tRNA+18.0*M_amp_c+18.0*M_ppi_c"
		"tRNA_charging_M_tyr_L_c_Insulin::5.0*M_tyr_L_c+5.0*M_atp_c+5.0*tRNA+5.0*M_h2o_c --> 5.0*M_tyr_L_c_tRNA+5.0*M_amp_c+5.0*M_ppi_c"
		"tRNA_charging_M_val_L_c_Insulin::22.0*M_val_L_c+22.0*M_atp_c+22.0*tRNA+22.0*M_h2o_c --> 22.0*M_val_L_c_tRNA+22.0*M_amp_c+22.0*M_ppi_c"
		"tRNA_c_exchange::[] --> tRNA_c"
		"tRNA_c_exchange_reverse::tRNA_c --> []"
		"PROTEIN_export_S38::PROTEIN_S38 --> []"
		"PROTEIN_export_S28::PROTEIN_S28 --> []"
		"PROTEIN_export_S19::PROTEIN_S19 --> []"
		"PROTEIN_export_LACI::PROTEIN_LACI --> []"
		"PROTEIN_export_ENZYME::PROTEIN_ENZYME --> []"
		"PROTEIN_export_CAP::PROTEIN_CAP --> []"
		"PROTEIN_export_Glucagon::PROTEIN_Glucagon --> []"
		"PROTEIN_export_Insulin::PROTEIN_Insulin --> []"
		"PROTEIN_export_cAMP::cAMP --> []"
		"M_o2_c_exchange::[] --> M_o2_c"
		"M_co2_c_exchange::M_co2_c --> []"
		"M_h_c_exchange::M_h_c --> []"
		"M_h_c_exchange_reverse::[] --> M_h_c"
		"M_h2s_c_exchange::[] --> M_h2s_c"
		"M_h2s_c_exchange_reverse::M_h2s_c --> []"
		"M_h2o_c_exchange::[] --> M_h2o_c"
		"M_h2o_c_exchange_reverse::M_h2o_c --> []"
		"M_pi_c_exchange::[] --> M_pi_c"
		"M_pi_c_exchange_reverse::M_pi_c --> []"
		"M_nh3_c_exchange::[] --> M_nh3_c"
		"M_nh3_c_exchange_reverse::M_nh3_c --> []"
		"M_glc_D_c_exchange::[] --> M_glc_D_c"
		"M_hco3_c_exchange::[] --> M_hco3_c"
		"M_hco3_c_exchange_reverse::M_hco3_c --> []"
		"M_pyr_c_exchange::M_pyr_c --> []"
		"M_pyr_c_exchange_reverse::[] --> M_pyr_c"
		"M_ac_c_exchange::M_ac_c --> []"
		"M_lac_D_c_exchange::M_lac_D_c --> []"
		"M_succ_c_exchange::M_succ_c --> []"
		"M_mal_L_c_exchange::M_mal_L_c --> []"
		"M_fum_c_exchange::M_fum_c --> []"
		"M_etoh_c_exchange::M_etoh_c --> []"
		"M_mglx_c_exchange::M_mglx_c --> []"
		"M_prop_c_exchange::M_prop_c --> []"
		"M_indole_c_exchange::M_indole_c --> []"
		"M_cadav_c_exchange::M_cadav_c --> []"
		"M_gaba_c_exchange::M_gaba_c --> []"
		"M_glycoA_c_exchange::M_glycoA_c --> []"
		"M_ala_L_c_exchange::[] --> M_ala_L_c"
		"M_ala_L_c_exchange_reverse::M_ala_L_c --> []"
		"M_arg_L_c_exchange::[] --> M_arg_L_c"
		"M_arg_L_c_exchange_reverse::M_arg_L_c --> []"
		"M_asn_L_c_exchange::[] --> M_asn_L_c"
		"M_asn_L_c_exchange_reverse::M_asn_L_c --> []"
		"M_asp_L_c_exchange::[] --> M_asp_L_c"
		"M_asp_L_c_exchange_reverse::M_asp_L_c --> []"
		"M_cys_L_c_exchange::[] --> M_cys_L_c"
		"M_cys_L_c_exchange_reverse::M_cys_L_c --> []"
		"M_glu_L_c_exchange::[] --> M_glu_L_c"
		"M_glu_L_c_exchange_reverse::M_glu_L_c --> []"
		"M_gln_L_c_exchange::[] --> M_gln_L_c"
		"M_gln_L_c_exchange_reverse::M_gln_L_c --> []"
		"M_gly_L_c_exchange::[] --> M_gly_L_c"
		"M_gly_L_c_exchange_reverse::M_gly_L_c --> []"
		"M_his_L_c_exchange::[] --> M_his_L_c"
		"M_his_L_c_exchange_reverse::M_his_L_c --> []"
		"M_ile_L_c_exchange::[] --> M_ile_L_c"
		"M_ile_L_c_exchange_reverse::M_ile_L_c --> []"
		"M_leu_L_c_exchange::[] --> M_leu_L_c"
		"M_leu_L_c_exchange_reverse::M_leu_L_c --> []"
		"M_lys_L_c_exchange::[] --> M_lys_L_c"
		"M_lys_L_c_exchange_reverse::M_lys_L_c --> []"
		"M_met_L_c_exchange::[] --> M_met_L_c"
		"M_met_L_c_exchange_reverse::M_met_L_c --> []"
		"M_phe_L_c_exchange::[] --> M_phe_L_c"
		"M_phe_L_c_exchange_reverse::M_phe_L_c --> []"
		"M_pro_L_c_exchange::[] --> M_pro_L_c"
		"M_pro_L_c_exchange_reverse::M_pro_L_c --> []"
		"M_ser_L_c_exchange::[] --> M_ser_L_c"
		"M_ser_L_c_exchange_reverse::M_ser_L_c --> []"
		"M_thr_L_c_exchange::[] --> M_thr_L_c"
		"M_thr_L_c_exchange_reverse::M_thr_L_c --> []"
		"M_trp_L_c_exchange::[] --> M_trp_L_c"
		"M_trp_L_c_exchange_reverse::M_trp_L_c --> []"
		"M_tyr_L_c_exchange::[] --> M_tyr_L_c"
		"M_tyr_L_c_exchange_reverse::M_tyr_L_c --> []"
		"M_val_L_c_exchange::[] --> M_val_L_c"
		"M_val_L_c_exchange_reverse::M_val_L_c --> []"
	];

	# List of metabolite strings - used to write flux report 
	list_of_metabolite_symbols = [
		"GENE_CAP"
		"GENE_ENZYME"
		"GENE_GLUCAGON"
		"GENE_Insulin"
		"GENE_LACI"
		"GENE_P19"
		"GENE_P28"
		"GENE_P38"
		"GENE_S19"
		"GENE_S28"
		"GENE_S38"
		"M_10fthf_c"
		"M_13dpg_c"
		"M_2ddg6p_c"
		"M_2pg_c"
		"M_3pg_c"
		"M_4abz_c"
		"M_4adochor_c"
		"M_5mthf_c"
		"M_5pbdra"
		"M_6pgc_c"
		"M_6pgl_c"
		"M_78dhf_c"
		"M_78mdp_c"
		"M_ac_c"
		"M_accoa_c"
		"M_actp_c"
		"M_adp_c"
		"M_aicar_c"
		"M_air_c"
		"M_akg_c"
		"M_ala_L_c"
		"M_ala_L_c_tRNA"
		"M_amp_c"
		"M_arg_L_c"
		"M_arg_L_c_tRNA"
		"M_asn_L_c"
		"M_asn_L_c_tRNA"
		"M_asp_L_c"
		"M_asp_L_c_tRNA"
		"M_atp_c"
		"M_cadav_c"
		"M_cair_c"
		"M_cdp_c"
		"M_chor_c"
		"M_cit_c"
		"M_clasp_c"
		"M_cmp_c"
		"M_co2_c"
		"M_coa_c"
		"M_ctp_c"
		"M_cys_L_c"
		"M_cys_L_c_tRNA"
		"M_dhap_c"
		"M_dhf_c"
		"M_e4p_c"
		"M_etoh_c"
		"M_f6p_c"
		"M_faicar_c"
		"M_fdp_c"
		"M_fgam_c"
		"M_fgar_c"
		"M_for_c"
		"M_fum_c"
		"M_g3p_c"
		"M_g6p_c"
		"M_gaba_c"
		"M_gar_c"
		"M_gdp_c"
		"M_glc_D_c"
		"M_gln_L_c"
		"M_gln_L_c_tRNA"
		"M_glu_L_c"
		"M_glu_L_c_tRNA"
		"M_glx_c"
		"M_gly_L_c"
		"M_gly_L_c_tRNA"
		"M_glycoA_c"
		"M_gmp_c"
		"M_gtp_c"
		"M_h2o2_c"
		"M_h2o_c"
		"M_h2s_c"
		"M_h_c"
		"M_hco3_c"
		"M_he_c"
		"M_his_L_c"
		"M_his_L_c_tRNA"
		"M_icit_c"
		"M_ile_L_c"
		"M_ile_L_c_tRNA"
		"M_imp_c"
		"M_indole_c"
		"M_lac_D_c"
		"M_leu_L_c"
		"M_leu_L_c_tRNA"
		"M_lys_L_c"
		"M_lys_L_c_tRNA"
		"M_mal_L_c"
		"M_met_L_c"
		"M_met_L_c_tRNA"
		"M_methf_c"
		"M_mglx_c"
		"M_mlthf_c"
		"M_mql8_c"
		"M_mqn8_c"
		"M_nad_c"
		"M_nadh_c"
		"M_nadp_c"
		"M_nadph_c"
		"M_nh3_c"
		"M_o2_c"
		"M_oaa_c"
		"M_omp_c"
		"M_or_c"
		"M_pep_c"
		"M_phe_L_c"
		"M_phe_L_c_tRNA"
		"M_pi_c"
		"M_ppi_c"
		"M_pro_L_c"
		"M_pro_L_c_tRNA"
		"M_prop_c"
		"M_prpp_c"
		"M_pyr_c"
		"M_q8_c"
		"M_q8h2_c"
		"M_r5p_c"
		"M_ru5p_D_c"
		"M_s7p_c"
		"M_saicar_c"
		"M_ser_L_c"
		"M_ser_L_c_tRNA"
		"M_succ_c"
		"M_succoa_c"
		"M_thf_c"
		"M_thr_L_c"
		"M_thr_L_c_tRNA"
		"M_trp_L_c"
		"M_trp_L_c_tRNA"
		"M_tyr_L_c"
		"M_tyr_L_c_tRNA"
		"M_udp_c"
		"M_ump_c"
		"M_utp_c"
		"M_val_L_c"
		"M_val_L_c_tRNA"
		"M_xmp_c"
		"M_xu5p_D_c"
		"OPEN_GENE_CAP"
		"OPEN_GENE_ENZYME"
		"OPEN_GENE_GLUCAGON"
		"OPEN_GENE_Insulin"
		"OPEN_GENE_LACI"
		"OPEN_GENE_P19"
		"OPEN_GENE_P28"
		"OPEN_GENE_P38"
		"OPEN_GENE_S19"
		"OPEN_GENE_S28"
		"OPEN_GENE_S38"
		"PROTEIN_CAP"
		"PROTEIN_ENZYME"
		"PROTEIN_GLUCAGON"
		"PROTEIN_Glucagon"
		"PROTEIN_Insulin"
		"PROTEIN_LACI"
		"PROTEIN_S19"
		"PROTEIN_S28"
		"PROTEIN_S38"
		"RIBOSOME"
		"RIBOSOME_START_CAP"
		"RIBOSOME_START_ENZYME"
		"RIBOSOME_START_GLUCAGON"
		"RIBOSOME_START_Insulin"
		"RIBOSOME_START_LACI"
		"RIBOSOME_START_S19"
		"RIBOSOME_START_S28"
		"RIBOSOME_START_S38"
		"RNAP"
		"cAMP"
		"mRNA_CAP"
		"mRNA_ENZYME"
		"mRNA_GLUCAGON"
		"mRNA_Insulin"
		"mRNA_LACI"
		"mRNA_P19"
		"mRNA_P28"
		"mRNA_P38"
		"mRNA_S19"
		"mRNA_S28"
		"mRNA_S38"
		"tRNA"
		"tRNA_c"
	];

	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{AbstractString,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["objective_coefficient_array"] = objective_coefficient_array
	data_dictionary["default_flux_bounds_array"] = default_bounds_array;
	data_dictionary["species_bounds_array"] = species_bounds_array
	data_dictionary["list_of_reaction_strings"] = list_of_reaction_strings
	data_dictionary["list_of_metabolite_symbols"] = list_of_metabolite_symbols
	data_dictionary["is_minimum_flag"] = is_minimum_flag
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
