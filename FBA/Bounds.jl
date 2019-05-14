function Bounds(DF,TXTL)

  FB = DF["default_flux_bounds_array"]
  AA_uptake = collect(416:2:454)
  AA_sec = collect(417:2:455)

  # FB[1,2] = kcat
  FB[387,2] = DF["Oxygen"]; #[]-> O2
  FB[399,2] = DF["GlcUptake"]; #[]-> GLC
  FB[403,2] = 0; #[]-> PYR
  FB[406,2] = 0
  FB[407,2] = 0
  FB[408,2] = 0
  FB[409,2] = 0
  FB[410,2] = 0
  for i = 1:length(AA_uptake)
    FB[AA_uptake[i],2] = 100
    FB[AA_sec[i],2] = 0
  end

#==============================================TXTL=====================================================#
  RNAP_concentration_nM = TXTL["RNAP_concentration_nM"];
  RNAP_elongation_rate = TXTL["RNAP_elongation_rate"];
  RIBOSOME_concentration = TXTL["RIBOSOME_concentration"]
  RIBOSOME_elongation_rate = TXTL["RIBOSOME_elongation_rate"];
  kd = TXTL["mRNA_degradation_rate"];
  mRNA_length = TXTL["mRNA_length"];
  protein_length = TXTL["protein_length"];
  gene_copies = TXTL["gene_copies"];
  volume = TXTL["volume"];
  polysome_amplification = TXTL["polysome_gain"];
  plasmid_saturation_coefficient = TXTL["plasmid_saturation_coefficient"];
  mRNA_saturation_coefficient = TXTL["mRNA_saturation_coefficient"];
  Promoter = TXTL["Promoter"]
  inducer = TXTL["inducer"]


#====================================Transcription===================================================#
  #Compute the promoter strength P -
  n = Promoter[1]
  KD = Promoter[2]
  K1 = Promoter[3]
  K2 = Promoter[4]
  K1_T7 = Promoter[5]
  f = inducer^n/(KD^n+inducer^n)
  if Promoter_model == 1
    P = (K1_T7)/(1+K1_T7)
  elseif Promoter_model == 2
    P = (K1+K2*f)/(1+K1+K2*f);
  end

  #Calculate Promoter functions. Need to assume values for inducers. Look at graph in Appendix of report.
  #define pLac variables (From Mackey et al 2014)
     IPTG = 50 #originally in molecules but changed LacI units. so now IPTG is in the same units as LacI (LacI): uM
     p3 =  2000#LacI uM at 1.25 hours
     K_G = 80 #uM
     G_e = 10000#uM. Converted from 180 mg/dl. 180 mg/dl = 10000 uM.
     m = 1.3
     p_p = 0.127
     k_pc = 300
     XI_1 = 17
     XI_2 = 0.85
     XI_3 = 0.17
     XI_1star = 0
     XI_2star = 430.6
     XI_3star = 1261.7

     #plac control function
     rho = ((p3)/(p3+IPTG))^2  #Replaced LacI with LacI concentration in uM
     p_c = (K_G^m)/(K_G^m + G_e^m)
     p_pc = p_p*((1+(k_pc-1)*p_c)/(1+(k_pc-1)*p_p*p_c))
     p_cp = p_c*((1+(k_pc-1)*p_p)/(1+(k_pc-1)*p_p*p_c))
     Z = 1*(1+XI_1*rho)*XI_1star*rho^2 + p_cp*(1+XI_2*rho)*XI_2star*rho^2 + 1*(1+XI_3*rho)*XI_3star*rho^2
     P_R = ((1+XI_2*rho)*(1+XI_3*rho)+XI_1star*rho^2)/(Z+(1+XI_1*rho)*(1+XI_2*rho)*(1+XI_3*rho))

     u_pLac = p_pc*P_R

     #define p70 and other promoter variables (from Vilklhovoy et al 2018)
     S_70 = 35*10 #nM S70 concentration
     K_S70 = 130 #nM dissociation constant
     n = 1
     W_1 = 0.014
     W_2 = 10

     #control function for P70,P19,P28
     F_P70=(S_70^n/(K_S70^n+S_70^n))   #P70 promoter
     F_P19=(5000^n/(K_S70^n+5000^n))   #P19 promoter. 5000 is the value of S19 at 1.25 hours (Appendix)
     F_P28=(7.5^n/(K_S70^n+7.5^n))   #P28 promoter. 7.5 is the value of S28 at 1.25 hours (Appendix)

     u_P70 = (W_1 + W_2*F_P70)/(1+W_1+W_2*F_P70)   #P70 promoter
     u_P19 = (W_2*F_P19)/(1+W_2*F_P19+W_2*100*12.5) #P19 promoter. 12.5 is the value of P19R at 1.25 hours (Appendix)
     u_P28 = (W_2*F_P28)/(1+W_2*F_P28) #P28 promoter

