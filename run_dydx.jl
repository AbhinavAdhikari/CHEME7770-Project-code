include("dydx.jl")

using ODE

#Setup Time Vector (in hours)
tStart = 0.0
tStep = 0.1
tStop = 2.50
tSim = collect(tStart:tStep:tStop)



#Setup initial conditions
x0 = [0.0; #m1
      0.0; #p1
      0.0; #m2
      0.0; #p2
      0.0; #m3
      0.0; #p3
      0.0; #m4
      0.0; #p4
      0.0; #m5
      0.0; #p5
      0.0; #m6
      0.0; #p6
      0.0; #m7
      0.0; #p7
      0.0; #m8
      0.0; #p8
    ]


f(t,x) = Balances(t,x)
t,X1 = ode23s(f,x0,tSim; points=:specified)

m1_1 = [a[1] for a in X1]  #S28 mRNA
p1_1 = [a[2] for a in X1]  #S28 protein
m2_1 = [a[3] for a in X1]  #P19Rep mRNA
p2_1 = [a[4] for a in X1]  #P19Rep protein
m3_1 = [a[5] for a in X1]  #LacI mRNA
p3_1 = [a[6] for a in X1]  #LacI protein
m4_1 = [a[7] for a in X1]  #CRP mRNA
p4_1 = [a[8] for a in X1]  #CRP protein
m5_1 = [a[9] for a in X1]  #Enzyme mRNA
p5_1 = [a[10] for a in X1] #Enzyme protein
m6_1 = [a[11] for a in X1] #S19 mRNA
p6_1 = [a[12] for a in X1] #S19 protein
m7_1 = [a[13] for a in X1] #Insulin mRNA
p7_1 = [a[14] for a in X1] #Insulin protein
m8_1 = [a[15] for a in X1] #Glucagon mRNA
p8_1 = [a[16] for a in X1] #Glucagon protein

using Plots
pp=[p7_1*1000 p8_1*1000]

plot(t,pp,title="Glucose concentration = 10000 uM",xlabel="time (hours)",ylabel="Protein concentration (uM)",labels=["Insulin","Glucagon"])
#savefig("High Glucose")
