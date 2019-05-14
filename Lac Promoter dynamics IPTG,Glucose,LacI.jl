#define pLac variables (From Mackey et al 2014)
IPTG = 20000.0 #originally in molecules but changed LacI units. so now IPTG is in the same units as LacI (LacI): uM
K_G = 2.6 #uM
G_e = 1000.0 #uM. Conversion: 180 mg/dl = 10000 uM
m = 1.3
p_p = 0.127
k_pc = 30.0
XI_1 = 17.0
XI_2 = 0.85
XI_3 = 0.17
XI_1star = 0.0
XI_2star = 430.6
XI_3star = 1261.7


p3 = collect(0:0.1:10000)
rho = similar(p3)
p_c = similar(p3)
p_pc = similar(p3)
p_cp = similar(p3)
Z = similar(p3)
P_R = similar(p3)
u_pLac = similar(p3)

# plac control function
for i in 1:length(p3)
    rho[i] = ((p3[i])/(p3[i]+IPTG))^2  #Replaced LacI with LacI concentration.
    p_c[i] = (K_G^m)/(K_G^m + G_e^m)
    p_pc[i] = p_p*((1.0+(k_pc-1.0)*p_c[i])/(1.0+(k_pc-1.0)*p_p*p_c[i]))
    p_cp[i] = p_c[i]*((1+(k_pc-1)*p_p)/(1+(k_pc-1)*p_p*p_c[i]))
    Z[i] = 1*(1+XI_1*rho[i])*XI_1star*rho[i]^2 + p_cp[i]*(1+XI_2*rho[i])*XI_2star*rho[i]^2 + 1*(1+XI_3*rho[i])*XI_3star*rho[i]^2
    P_R[i] = ((1+XI_2*rho[i])*(1+XI_3*rho[i])+XI_1star*rho[i]^2)/(Z[i]+(1+XI_1*rho[i])*(1+XI_2*rho[i])*(1+XI_3*rho[i]))
    u_pLac[i] = p_pc[i]*P_R[i]
end

using Plots
#plot(p3,u_pLac,ylabel="u_pLac",xlabel="[LacI]",title="IPTG=$IPTG uM",labels=["glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM"])
plot!(p3,u_pLac,ylabel="u_pLac",xlabel="[LacI]",title="IPTG=$IPTG uM",labels=["glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM","glucose=$G_e uM"])
#plot(p3,u_pLac,ylabel="u_pLac",xlabel="[LacI]",title="Glucose=$G_e uM",labels=["IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM"])
#plot!(p3,u_pLac,ylabel="u_pLac",xlabel="[LacI]",title="Glucose=$G_e uM",labels=["IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM","IPTG=$IPTG uM"])
#savefig("u_pLac vs LacI with changing [IPTG]_ORIGINAL PARAMETERS")