#_____________________
  #List mrna length of all genes being transcribed
  mRNA_length_S28 =  738
  mRNA_length_P19R = 708
  mRNA_length_LacI = 1083
  mRNA_length_CRP = 633
  mRNA_length_Enzyme = 4833
  mRNA_length_S19 = 522
  mRNA_length_Insulin = 1622
  mRNA_length_Glucagon = 543
  #Promoter Functions
  P_S28 = u_pLac
  P_P19R =  u_pLac
  P_LacI =  u_P70
  P_CRP =  u_P70
  P_Enzyme =  u_P70
  P_S19 =  u_P70
  P_Insulin =  u_P19
  P_Glucagon =  u_P28


  gene_concentration_S28 = 5
  gene_concentration_P19R = 500
  gene_concentration_LacI = 5000
  gene_concentration_CRP = 5
  gene_concentration_Enzyme = 15
  gene_concentration_S19 = 15
  gene_concentration_Insulin = 3
  gene_concentration_Glucagon = 8

  saturation_term_S28 = (gene_concentration_S28)/(plasmid_saturation_coefficient+gene_concentration_S28);
  saturation_term_P19R = (gene_concentration_P19R)/(plasmid_saturation_coefficient+gene_concentration_P19R);
  saturation_term_LacI = (gene_concentration_LacI)/(plasmid_saturation_coefficient+gene_concentration_LacI);
  saturation_term_CRP = (gene_concentration_CRP)/(plasmid_saturation_coefficient+gene_concentration_CRP);
  saturation_term_Enzyme = (gene_concentration_Enzyme)/(plasmid_saturation_coefficient+gene_concentration_Enzyme);
  saturation_term_S19 = (gene_concentration_S19)/(plasmid_saturation_coefficient+gene_concentration_S19);
  saturation_term_Insulin = (gene_concentration_Insulin)/(plasmid_saturation_coefficient+gene_concentration_Insulin);
  saturation_term_Glucagon = (gene_concentration_Glucagon)/(plasmid_saturation_coefficient+gene_concentration_Glucagon);

  RNAP_concentration = 75*10/1e6; #nM to mM

  # Update TX rates and mRNA length and corresponding Promoter Function
  TX_S28 = (RNAP_elongation_rate*(1/mRNA_length_S28)*(RNAP_concentration)*(saturation_term_S28)*3600)*P_S28;
  TX_P19R = (RNAP_elongation_rate*(1/mRNA_length_P19R)*(RNAP_concentration)*(saturation_term_P19R)*3600)*P_P19R;
  TX_LacI = (RNAP_elongation_rate*(1/mRNA_length_LacI)*(RNAP_concentration)*(saturation_term_LacI)*3600)*P_LacI;
  TX_CRP = (RNAP_elongation_rate*(1/mRNA_length_CRP)*(RNAP_concentration)*(saturation_term_CRP)*3600)*P_CRP;
  TX_Enzyme = (RNAP_elongation_rate*(1/mRNA_length_Enzyme)*(RNAP_concentration)*(saturation_term_Enzyme)*3600)*P_Enzyme;
  TX_S19 = (RNAP_elongation_rate*(1/mRNA_length_S19)*(RNAP_concentration)*(saturation_term_S19)*3600)*P_S19;
  TX_Insulin = (RNAP_elongation_rate*(1/mRNA_length_Insulin)*(RNAP_concentration)*(saturation_term_Insulin)*3600)*P_Insulin;
  TX_Glucagon = (RNAP_elongation_rate*(1/mRNA_length_Glucagon)*(RNAP_concentration)*(saturation_term_Glucagon)*3600)*P_Glucagon;


