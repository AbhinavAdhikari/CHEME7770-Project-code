function Balances(t,x)

    #Define x species vector
    m1 = x[1] #S28 mRNA
    p1 = x[2] #S28 protein
    m2 = x[3] #P19Rep mRNA
    p2 = x[4] #P19Rep protein
    m3 = x[5] #LacI mRNA
    p3 = x[6] #LacI protein
    m4 = x[7] #CRP mRNA
    p4 = x[8] #CRP protein
    m5 = x[9] #Enzyme mRNA
    p5 = x[10] #Enzyme protein
    m6 = x[11] #S19 mRNA
    p6 = x[12] #S19 protein
    m7 = x[13] #Insulin mRNA
    p7 = x[14] #Insulin protein
    m8 = x[15] #Glucagon mRNA
    p8 = x[16] #Glucagon protein

    #CONTROL FUNCTION FORMULATION

    #define pLac variables (From Mackey et al 2014)
    IPTG = 50 #originally in molecules but changed LacI units. so now IPTG is in the same units as LacI (LacI): uM
    #LacI = 8.2*10^5 #molecules per average-size bacterium
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
    rho = ((p3*1000)/(p3*1000+IPTG))^2  #Replaced LacI with LacI concentration in uM
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
    F_P19=(p6^n/(K_S70^n+p6^n))   #P19 promoter
    F_P28=(p1^n/(K_S70^n+p1^n))   #P28 promoter

    u_P70 = (W_1 + W_2*F_P70)/(1+W_1+W_2*F_P70)   #P70 promoter
    u_P19 = (W_2*F_P19)/(1+W_2*F_P19+W_2*100*p2) #P19 promoter
    u_P28 = (W_2*F_P28)/(1+W_2*F_P28) #P28 promoter

    ###Now write TX TL rates. First TX.

    ### Transcription rate constants and equations.

    gene_concentration = Array{Float64}([ #nM
        5  ;   #S28
        500 ;   #P19Rep
        5000  ;   #LacI
        5  ;   #CRP
        15  ;   #Enzyme
        15 ;   #S19
        3 ;   #Insulin
        8  ;   #Glucagon
    ]);

    plasmid_saturation_coefficient = 3.5 #nM
    RNAP_elongation_rate = 25 #nt/s
    RNAP_concentration = 75*10/1e6 #mM

    #Promoter Control terms
    u_i = Array{Float64}([
        u_pLac ; #S28
        u_pLac ; #P19Rep
        u_P70  ; #LacI
        u_P70  ; #CRP
        u_P70  ; #Enzyme
        u_P70  ; #S19
        u_P19  ; #Insulin
        u_P28  ; #Glucagon
    ]);

    mRNA_length = Array{Float64}([ #nt
        738 ;   #S28
        708 ;   #P19Rep Assumed length of CI lambda repressor for now
        1083;   #LacI
        633 ;   #CRP
        4833;   #Enzyme
        522 ;   #S19
        1622;   #Insulin. Codes for Preproinsulin.
        543 ;   #Glucagon
    ]);

    # Write TX equation

    saturation_term=similar(gene_concentration);
    TX=similar(gene_concentration);
    for i in 1:length(gene_concentration)
        saturation_term[i] = (gene_concentration[i])/(plasmid_saturation_coefficient+gene_concentration[i]);
        TX[i] = (RNAP_elongation_rate*(1/mRNA_length[i])*(RNAP_concentration)*(saturation_term[i])*3600)*u_i[i]; #in mM per hour
    end

    ### Translation rate constants and equations.

    mRNA_degradation_rate = 1.2 ; #per hour. reduced from 5.2 per hour.
    mRNA_steady_state = similar(TX);
    for i in 1:length(TX)
        mRNA_steady_state[i] = TX[i]/mRNA_degradation_rate
    end

    polysome_amplification = 10 ;
    RIBOSOME_elongation_rate = 2 ;#Amino Acids per second
    RIBOSOME_concentration = 0.0016*10 ; #mM
    mRNA_saturation_coefficient = 0.045 #mM
    #Write TL equation
    translation_rate_constant=similar(TX)
    TL=similar(TX)
    for i in 1:length(TX)
        translation_rate_constant[i] = polysome_amplification*(3*RIBOSOME_elongation_rate)*(1/mRNA_length[i])*3600;
        TL[i] = translation_rate_constant[i]*RIBOSOME_concentration*mRNA_steady_state[i]/(mRNA_saturation_coefficient+mRNA_steady_state[i]); #in mM protein per hour
    end


    #Setup Mass Balances
    dxdt = similar(x)
    dxdt[1]  = TX[1] #S28 mRNA
    dxdt[2]  = TL[1] #S28 protein
    dxdt[3]  = TX[2] #P19Rep mRNA
    dxdt[4]  = TL[2] #P19Rep protein
    dxdt[5]  = TX[3] #LacI mRNA
    dxdt[6]  = TL[3] #LacI protein
    dxdt[7]  = TX[4] #CRP mRNA
    dxdt[8]  = TL[4] #CRP protein
    dxdt[9]  = TX[5] #Enzyme mRNA
    dxdt[10] = TL[5] #Enzyme protein
    dxdt[11] = TX[6] #S19 mRNA
    dxdt[12] = TL[6] #S19 protein
    dxdt[13] = TX[7] #Insulin mRNA
    dxdt[14] = TL[7] #Insulin protein
    dxdt[15] = TX[8] #Glucagon mRNA
    dxdt[16] = TL[8] #Glucagon protein
    return dxdt

end