#====================================Translation===================================================#
  #Update mRNA steady state values, mRNA length and TL
  mRNA_steady_state_S28 = (TX_S28/1.2);
  mRNA_steady_state_P19R = (TX_P19R/1.2);
  mRNA_steady_state_LacI = (TX_LacI/1.2);
  mRNA_steady_state_CRP = (TX_CRP/1.2);
  mRNA_steady_state_Enzyme = (TX_Enzyme/1.2);
  mRNA_steady_state_S19 = (TX_S19/1.2);
  mRNA_steady_state_Insulin = (TX_Insulin/1.2);
  mRNA_steady_state_Glucagon = (TX_Glucagon/1.2);

  translation_rate_constant_S28 = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_S28)*3600;
  translation_rate_constant_P19R = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_P19R)*3600;
  translation_rate_constant_LacI = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_LacI)*3600;
  translation_rate_constant_CRP = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_CRP)*3600;
  translation_rate_constant_Enzyme = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_Enzyme)*3600;
  translation_rate_constant_S19 = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_S19)*3600;
  translation_rate_constant_Insulin = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_Insulin)*3600;
  translation_rate_constant_Glucagon = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length_Glucagon)*3600;

  TL_S28 = translation_rate_constant_S28*RIBOSOME_concentration*mRNA_steady_state_S28/(mRNA_saturation_coefficient+mRNA_steady_state_S28);
  TL_P19R = translation_rate_constant_P19R*RIBOSOME_concentration*mRNA_steady_state_P19R/(mRNA_saturation_coefficient+mRNA_steady_state_P19R);
  TL_LacI = translation_rate_constant_LacI*RIBOSOME_concentration*mRNA_steady_state_LacI/(mRNA_saturation_coefficient+mRNA_steady_state_LacI);
  TL_CRP = translation_rate_constant_CRP*RIBOSOME_concentration*mRNA_steady_state_CRP/(mRNA_saturation_coefficient+mRNA_steady_state_CRP);
  TL_Enzyme = translation_rate_constant_Enzyme*RIBOSOME_concentration*mRNA_steady_state_Enzyme/(mRNA_saturation_coefficient+mRNA_steady_state_Enzyme);
  TL_S19 = translation_rate_constant_S19*RIBOSOME_concentration*mRNA_steady_state_S19/(mRNA_saturation_coefficient+mRNA_steady_state_S19);
  TL_Insulin = translation_rate_constant_Insulin*RIBOSOME_concentration*mRNA_steady_state_Insulin/(mRNA_saturation_coefficient+mRNA_steady_state_Insulin);
  TL_Glucagon = translation_rate_constant_Glucagon*RIBOSOME_concentration*mRNA_steady_state_Glucagon/(mRNA_saturation_coefficient+mRNA_steady_state_Glucagon);


#===================================================================================================#
  FB[167,1] = TX_S28 #transcriptional initiation
  FB[167,2] = TX_S28 #transcriptional initiation
  FB[169,1] = TX_S28 #transcriptional initiation
  FB[169,2] = TX_S28 #mRNA_degradation
  FB[200,2] = TL_S28 #translations initiation

  FB[170,1] = TX_P19R #transcriptional initiation
  FB[170,2] = TX_P19R #transcriptional initiation
  FB[172,1] = TX_P19R #transcriptional initiation
  FB[172,2] = TX_P19R #mRNA_degradation
  FB[222,2] = TL_P19R #translations initiation

  FB[185,1] = TX_LacI #transcriptional initiation
  FB[185,2] = TX_LacI #transcriptional initiation
  FB[187,1] = TX_LacI #transcriptional initiation
  FB[187,2] = TX_LacI #mRNA_degradation
  FB[266,2] = TL_LacI #translations initiation

  FB[194,1] = TX_CRP #transcriptional initiation
  FB[194,2] = TX_CRP #transcriptional initiation
  FB[196,1] = TX_CRP #transcriptional initiation
  FB[196,2] = TX_CRP #mRNA_degradation
  FB[332,2] = TL_CRP #translations initiation

  FB[191,1] = TX_Enzyme #transcriptional initiation
  FB[191,2] = TX_Enzyme #transcriptional initiation
  FB[193,1] = TX_Enzyme #transcriptional initiation
  FB[193,2] = TX_Enzyme #mRNA_degradation
  FB[310,2] = TL_Enzyme #translations initiation

  FB[173,1] = TX_S19 #transcriptional initiation
  FB[173,2] = TX_S19 #transcriptional initiation
  FB[175,1] = TX_S19 #transcriptional initiation
  FB[175,2] = TX_S19 #mRNA_degradation
  FB[244,2] = TL_S19 #translations initiation

  FB[197,1] = TX_Insulin #transcriptional initiation
  FB[197,2] = TX_Insulin #transcriptional initiation
  FB[199,1] = TX_Insulin #transcriptional initiation
  FB[199,2] = TX_Insulin #mRNA_degradation
  FB[354,2] = TL_Insulin #translations initiation

  FB[188,1] = TX_Glucagon #transcriptional initiation
  FB[188,2] = TX_Glucagon #transcriptional initiation
  FB[190,1] = TX_Glucagon #transcriptional initiation
  FB[190,2] = TX_Glucagon #mRNA_degradation
  FB[288,2] = TL_Glucagon #translations initiation



  DF["default_flux_bounds_array"] = FB
  return DF
end
