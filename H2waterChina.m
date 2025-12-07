%Codes of 'Addressing water resource constrained green hydrogen demand in China'
%Copyright (c) 2025 Hongyi Xie(BNU/FDU/NUS), Guo Yang(BNU/NUS)and Yutao Wang(FDU)
%All rights reserved. Contect email:xiehyeco@163.com
clear
clc
set(0,'defaultfigurecolor','w')
LQ=csvread('Input_H2.csv');
WC=LQ(:,1:2);%1&2-NO,3-constrained,BAU level
D=LQ(:,13:88);% Demands for sectors and counties,t
%%%%% convert demand to products or replaced issues by sectors, P:1,2-APS2030,2050;3,4-CHA2030,2050
P_power(:,1:2)=D(:,1:2).*23.33;%electricity, MWh
P_power(:,3:4)=D(:,31:32).*23.33;
P_building(:,1:2)=D(:,3:4).*33340;%heat, KWh
P_building(:,3:4)=D(:,33:34).*33340;
P_truck(:,1:2)=D(:,5:6).*3.9.*0.9984;%diesel, t
P_truck(:,3:4)=D(:,35:36).*3.9.*0.9984;
P_truck(:,5:6)=D(:,5:6).*30.*0.0016;%electricity, MWh
P_truck(:,7:8)=D(:,35:36).*30.*0.0016;
P_bus(:,1:2)=D(:,7:8).*3.9.*0.4247;%diesel, t
P_bus(:,3:4)=D(:,37:38).*3.9.*0.4247;
P_bus(:,5:6)=D(:,7:8).*30.*0.5753;%electricity, MWh
P_bus(:,7:8)=D(:,37:38).*30.*0.5753;
P_car(:,1:2)=D(:,9:10).*5.2.*0.9825;%gasoline, t
P_car(:,3:4)=D(:,39:40).*5.2.*0.9825;
P_car(:,5:6)=D(:,9:10).*30.*0.0175;%electricity, MWh
P_car(:,7:8)=D(:,39:40).*30.*0.0175;
P_ship(:,1:2)=D(:,11:12).*3.7;%bunker oil, t
P_ship(:,3:4)=D(:,41:42).*3.7;
P_air(:,1:2)=D(:,13:14).*4.58;%aviation kerosene, t
P_air(:,3:4)=D(:,43:44).*4.58;
P_ammonia(:,1:2)=D(:,15:16)./0.204;%ammonia, t
P_ammonia(:,3:4)=D(:,45:46)./0.204;
P_methanol(:,1:2)=D(:,17:18)./0.162;%methanol, t
P_methanol(:,3:4)=D(:,47:48)./0.162;
P_oil(:,1:2)=D(:,61:62)./0.313;%oil, t
P_oil(:,3:4)=D(:,69:70)./0.313;
P_ng(:,1:2)=D(:,63:64)./0.311;%ng, t
P_ng(:,3:4)=D(:,71:72)./0.311;
P_olefin(:,1:2)=D(:,65:66)./0.417;%olefin, t
P_olefin(:,3:4)=D(:,73:74)./0.417;
P_eg(:,1:2)=D(:,67:68)./0.266;%eg, t
P_eg(:,3:4)=D(:,75:76)./0.266;
P_metallurgy(:,1:2)=D(:,21:22).*5.963;%coke, t
P_metallurgy(:,3:4)=D(:,51:52).*5.963;
P_refining(:,1:2)=D(:,27:28);%gray H2, t
P_refining(:,3:4)=D(:,57:58);
P_fuel(:,1:2)=D(:,23:24).*33340;%kWh heat, t
P_fuel(:,3:4)=D(:,53:54).*33340;
P_synfuel(:,1:2)=D(:,25:26);%gray H2, t
P_synfuel(:,3:4)=D(:,55:56);
%%%%%% GHG changes from onsite and upstream processes
EF_power=csvread('EF_power.csv');% 1-2020,2-2030,3-2050
GHG_OU_power(:,1)=P_power(:,1).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_power(:,2)=P_power(:,2).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_power(:,3)=P_power(:,3).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_power(:,4)=P_power(:,4).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_building(:,1)=P_building(:,1).*0.35./1000./10^6.*(1-0.2);%MtCO2eq
GHG_OU_building(:,2)=P_building(:,2).*0.35./1000./10^6.*(1-0.41);%MtCO2eq
GHG_OU_building(:,3)=P_building(:,3).*0.35./1000./10^6.*(1-0.2);%MtCO2eq
GHG_OU_building(:,4)=P_building(:,4).*0.35./1000./10^6.*(1-0.41);%MtCO2eq
GHG_OU_truck(:,1)=P_truck(:,1).*(0.67+3.1863).*(1-0.12)./10^6+P_truck(:,5).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_truck(:,2)=P_truck(:,2).*(0.67+3.1863).*(1-0.36)./10^6+P_truck(:,6).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_truck(:,3)=P_truck(:,3).*(0.67+3.1863).*(1-0.12)./10^6+P_truck(:,7).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_truck(:,4)=P_truck(:,4).*(0.67+3.1863).*(1-0.36)./10^6+P_truck(:,8).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_bus(:,1)=P_bus(:,1).*(0.67+3.1863).*(1-0.12)./10^6+P_bus(:,5).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_bus(:,2)=P_bus(:,2).*(0.67+3.1863).*(1-0.36)./10^6+P_bus(:,6).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_bus(:,3)=P_bus(:,3).*(0.67+3.1863).*(1-0.12)./10^6+P_bus(:,7).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_bus(:,4)=P_bus(:,4).*(0.67+3.1863).*(1-0.36)./10^6+P_bus(:,8).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_car(:,1)=P_car(:,1).*(3.09+0.81).*(1-0.12)./10^6+P_car(:,5).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_car(:,2)=P_car(:,2).*(3.09+0.81).*(1-0.36)./10^6+P_car(:,6).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_car(:,3)=P_car(:,3).*(3.09+0.81).*(1-0.12)./10^6+P_car(:,7).*EF_power(:,2)./10^6;%MtCO2eq
GHG_OU_car(:,4)=P_car(:,4).*(3.09+0.81).*(1-0.36)./10^6+P_car(:,8).*EF_power(:,3)./10^6;%MtCO2eq
GHG_OU_ship(:,1)=P_ship(:,1).*(3.155+2.2).*(1-0.12)./10^6;%MtCO2eq
GHG_OU_ship(:,2)=P_ship(:,2).*(3.155+2.2).*(1-0.36)./10^6;%MtCO2eq
GHG_OU_ship(:,3)=P_ship(:,3).*(3.155+2.2).*(1-0.12)./10^6;%MtCO2eq
GHG_OU_ship(:,4)=P_ship(:,4).*(3.155+2.2).*(1-0.36)./10^6;%MtCO2eq
GHG_OU_air(:,1)=P_air(:,1).*(3.15+1.26).*(1-0.197)./10^6;%MtCO2eq
GHG_OU_air(:,2)=P_air(:,2).*(3.15+1.26).*(1-0.59)./10^6;%MtCO2eq
GHG_OU_air(:,3)=P_air(:,3).*(3.15+1.26).*(1-0.197)./10^6;%MtCO2eq
GHG_OU_air(:,4)=P_air(:,4).*(3.15+1.26).*(1-0.59)./10^6;%MtCO2eq
GHG_OU_refining(:,1)=P_refining(:,1).*24.67.*(1+0.077)./10^6;%MtCO2eq
GHG_OU_refining(:,2)=P_refining(:,2).*24.67.*(1+0.103)./10^6;%MtCO2eq
GHG_OU_refining(:,3)=P_refining(:,3).*24.67.*(1+0.077)./10^6;%MtCO2eq
GHG_OU_refining(:,4)=P_refining(:,4).*24.67.*(1+0.103)./10^6;%MtCO2eq
GHG_OU_synfuel(:,1)=P_synfuel(:,1).*24.67.*(1+0.077)./10^6;%MtCO2eq
GHG_OU_synfuel(:,2)=P_synfuel(:,2).*24.67.*(1+0.103)./10^6;%MtCO2eq
GHG_OU_synfuel(:,3)=P_synfuel(:,3).*24.67.*(1+0.077)./10^6;%MtCO2eq
GHG_OU_synfuel(:,4)=P_synfuel(:,4).*24.67.*(1+0.103)./10^6;%MtCO2eq
GHG_OU_fuel(:,1)=P_fuel(:,1).*0.15.*(1-0.043)./1000./10^6;%MtCO2eq
GHG_OU_fuel(:,2)=P_fuel(:,2).*0.15.*(1-0.087)./1000./10^6;%MtCO2eq
GHG_OU_fuel(:,3)=P_fuel(:,3).*0.15.*(1-0.043)./1000./10^6;%MtCO2eq
GHG_OU_fuel(:,4)=P_fuel(:,4).*0.15.*(1-0.087)./1000./10^6;%MtCO2eq
GHG_OU_metallurgy(:,1)=P_metallurgy(:,1).*(4.29-0.61.*0.12)./10^6;%MtCO2eq
GHG_OU_metallurgy(:,2)=P_metallurgy(:,2).*(4.29-0.61.*0.577)./10^6;%MtCO2eq
GHG_OU_metallurgy(:,3)=P_metallurgy(:,3).*(4.29-0.61.*0.12)./10^6;%MtCO2eq
GHG_OU_metallurgy(:,4)=P_metallurgy(:,4).*(4.29-0.61.*0.577)./10^6;%MtCO2eq
GHG_OU_ammonia(:,1:4)=P_ammonia(:,1:4).*3.14./10^6+P_ammonia(:,1:4).*(0.204.*8.*0.118)./10^6+P_ammonia(:,1:4).*((0.204.*8).*0.288+(0.204.*8.*0.0591).*0.18+0.204.*0.85.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_methanol(:,1:4)=P_methanol(:,1:4).*2.49./10^6+P_methanol(:,1:4).*(0.162.*8.*0.118)./10^6+P_methanol(:,1:4).*((0.162.*8).*0.288+(0.162.*8.*0.0591).*0.18+0.162.*0.28.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_oil(:,1:4)=P_oil(:,1:4).*4.28./10^6+P_oil(:,1:4).*(0.313.*8.*0.118)./10^6+P_oil(:,1:4).*((0.313.*8).*0.288+(0.313.*8.*0.0591).*0.18+0.313.*1.1.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_ng(:,1:4)=P_ng(:,1:4).*4.8./10^6+P_ng(:,1:4).*(0.311.*8.*0.118)./10^6+P_ng(:,1:4).*((0.311.*8).*0.288+(0.311.*8.*0.0591).*0.18+0.311.*0.25.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_olefin(:,1:4)=P_olefin(:,1:4).*6.43./10^6+P_olefin(:,1:4).*(0.417.*8.*0.118)./10^6+P_olefin(:,1:4).*((0.417.*8).*0.288+(0.417.*8.*0.0591).*0.18+0.417.*2.69.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_eg(:,1:4)=P_eg(:,1:4).*4.10./10^6+P_eg(:,1:4).*(0.266.*8.*0.118)./10^6+P_eg(:,1:4).*((0.266.*8).*0.288+(0.266.*8.*0.0591).*0.18+0.266.*0.62.*EF_power(:,1))./10^6;%MtCO2eq,grid power
GHG_OU_ammonia(:,1)=GHG_OU_ammonia(:,1).*(1-0.225);
GHG_OU_ammonia(:,3)=GHG_OU_ammonia(:,3).*(1-0.225);
GHG_OU_ammonia(:,2)=GHG_OU_ammonia(:,2).*(1-0.676);
GHG_OU_ammonia(:,4)=GHG_OU_ammonia(:,4).*(1-0.676);
GHG_OU_methanol(:,1)=GHG_OU_methanol(:,1).*(1-0.193);
GHG_OU_methanol(:,3)=GHG_OU_methanol(:,3).*(1-0.193);
GHG_OU_methanol(:,2)=GHG_OU_methanol(:,2).*(1-0.579);
GHG_OU_methanol(:,4)=GHG_OU_methanol(:,4).*(1-0.579);
GHG_OU_oil(:,1)=GHG_OU_oil(:,1).*(1-0.205);
GHG_OU_oil(:,3)=GHG_OU_oil(:,3).*(1-0.205);
GHG_OU_oil(:,2)=GHG_OU_oil(:,2).*(1-0.614);
GHG_OU_oil(:,4)=GHG_OU_oil(:,4).*(1-0.614);
GHG_OU_ng(:,1)=GHG_OU_ng(:,1).*(1-0.187);
GHG_OU_ng(:,3)=GHG_OU_ng(:,3).*(1-0.187);
GHG_OU_ng(:,2)=GHG_OU_ng(:,2).*(1-0.56);
GHG_OU_ng(:,4)=GHG_OU_ng(:,4).*(1-0.56);
GHG_OU_olefin(:,1)=GHG_OU_olefin(:,1).*(1-0.209);
GHG_OU_olefin(:,3)=GHG_OU_olefin(:,3).*(1-0.209);
GHG_OU_olefin(:,2)=GHG_OU_olefin(:,2).*(1-0.627);
GHG_OU_olefin(:,4)=GHG_OU_olefin(:,4).*(1-0.627);
GHG_OU_eg(:,1)=GHG_OU_eg(:,1).*(1-0.167);
GHG_OU_eg(:,3)=GHG_OU_eg(:,3).*(1-0.167);
GHG_OU_eg(:,2)=GHG_OU_eg(:,2).*(1-0.5);
GHG_OU_eg(:,4)=GHG_OU_eg(:,4).*(1-0.5);
%%%%% GHG from Green H2 production MtCO2eq
CF=csvread('CFcsv.csv');%3-EF of onsite PV，4-EF of onsite Wind
for j=1:2:75
GHG_PRO_grid(:,j)=D(:,j)./0.95.*(0.083.*(1-0.005)+0.227.*(1-0.126)+57.9.*EF_power(:,2))./10^6;%2030
GHG_PRO_pv(:,j)=D(:,j)./0.95.*(0.083.*(1-0.005)+0.194.*(1-0.298)+0.227.*(1-0.126)+57.9.*(1-0.267).*CF(:,3))./10^6;
GHG_PRO_wind(:,j)=D(:,j)./0.95.*(0.083.*(1-0.005)+0.194.*(1-0.298)+0.227.*(1-0.126)+57.9.*(1-0.733).*CF(:,4))./10^6;
GHG_PRO_grid(:,j+1)=D(:,j+1)./0.95.*(0.083.*(1-0.675)+0.227.*(1-0.378)+57.9.*EF_power(:,3))./10^6;%2050
GHG_PRO_pv(:,j+1)=D(:,j+1)./0.95.*(0.083.*(1-0.675)+0.194.*(1-0.855)+0.227.*(1-0.378)+57.9.*(1-0.163).*CF(:,3))./10^6;
GHG_PRO_wind(:,j+1)=D(:,j+1)./0.95.*(0.083.*(1-0.675)+0.194.*(1-0.855)+0.227.*(1-0.378)+57.9.*(1-0.357).*CF(:,4))./10^6;
end
%%%%%% GHG changes from water withdrawal
D_power(:,1:2)=D(:,1:2);%t
D_power(:,3:4)=D(:,31:32);
D_building(:,1:2)=D(:,3:4);
D_building(:,3:4)=D(:,33:34);
D_truck(:,1:2)=D(:,5:6);
D_truck(:,3:4)=D(:,35:36);
D_bus(:,1:2)=D(:,7:8);
D_bus(:,3:4)=D(:,37:38);
D_car(:,1:2)=D(:,9:10);
D_car(:,3:4)=D(:,39:40);
D_ship(:,1:2)=D(:,11:12);
D_ship(:,3:4)=D(:,41:42);
D_air(:,1:2)=D(:,13:14);
D_air(:,3:4)=D(:,43:44);
D_ammonia(:,1:2)=D(:,15:16);
D_ammonia(:,3:4)=D(:,45:46);
D_methanol(:,1:2)=D(:,17:18);
D_methanol(:,3:4)=D(:,47:48);
D_oil(:,1:2)=D(:,61:62);
D_oil(:,3:4)=D(:,69:70);
D_ng(:,1:2)=D(:,63:64);
D_ng(:,3:4)=D(:,71:72);
D_olefin(:,1:2)=D(:,65:66);
D_olefin(:,3:4)=D(:,73:74);
D_eg(:,1:2)=D(:,67:68);
D_eg(:,3:4)=D(:,75:76);
D_metallurgy(:,1:2)=D(:,21:22);
D_metallurgy(:,3:4)=D(:,51:52);
D_refining(:,1:2)=D(:,27:28);
D_refining(:,3:4)=D(:,57:58);
D_fuel(:,1:2)=D(:,23:24);
D_fuel(:,3:4)=D(:,53:54);
D_synfuel(:,1:2)=D(:,25:26);
D_synfuel(:,3:4)=D(:,55:56);
GHG_WW_power_grid(:,1:4)=(P_power(:,1:4).*0.0007430555555556-D_power(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_power_pv(:,1:4)=(P_power(:,1:4).*0.0007430555555556-D_power(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_power_wind(:,1:4)=(P_power(:,1:4).*0.0007430555555556-D_power(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_building_grid(:,1:4)=(P_building(:,1:4).*0.00073-D_building(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_building_pv(:,1:4)=(P_building(:,1:4).*0.00073-D_building(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_building_wind(:,1:4)=(P_building(:,1:4).*0.00073-D_building(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_truck_grid(:,1:4)=(P_truck(:,1:4).*0.42+P_truck(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_truck_pv(:,1:4)=(P_truck(:,1:4).*0.42+P_truck(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_truck_wind(:,1:4)=(P_truck(:,1:4).*0.42+P_truck(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_bus_grid(:,1:4)=(P_bus(:,1:4).*0.42+P_bus(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_bus_pv(:,1:4)=(P_bus(:,1:4).*0.42+P_bus(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_bus_wind(:,1:4)=(P_bus(:,1:4).*0.42+P_bus(:,5:8).*0.0007430555555556-D_truck(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_car_grid(:,1:4)=(P_car(:,1:4).*0.5+P_car(:,5:8).*0.0007430555555556-D_car(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_car_pv(:,1:4)=(P_car(:,1:4).*0.5+P_car(:,5:8).*0.0007430555555556-D_car(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_car_wind(:,1:4)=(P_car(:,1:4).*0.5+P_car(:,5:8).*0.0007430555555556-D_car(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_ship_grid(:,1:4)=(P_ship(:,1:4).*0.24-D_ship(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_ship_pv(:,1:4)=(P_ship(:,1:4).*0.24-D_ship(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_ship_wind(:,1:4)=(P_ship(:,1:4).*0.24-D_ship(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_air_grid(:,1:4)=(P_air(:,1:4).*0.27-D_air(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_air_pv(:,1:4)=(P_air(:,1:4).*0.27-D_air(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_air_wind(:,1:4)=(P_air(:,1:4).*0.27-D_air(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_ammonia_grid(:,1:4)=(P_ammonia(:,1:4).*(0.39+1.3).*2.96-D_ammonia(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_ammonia_pv(:,1:4)=(P_ammonia(:,1:4).*(0.39+1.3).*2.96-D_ammonia(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_ammonia_wind(:,1:4)=(P_ammonia(:,1:4).*(0.39+1.3).*2.96-D_ammonia(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_methanol_grid(:,1:4)=(P_methanol(:,1:4).*(0.78+1.4).*2.96-D_methanol(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_methanol_pv(:,1:4)=(P_methanol(:,1:4).*(0.78+1.4).*2.96-D_methanol(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_methanol_wind(:,1:4)=(P_methanol(:,1:4).*(0.78+1.4).*2.96-D_methanol(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_oil_grid(:,1:4)=(P_oil(:,1:4).*(3.7+1.04).*2.96-D_oil(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_oil_pv(:,1:4)=(P_oil(:,1:4).*(3.7+1.04).*2.96-D_oil(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_oil_wind(:,1:4)=(P_oil(:,1:4).*(3.7+1.04).*2.96-D_oil(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_ng_grid(:,1:4)=(P_ng(:,1:4).*(3.1+0.76).*2.96-D_ng(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_ng_pv(:,1:4)=(P_ng(:,1:4).*(3.1+0.76).*2.96-D_ng(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_ng_wind(:,1:4)=(P_ng(:,1:4).*(3.1+0.76).*2.96-D_ng(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_olefin_grid(:,1:4)=(P_olefin(:,1:4).*(5+1.2).*2.96-D_olefin(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_olefin_pv(:,1:4)=(P_olefin(:,1:4).*(5+1.2).*2.96-D_olefin(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_olefin_wind(:,1:4)=(P_olefin(:,1:4).*(5+1.2).*2.96-D_olefin(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_eg_grid(:,1:4)=(P_eg(:,1:4).*(2.7+2.98).*2.96-D_eg(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_eg_pv(:,1:4)=(P_eg(:,1:4).*(2.7+2.98).*2.96-D_eg(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_eg_wind(:,1:4)=(P_eg(:,1:4).*(2.7+2.98).*2.96-D_eg(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_metallurgy_grid(:,1:4)=(P_metallurgy(:,1:4).*2.76-D_metallurgy(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_metallurgy_pv(:,1:4)=(P_metallurgy(:,1:4).*2.76-D_metallurgy(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_metallurgy_wind(:,1:4)=(P_metallurgy(:,1:4).*2.76-D_metallurgy(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_refining_grid(:,1:4)=(P_refining(:,1:4).*49.78-D_refining(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_refining_pv(:,1:4)=(P_refining(:,1:4).*49.78-D_refining(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_refining_wind(:,1:4)=(P_refining(:,1:4).*49.78-D_refining(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_fuel_grid(:,1:4)=(P_fuel(:,1:4).*0.05-D_fuel(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_fuel_pv(:,1:4)=(P_fuel(:,1:4).*0.05-D_fuel(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_fuel_wind(:,1:4)=(P_fuel(:,1:4).*0.05-D_fuel(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;
GHG_WW_synfuel_grid(:,1:4)=(P_synfuel(:,1:4).*49.78-D_synfuel(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)).*0.00000019./10^6;%MtCO2eq
GHG_WW_synfuel_pv(:,1:4)=(P_synfuel(:,1:4).*49.78-D_synfuel(:,1:4)./0.95.*(32.24+24+124+5.34)).*0.00000019./10^6;
GHG_WW_synfuel_wind(:,1:4)=(P_synfuel(:,1:4).*49.78-D_synfuel(:,1:4)./0.95.*(32.24+24+11+5.34)).*0.00000019./10^6;

GHG_WW_power_grid(:,1)=GHG_WW_power_grid(:,1).*(1-0.318);
GHG_WW_power_grid(:,2)=GHG_WW_power_grid(:,2).*(1-0.683);
GHG_WW_power_grid(:,3)=GHG_WW_power_grid(:,3).*(1-0.318);
GHG_WW_power_grid(:,4)=GHG_WW_power_grid(:,4).*(1-0.683);
GHG_WW_power_pv(:,1)=GHG_WW_power_pv(:,1).*(1-0.318);
GHG_WW_power_pv(:,2)=GHG_WW_power_pv(:,2).*(1-0.683);
GHG_WW_power_pv(:,3)=GHG_WW_power_pv(:,3).*(1-0.318);
GHG_WW_power_pv(:,4)=GHG_WW_power_pv(:,4).*(1-0.683);
GHG_WW_power_wind(:,1)=GHG_WW_power_wind(:,1).*(1-0.318);
GHG_WW_power_wind(:,2)=GHG_WW_power_wind(:,2).*(1-0.683);
GHG_WW_power_wind(:,3)=GHG_WW_power_wind(:,3).*(1-0.318);
GHG_WW_power_wind(:,4)=GHG_WW_power_wind(:,4).*(1-0.683);
GHG_WW_building_grid(:,1)=GHG_WW_building_grid(:,1).*(1-0.318);
GHG_WW_building_grid(:,2)=GHG_WW_building_grid(:,2).*(1-0.683);
GHG_WW_building_grid(:,3)=GHG_WW_building_grid(:,3).*(1-0.318);
GHG_WW_building_grid(:,4)=GHG_WW_building_grid(:,4).*(1-0.683);
GHG_WW_building_pv(:,1)=GHG_WW_building_pv(:,1).*(1-0.318);
GHG_WW_building_pv(:,2)=GHG_WW_building_pv(:,2).*(1-0.683);
GHG_WW_building_pv(:,3)=GHG_WW_building_pv(:,3).*(1-0.318);
GHG_WW_building_pv(:,4)=GHG_WW_building_pv(:,4).*(1-0.683);
GHG_WW_building_wind(:,1)=GHG_WW_building_wind(:,1).*(1-0.318);
GHG_WW_building_wind(:,2)=GHG_WW_building_wind(:,2).*(1-0.683);
GHG_WW_building_wind(:,3)=GHG_WW_building_wind(:,3).*(1-0.318);
GHG_WW_building_wind(:,4)=GHG_WW_building_wind(:,4).*(1-0.683);
GHG_WW_truck_grid(:,1)=GHG_WW_truck_grid(:,1).*(1-0.318);
GHG_WW_truck_grid(:,2)=GHG_WW_truck_grid(:,2).*(1-0.683);
GHG_WW_truck_grid(:,3)=GHG_WW_truck_grid(:,3).*(1-0.318);
GHG_WW_truck_grid(:,4)=GHG_WW_truck_grid(:,4).*(1-0.683);
GHG_WW_truck_pv(:,1)=GHG_WW_truck_pv(:,1).*(1-0.318);
GHG_WW_truck_pv(:,2)=GHG_WW_truck_pv(:,2).*(1-0.683);
GHG_WW_truck_pv(:,3)=GHG_WW_truck_pv(:,3).*(1-0.318);
GHG_WW_truck_pv(:,4)=GHG_WW_truck_pv(:,4).*(1-0.683);
GHG_WW_truck_wind(:,1)=GHG_WW_truck_wind(:,1).*(1-0.318);
GHG_WW_truck_wind(:,2)=GHG_WW_truck_wind(:,2).*(1-0.683);
GHG_WW_truck_wind(:,3)=GHG_WW_truck_wind(:,3).*(1-0.318);
GHG_WW_truck_wind(:,4)=GHG_WW_truck_wind(:,4).*(1-0.683);
GHG_WW_bus_grid(:,1)=GHG_WW_bus_grid(:,1).*(1-0.318);
GHG_WW_bus_grid(:,2)=GHG_WW_bus_grid(:,2).*(1-0.683);
GHG_WW_bus_grid(:,3)=GHG_WW_bus_grid(:,3).*(1-0.318);
GHG_WW_bus_grid(:,4)=GHG_WW_bus_grid(:,4).*(1-0.683);
GHG_WW_bus_pv(:,1)=GHG_WW_bus_pv(:,1).*(1-0.318);
GHG_WW_bus_pv(:,2)=GHG_WW_bus_pv(:,2).*(1-0.683);
GHG_WW_bus_pv(:,3)=GHG_WW_bus_pv(:,3).*(1-0.318);
GHG_WW_bus_pv(:,4)=GHG_WW_bus_pv(:,4).*(1-0.683);
GHG_WW_bus_wind(:,1)=GHG_WW_bus_wind(:,1).*(1-0.318);
GHG_WW_bus_wind(:,2)=GHG_WW_bus_wind(:,2).*(1-0.683);
GHG_WW_bus_wind(:,3)=GHG_WW_bus_wind(:,3).*(1-0.318);
GHG_WW_bus_wind(:,4)=GHG_WW_bus_wind(:,4).*(1-0.683);
GHG_WW_car_grid(:,1)=GHG_WW_car_grid(:,1).*(1-0.318);
GHG_WW_car_grid(:,2)=GHG_WW_car_grid(:,2).*(1-0.683);
GHG_WW_car_grid(:,3)=GHG_WW_car_grid(:,3).*(1-0.318);
GHG_WW_car_grid(:,4)=GHG_WW_car_grid(:,4).*(1-0.683);
GHG_WW_car_pv(:,1)=GHG_WW_car_pv(:,1).*(1-0.318);
GHG_WW_car_pv(:,2)=GHG_WW_car_pv(:,2).*(1-0.683);
GHG_WW_car_pv(:,3)=GHG_WW_car_pv(:,3).*(1-0.318);
GHG_WW_car_pv(:,4)=GHG_WW_car_pv(:,4).*(1-0.683);
GHG_WW_car_wind(:,1)=GHG_WW_car_wind(:,1).*(1-0.318);
GHG_WW_car_wind(:,2)=GHG_WW_car_wind(:,2).*(1-0.683);
GHG_WW_car_wind(:,3)=GHG_WW_car_wind(:,3).*(1-0.318);
GHG_WW_car_wind(:,4)=GHG_WW_car_wind(:,4).*(1-0.683);
GHG_WW_ship_grid(:,1)=GHG_WW_ship_grid(:,1).*(1-0.318);
GHG_WW_ship_grid(:,2)=GHG_WW_ship_grid(:,2).*(1-0.683);
GHG_WW_ship_grid(:,3)=GHG_WW_ship_grid(:,3).*(1-0.318);
GHG_WW_ship_grid(:,4)=GHG_WW_ship_grid(:,4).*(1-0.683);
GHG_WW_ship_pv(:,1)=GHG_WW_ship_pv(:,1).*(1-0.318);
GHG_WW_ship_pv(:,2)=GHG_WW_ship_pv(:,2).*(1-0.683);
GHG_WW_ship_pv(:,3)=GHG_WW_ship_pv(:,3).*(1-0.318);
GHG_WW_ship_pv(:,4)=GHG_WW_ship_pv(:,4).*(1-0.683);
GHG_WW_ship_wind(:,1)=GHG_WW_ship_wind(:,1).*(1-0.318);
GHG_WW_ship_wind(:,2)=GHG_WW_ship_wind(:,2).*(1-0.683);
GHG_WW_ship_wind(:,3)=GHG_WW_ship_wind(:,3).*(1-0.318);
GHG_WW_ship_wind(:,4)=GHG_WW_ship_wind(:,4).*(1-0.683);
GHG_WW_air_grid(:,1)=GHG_WW_air_grid(:,1).*(1-0.318);
GHG_WW_air_grid(:,2)=GHG_WW_air_grid(:,2).*(1-0.683);
GHG_WW_air_grid(:,3)=GHG_WW_air_grid(:,3).*(1-0.318);
GHG_WW_air_grid(:,4)=GHG_WW_air_grid(:,4).*(1-0.683);
GHG_WW_air_pv(:,1)=GHG_WW_air_pv(:,1).*(1-0.318);
GHG_WW_air_pv(:,2)=GHG_WW_air_pv(:,2).*(1-0.683);
GHG_WW_air_pv(:,3)=GHG_WW_air_pv(:,3).*(1-0.318);
GHG_WW_air_pv(:,4)=GHG_WW_air_pv(:,4).*(1-0.683);
GHG_WW_air_wind(:,1)=GHG_WW_air_wind(:,1).*(1-0.318);
GHG_WW_air_wind(:,2)=GHG_WW_air_wind(:,2).*(1-0.683);
GHG_WW_air_wind(:,3)=GHG_WW_air_wind(:,3).*(1-0.318);
GHG_WW_air_wind(:,4)=GHG_WW_air_wind(:,4).*(1-0.683);
GHG_WW_ammonia_grid(:,1)=GHG_WW_ammonia_grid(:,1).*(1-0.318);
GHG_WW_ammonia_grid(:,2)=GHG_WW_ammonia_grid(:,2).*(1-0.683);
GHG_WW_ammonia_grid(:,3)=GHG_WW_ammonia_grid(:,3).*(1-0.318);
GHG_WW_ammonia_grid(:,4)=GHG_WW_ammonia_grid(:,4).*(1-0.683);
GHG_WW_ammonia_pv(:,1)=GHG_WW_ammonia_pv(:,1).*(1-0.318);
GHG_WW_ammonia_pv(:,2)=GHG_WW_ammonia_pv(:,2).*(1-0.683);
GHG_WW_ammonia_pv(:,3)=GHG_WW_ammonia_pv(:,3).*(1-0.318);
GHG_WW_ammonia_pv(:,4)=GHG_WW_ammonia_pv(:,4).*(1-0.683);
GHG_WW_ammonia_wind(:,1)=GHG_WW_ammonia_wind(:,1).*(1-0.318);
GHG_WW_ammonia_wind(:,2)=GHG_WW_ammonia_wind(:,2).*(1-0.683);
GHG_WW_ammonia_wind(:,3)=GHG_WW_ammonia_wind(:,3).*(1-0.318);
GHG_WW_ammonia_wind(:,4)=GHG_WW_ammonia_wind(:,4).*(1-0.683);
GHG_WW_methanol_grid(:,1)=GHG_WW_methanol_grid(:,1).*(1-0.318);
GHG_WW_methanol_grid(:,2)=GHG_WW_methanol_grid(:,2).*(1-0.683);
GHG_WW_methanol_grid(:,3)=GHG_WW_methanol_grid(:,3).*(1-0.318);
GHG_WW_methanol_grid(:,4)=GHG_WW_methanol_grid(:,4).*(1-0.683);
GHG_WW_methanol_pv(:,1)=GHG_WW_methanol_pv(:,1).*(1-0.318);
GHG_WW_methanol_pv(:,2)=GHG_WW_methanol_pv(:,2).*(1-0.683);
GHG_WW_methanol_pv(:,3)=GHG_WW_methanol_pv(:,3).*(1-0.318);
GHG_WW_methanol_pv(:,4)=GHG_WW_methanol_pv(:,4).*(1-0.683);
GHG_WW_methanol_wind(:,1)=GHG_WW_methanol_wind(:,1).*(1-0.318);
GHG_WW_methanol_wind(:,2)=GHG_WW_methanol_wind(:,2).*(1-0.683);
GHG_WW_methanol_wind(:,3)=GHG_WW_methanol_wind(:,3).*(1-0.318);
GHG_WW_methanol_wind(:,4)=GHG_WW_methanol_wind(:,4).*(1-0.683);
GHG_WW_oil_grid(:,1)=GHG_WW_oil_grid(:,1).*(1-0.318);
GHG_WW_oil_grid(:,2)=GHG_WW_oil_grid(:,2).*(1-0.683);
GHG_WW_oil_grid(:,3)=GHG_WW_oil_grid(:,3).*(1-0.318);
GHG_WW_oil_grid(:,4)=GHG_WW_oil_grid(:,4).*(1-0.683);
GHG_WW_oil_pv(:,1)=GHG_WW_oil_pv(:,1).*(1-0.318);
GHG_WW_oil_pv(:,2)=GHG_WW_oil_pv(:,2).*(1-0.683);
GHG_WW_oil_pv(:,3)=GHG_WW_oil_pv(:,3).*(1-0.318);
GHG_WW_oil_pv(:,4)=GHG_WW_oil_pv(:,4).*(1-0.683);
GHG_WW_oil_wind(:,1)=GHG_WW_oil_wind(:,1).*(1-0.318);
GHG_WW_oil_wind(:,2)=GHG_WW_oil_wind(:,2).*(1-0.683);
GHG_WW_oil_wind(:,3)=GHG_WW_oil_wind(:,3).*(1-0.318);
GHG_WW_oil_wind(:,4)=GHG_WW_oil_wind(:,4).*(1-0.683);
GHG_WW_ng_grid(:,1)=GHG_WW_ng_grid(:,1).*(1-0.318);
GHG_WW_ng_grid(:,2)=GHG_WW_ng_grid(:,2).*(1-0.683);
GHG_WW_ng_grid(:,3)=GHG_WW_ng_grid(:,3).*(1-0.318);
GHG_WW_ng_grid(:,4)=GHG_WW_ng_grid(:,4).*(1-0.683);
GHG_WW_ng_pv(:,1)=GHG_WW_ng_pv(:,1).*(1-0.318);
GHG_WW_ng_pv(:,2)=GHG_WW_ng_pv(:,2).*(1-0.683);
GHG_WW_ng_pv(:,3)=GHG_WW_ng_pv(:,3).*(1-0.318);
GHG_WW_ng_pv(:,4)=GHG_WW_ng_pv(:,4).*(1-0.683);
GHG_WW_ng_wind(:,1)=GHG_WW_ng_wind(:,1).*(1-0.318);
GHG_WW_ng_wind(:,2)=GHG_WW_ng_wind(:,2).*(1-0.683);
GHG_WW_ng_wind(:,3)=GHG_WW_ng_wind(:,3).*(1-0.318);
GHG_WW_ng_wind(:,4)=GHG_WW_ng_wind(:,4).*(1-0.683);
GHG_WW_olefin_grid(:,1)=GHG_WW_olefin_grid(:,1).*(1-0.318);
GHG_WW_olefin_grid(:,2)=GHG_WW_olefin_grid(:,2).*(1-0.683);
GHG_WW_olefin_grid(:,3)=GHG_WW_olefin_grid(:,3).*(1-0.318);
GHG_WW_olefin_grid(:,4)=GHG_WW_olefin_grid(:,4).*(1-0.683);
GHG_WW_olefin_pv(:,1)=GHG_WW_olefin_pv(:,1).*(1-0.318);
GHG_WW_olefin_pv(:,2)=GHG_WW_olefin_pv(:,2).*(1-0.683);
GHG_WW_olefin_pv(:,3)=GHG_WW_olefin_pv(:,3).*(1-0.318);
GHG_WW_olefin_pv(:,4)=GHG_WW_olefin_pv(:,4).*(1-0.683);
GHG_WW_olefin_wind(:,1)=GHG_WW_olefin_wind(:,1).*(1-0.318);
GHG_WW_olefin_wind(:,2)=GHG_WW_olefin_wind(:,2).*(1-0.683);
GHG_WW_olefin_wind(:,3)=GHG_WW_olefin_wind(:,3).*(1-0.318);
GHG_WW_olefin_wind(:,4)=GHG_WW_olefin_wind(:,4).*(1-0.683);
GHG_WW_eg_grid(:,1)=GHG_WW_eg_grid(:,1).*(1-0.318);
GHG_WW_eg_grid(:,2)=GHG_WW_eg_grid(:,2).*(1-0.683);
GHG_WW_eg_grid(:,3)=GHG_WW_eg_grid(:,3).*(1-0.318);
GHG_WW_eg_grid(:,4)=GHG_WW_eg_grid(:,4).*(1-0.683);
GHG_WW_eg_pv(:,1)=GHG_WW_eg_pv(:,1).*(1-0.318);
GHG_WW_eg_pv(:,2)=GHG_WW_eg_pv(:,2).*(1-0.683);
GHG_WW_eg_pv(:,3)=GHG_WW_eg_pv(:,3).*(1-0.318);
GHG_WW_eg_pv(:,4)=GHG_WW_eg_pv(:,4).*(1-0.683);
GHG_WW_eg_wind(:,1)=GHG_WW_eg_wind(:,1).*(1-0.318);
GHG_WW_eg_wind(:,2)=GHG_WW_eg_wind(:,2).*(1-0.683);
GHG_WW_eg_wind(:,3)=GHG_WW_eg_wind(:,3).*(1-0.318);
GHG_WW_eg_wind(:,4)=GHG_WW_eg_wind(:,4).*(1-0.683);
GHG_WW_metallurgy_grid(:,1)=GHG_WW_metallurgy_grid(:,1).*(1-0.318);
GHG_WW_metallurgy_grid(:,2)=GHG_WW_metallurgy_grid(:,2).*(1-0.683);
GHG_WW_metallurgy_grid(:,3)=GHG_WW_metallurgy_grid(:,3).*(1-0.318);
GHG_WW_metallurgy_grid(:,4)=GHG_WW_metallurgy_grid(:,4).*(1-0.683);
GHG_WW_metallurgy_pv(:,1)=GHG_WW_metallurgy_pv(:,1).*(1-0.318);
GHG_WW_metallurgy_pv(:,2)=GHG_WW_metallurgy_pv(:,2).*(1-0.683);
GHG_WW_metallurgy_pv(:,3)=GHG_WW_metallurgy_pv(:,3).*(1-0.318);
GHG_WW_metallurgy_pv(:,4)=GHG_WW_metallurgy_pv(:,4).*(1-0.683);
GHG_WW_metallurgy_wind(:,1)=GHG_WW_metallurgy_wind(:,1).*(1-0.318);
GHG_WW_metallurgy_wind(:,2)=GHG_WW_metallurgy_wind(:,2).*(1-0.683);
GHG_WW_metallurgy_wind(:,3)=GHG_WW_metallurgy_wind(:,3).*(1-0.318);
GHG_WW_metallurgy_wind(:,4)=GHG_WW_metallurgy_wind(:,4).*(1-0.683);
GHG_WW_refining_grid(:,1)=GHG_WW_refining_grid(:,1).*(1-0.318);
GHG_WW_refining_grid(:,2)=GHG_WW_refining_grid(:,2).*(1-0.683);
GHG_WW_refining_grid(:,3)=GHG_WW_refining_grid(:,3).*(1-0.318);
GHG_WW_refining_grid(:,4)=GHG_WW_refining_grid(:,4).*(1-0.683);
GHG_WW_refining_pv(:,1)=GHG_WW_refining_pv(:,1).*(1-0.318);
GHG_WW_refining_pv(:,2)=GHG_WW_refining_pv(:,2).*(1-0.683);
GHG_WW_refining_pv(:,3)=GHG_WW_refining_pv(:,3).*(1-0.318);
GHG_WW_refining_pv(:,4)=GHG_WW_refining_pv(:,4).*(1-0.683);
GHG_WW_refining_wind(:,1)=GHG_WW_refining_wind(:,1).*(1-0.318);
GHG_WW_refining_wind(:,2)=GHG_WW_refining_wind(:,2).*(1-0.683);
GHG_WW_refining_wind(:,3)=GHG_WW_refining_wind(:,3).*(1-0.318);
GHG_WW_refining_wind(:,4)=GHG_WW_refining_wind(:,4).*(1-0.683);
GHG_WW_fuel_grid(:,1)=GHG_WW_fuel_grid(:,1).*(1-0.318);
GHG_WW_fuel_grid(:,2)=GHG_WW_fuel_grid(:,2).*(1-0.683);
GHG_WW_fuel_grid(:,3)=GHG_WW_fuel_grid(:,3).*(1-0.318);
GHG_WW_fuel_grid(:,4)=GHG_WW_fuel_grid(:,4).*(1-0.683);
GHG_WW_fuel_pv(:,1)=GHG_WW_fuel_pv(:,1).*(1-0.318);
GHG_WW_fuel_pv(:,2)=GHG_WW_fuel_pv(:,2).*(1-0.683);
GHG_WW_fuel_pv(:,3)=GHG_WW_fuel_pv(:,3).*(1-0.318);
GHG_WW_fuel_pv(:,4)=GHG_WW_fuel_pv(:,4).*(1-0.683);
GHG_WW_fuel_wind(:,1)=GHG_WW_fuel_wind(:,1).*(1-0.318);
GHG_WW_fuel_wind(:,2)=GHG_WW_fuel_wind(:,2).*(1-0.683);
GHG_WW_fuel_wind(:,3)=GHG_WW_fuel_wind(:,3).*(1-0.318);
GHG_WW_fuel_wind(:,4)=GHG_WW_fuel_wind(:,4).*(1-0.683);
GHG_WW_synfuel_grid(:,1)=GHG_WW_synfuel_grid(:,1).*(1-0.318);
GHG_WW_synfuel_grid(:,2)=GHG_WW_synfuel_grid(:,2).*(1-0.683);
GHG_WW_synfuel_grid(:,3)=GHG_WW_synfuel_grid(:,3).*(1-0.318);
GHG_WW_synfuel_grid(:,4)=GHG_WW_synfuel_grid(:,4).*(1-0.683);
GHG_WW_synfuel_pv(:,1)=GHG_WW_synfuel_pv(:,1).*(1-0.318);
GHG_WW_synfuel_pv(:,2)=GHG_WW_synfuel_pv(:,2).*(1-0.683);
GHG_WW_synfuel_pv(:,3)=GHG_WW_synfuel_pv(:,3).*(1-0.318);
GHG_WW_synfuel_pv(:,4)=GHG_WW_synfuel_pv(:,4).*(1-0.683);
GHG_WW_synfuel_wind(:,1)=GHG_WW_synfuel_wind(:,1).*(1-0.318);
GHG_WW_synfuel_wind(:,2)=GHG_WW_synfuel_wind(:,2).*(1-0.683);
GHG_WW_synfuel_wind(:,3)=GHG_WW_synfuel_wind(:,3).*(1-0.318);
GHG_WW_synfuel_wind(:,4)=GHG_WW_synfuel_wind(:,4).*(1-0.683);
WW_power_grid(:,1:4)=D_power(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;%Mt water
WW_power_pv(:,1:4)=D_power(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_power_wind(:,1:4)=D_power(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_building_grid(:,1:4)=D_building(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_building_pv(:,1:4)=D_building(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_building_wind(:,1:4)=D_building(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_truck_grid(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_truck_pv(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_truck_wind(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_bus_grid(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_bus_pv(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_bus_wind(:,1:4)=D_truck(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_car_grid(:,1:4)=D_car(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_car_pv(:,1:4)=D_car(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_car_wind(:,1:4)=D_car(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_ship_grid(:,1:4)=D_ship(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_ship_pv(:,1:4)=D_ship(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_ship_wind(:,1:4)=D_ship(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_air_grid(:,1:4)=D_air(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_air_pv(:,1:4)=D_air(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_air_wind(:,1:4)=D_air(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_ammonia_grid(:,1:4)=D_ammonia(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_ammonia_pv(:,1:4)=D_ammonia(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_ammonia_wind(:,1:4)=D_ammonia(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_methanol_grid(:,1:4)=D_methanol(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_methanol_pv(:,1:4)=D_methanol(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_methanol_wind(:,1:4)=D_methanol(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_oil_grid(:,1:4)=D_oil(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_oil_pv(:,1:4)=D_oil(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_oil_wind(:,1:4)=D_oil(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_ng_grid(:,1:4)=D_ng(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_ng_pv(:,1:4)=D_ng(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_ng_wind(:,1:4)=D_ng(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_olefin_grid(:,1:4)=D_olefin(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_olefin_pv(:,1:4)=D_olefin(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_olefin_wind(:,1:4)=D_olefin(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_eg_grid(:,1:4)=D_eg(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_eg_pv(:,1:4)=D_eg(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_eg_wind(:,1:4)=D_eg(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_metallurgy_grid(:,1:4)=D_metallurgy(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_metallurgy_pv(:,1:4)=D_metallurgy(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_metallurgy_wind(:,1:4)=D_metallurgy(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_refining_grid(:,1:4)=D_refining(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_refining_pv(:,1:4)=D_refining(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_refining_wind(:,1:4)=D_refining(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_fuel_grid(:,1:4)=D_fuel(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_fuel_pv(:,1:4)=D_fuel(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_fuel_wind(:,1:4)=D_fuel(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_synfuel_grid(:,1:4)=D_synfuel(:,1:4)./0.95.*(32.24+24+0.0007430555555556.*57.9)./10^6;
WW_synfuel_pv(:,1:4)=D_synfuel(:,1:4)./0.95.*(32.24+24+124+5.34)./10^6;
WW_synfuel_wind(:,1:4)=D_synfuel(:,1:4)./0.95.*(32.24+24+11+5.34)./10^6;
WW_grid=WW_power_grid+WW_building_grid+WW_truck_grid+WW_bus_grid+WW_car_grid+WW_ship_grid+WW_air_grid+WW_ammonia_grid+WW_methanol_grid+WW_oil_grid+WW_ng_grid+WW_olefin_grid+WW_eg_grid+WW_metallurgy_grid+WW_refining_grid+WW_fuel_grid+WW_synfuel_grid;
WW_pv=WW_power_pv+WW_building_pv+WW_truck_pv+WW_bus_pv+WW_car_pv+WW_ship_pv+WW_air_pv+WW_ammonia_pv+WW_methanol_pv+WW_oil_pv+WW_ng_pv+WW_olefin_pv+WW_eg_pv+WW_metallurgy_pv+WW_refining_pv+WW_fuel_pv+WW_synfuel_pv;
WW_wind=WW_power_wind+WW_building_wind+WW_truck_wind+WW_bus_wind+WW_car_wind+WW_ship_wind+WW_air_wind+WW_ammonia_wind+WW_methanol_wind+WW_oil_wind+WW_ng_wind+WW_olefin_wind+WW_eg_wind+WW_metallurgy_wind+WW_refining_wind+WW_fuel_wind+WW_synfuel_wind;
%%%%%% GHG changes in counties
GHG_ou=GHG_OU_power+GHG_OU_building+GHG_OU_truck+GHG_OU_bus+GHG_OU_car+GHG_OU_ship+GHG_OU_air+GHG_OU_refining+GHG_OU_synfuel+GHG_OU_fuel+GHG_OU_metallurgy+GHG_OU_ammonia+GHG_OU_methanol+GHG_OU_oil+GHG_OU_ng+GHG_OU_olefin+GHG_OU_eg;
GHG_ouww_grid=GHG_ou+GHG_WW_power_grid+GHG_WW_building_grid+GHG_WW_truck_grid+GHG_WW_bus_grid+GHG_WW_car_grid+GHG_WW_ship_grid+GHG_WW_air_grid+GHG_WW_ammonia_grid+GHG_WW_methanol_grid+GHG_WW_oil_grid+GHG_WW_ng_grid+GHG_WW_olefin_grid+GHG_WW_eg_grid+GHG_WW_metallurgy_grid+GHG_WW_refining_grid+GHG_WW_fuel_grid+GHG_WW_synfuel_grid;
GHG_ouww_pv=GHG_ou+GHG_WW_power_pv+GHG_WW_building_pv+GHG_WW_truck_pv+GHG_WW_bus_pv+GHG_WW_car_pv+GHG_WW_ship_pv+GHG_WW_air_pv+GHG_WW_ammonia_pv+GHG_WW_methanol_pv+GHG_WW_oil_pv+GHG_WW_ng_pv+GHG_WW_olefin_pv+GHG_WW_eg_pv+GHG_WW_metallurgy_pv+GHG_WW_refining_pv+GHG_WW_fuel_pv+GHG_WW_synfuel_pv;
GHG_ouww_wind=GHG_ou+GHG_WW_power_wind+GHG_WW_building_wind+GHG_WW_truck_wind+GHG_WW_bus_wind+GHG_WW_car_wind+GHG_WW_ship_wind+GHG_WW_air_wind+GHG_WW_ammonia_wind+GHG_WW_methanol_wind+GHG_WW_oil_wind+GHG_WW_ng_wind+GHG_WW_olefin_wind+GHG_WW_eg_wind+GHG_WW_metallurgy_wind+GHG_WW_refining_wind+GHG_WW_fuel_wind+GHG_WW_synfuel_wind;
GHG_grid(:,1:2)=GHG_ouww_grid(:,1:2)-GHG_PRO_grid(:,1:2)-GHG_PRO_grid(:,3:4)-GHG_PRO_grid(:,5:6)-GHG_PRO_grid(:,7:8)-GHG_PRO_grid(:,9:10)-GHG_PRO_grid(:,11:12)-GHG_PRO_grid(:,13:14)-GHG_PRO_grid(:,15:16)-GHG_PRO_grid(:,17:18)-GHG_PRO_grid(:,21:22)-GHG_PRO_grid(:,23:24)-GHG_PRO_grid(:,25:26)-GHG_PRO_grid(:,27:28)-GHG_PRO_grid(:,61:62)-GHG_PRO_grid(:,63:64)-GHG_PRO_grid(:,65:66)-GHG_PRO_grid(:,67:68);
GHG_grid(:,3:4)=GHG_ouww_grid(:,3:4)-GHG_PRO_grid(:,31:32)-GHG_PRO_grid(:,33:34)-GHG_PRO_grid(:,35:36)-GHG_PRO_grid(:,37:38)-GHG_PRO_grid(:,39:40)-GHG_PRO_grid(:,41:42)-GHG_PRO_grid(:,43:44)-GHG_PRO_grid(:,45:46)-GHG_PRO_grid(:,47:48)-GHG_PRO_grid(:,51:52)-GHG_PRO_grid(:,53:54)-GHG_PRO_grid(:,55:56)-GHG_PRO_grid(:,57:58)-GHG_PRO_grid(:,69:70)-GHG_PRO_grid(:,71:72)-GHG_PRO_grid(:,73:74)-GHG_PRO_grid(:,75:76);
GHG_pv(:,1:2)=GHG_ouww_pv(:,1:2)-GHG_PRO_pv(:,1:2)-GHG_PRO_pv(:,3:4)-GHG_PRO_pv(:,5:6)-GHG_PRO_pv(:,7:8)-GHG_PRO_pv(:,9:10)-GHG_PRO_pv(:,11:12)-GHG_PRO_pv(:,13:14)-GHG_PRO_pv(:,15:16)-GHG_PRO_pv(:,17:18)-GHG_PRO_pv(:,21:22)-GHG_PRO_pv(:,23:24)-GHG_PRO_pv(:,25:26)-GHG_PRO_pv(:,27:28)-GHG_PRO_pv(:,61:62)-GHG_PRO_pv(:,63:64)-GHG_PRO_pv(:,65:66)-GHG_PRO_pv(:,67:68);
GHG_pv(:,3:4)=GHG_ouww_pv(:,3:4)-GHG_PRO_pv(:,31:32)-GHG_PRO_pv(:,33:34)-GHG_PRO_pv(:,35:36)-GHG_PRO_pv(:,37:38)-GHG_PRO_pv(:,39:40)-GHG_PRO_pv(:,41:42)-GHG_PRO_pv(:,43:44)-GHG_PRO_pv(:,45:46)-GHG_PRO_pv(:,47:48)-GHG_PRO_pv(:,51:52)-GHG_PRO_pv(:,53:54)-GHG_PRO_pv(:,55:56)-GHG_PRO_pv(:,57:58)-GHG_PRO_pv(:,69:70)-GHG_PRO_pv(:,71:72)-GHG_PRO_pv(:,73:74)-GHG_PRO_pv(:,75:76);
GHG_wind(:,1:2)=GHG_ouww_wind(:,1:2)-GHG_PRO_wind(:,1:2)-GHG_PRO_wind(:,3:4)-GHG_PRO_wind(:,5:6)-GHG_PRO_wind(:,7:8)-GHG_PRO_wind(:,9:10)-GHG_PRO_wind(:,11:12)-GHG_PRO_wind(:,13:14)-GHG_PRO_wind(:,15:16)-GHG_PRO_wind(:,17:18)-GHG_PRO_wind(:,21:22)-GHG_PRO_wind(:,23:24)-GHG_PRO_wind(:,25:26)-GHG_PRO_wind(:,27:28)-GHG_PRO_wind(:,61:62)-GHG_PRO_wind(:,63:64)-GHG_PRO_wind(:,65:66)-GHG_PRO_wind(:,67:68);
GHG_wind(:,3:4)=GHG_ouww_wind(:,3:4)-GHG_PRO_wind(:,31:32)-GHG_PRO_wind(:,33:34)-GHG_PRO_wind(:,35:36)-GHG_PRO_wind(:,37:38)-GHG_PRO_wind(:,39:40)-GHG_PRO_wind(:,41:42)-GHG_PRO_wind(:,43:44)-GHG_PRO_wind(:,45:46)-GHG_PRO_wind(:,47:48)-GHG_PRO_wind(:,51:52)-GHG_PRO_wind(:,53:54)-GHG_PRO_wind(:,55:56)-GHG_PRO_wind(:,57:58)-GHG_PRO_wind(:,69:70)-GHG_PRO_wind(:,71:72)-GHG_PRO_wind(:,73:74)-GHG_PRO_wind(:,75:76);
%%%%%% Cost of green h2 production,B CNY
D_county=D_power+D_building+D_truck+D_bus+D_car+D_ship+D_air+D_ammonia+D_methanol+D_oil+D_ng+D_olefin+D_eg+D_metallurgy+D_refining+D_fuel+D_synfuel;%H2demand,t
C_electrolyzer(1,1)=10000.*(5659+33.*(1-(1./1.02)^25)./(1-1./1.02))./(936.*25).*6.8./(1.02^30);%CNY/t H2
C_electrolyzer(1,2)=10000.*(599+30.*(1-(1./1.02)^25)./(1-1./1.02))./(936.*25).*6.8./(1.02^30);
C_battery(1,1)=375000.*(566+14.*(1-(1./1.02)^20)./(1-1./1.02))./(36500.*20).*6.8./(1.02^10);%CNY/t H2
C_battery(1,2)=375000.*(352+9.*(1-(1./1.02)^20)./(1-1./1.02))./(36500.*20).*6.8./(1.02^30);
C_pv(:,1)=(392.*1000+17.*1000.*(1-(1./1.02)^25)./(1-1./1.02))./(25.*365.*24.*CF(:,1)).*6.8./(1.02^10);%CNY/MWh
C_pv(:,2)=(307.*1000+13.*1000.*(1-(1./1.02)^25)./(1-1./1.02))./(25.*365.*24.*CF(:,1)).*6.8./(1.02^30);
C_wind(:,1)=(597.*1000+22.*1000.*(1-(1./1.02)^20)./(1-1./1.02))./(20.*365.*24.*CF(:,2)).*6.8./(1.02^10);%CNY/MWh
C_wind(:,2)=(462.*1000+17.*1000.*(1-(1./1.02)^20)./(1-1./1.02))./(20.*365.*24.*CF(:,2)).*6.8./(1.02^30);
C_grid=csvread('CostPrice.csv').*1000;%CNY/Mwh
C_grid(:,1)=C_grid(:,1)./(1.02^10);
C_grid(:,2)=C_grid(:,2)./(1.02^30);
C_ww=csvread('Watercost.csv');%CNY/m3
C_ww_grid(:,1)=C_ww(:,1)./(1.02^10).*(32.24+24+0.000743056.*57.9);%CNY/tH2
C_ww_grid(:,2)=C_ww(:,2)./(1.02^30).*(32.24+24+0.000743056.*57.9);%CNY/tH2
C_ww_pv(:,1)=C_ww(:,1)./(1.02^10).*(32.24+24+124+5.34);%CNY/tH2
C_ww_pv(:,2)=C_ww(:,2)./(1.02^30).*(32.24+24+124+5.34);%CNY/tH2
C_ww_wind(:,1)=C_ww(:,1)./(1.02^10).*(32.24+24+11+5.34);%CNY/tH2
C_ww_wind(:,2)=C_ww(:,2)./(1.02^30).*(32.24+24+11+5.34);%CNY/tH2
TC_grid(:,1:2)=D_county(:,1:2)./0.95.*(C_electrolyzer(1,:)+C_ww_grid(:,:)+C_grid(:,1).*57.9)./10^9;%B CNY
TC_grid(:,3:4)=D_county(:,3:4)./0.95.*(C_electrolyzer(1,:)+C_ww_grid(:,:)+C_grid(:,1).*57.9)./10^9;%B CNY
TC_pv(:,1:2)=D_county(:,1:2)./0.95.*(C_electrolyzer(1,:)+C_battery(1,:)+C_ww_pv(:,:)+C_pv(:,1).*57.9)./10^9;%B CNY
TC_pv(:,3:4)=D_county(:,3:4)./0.95.*(C_electrolyzer(1,:)+C_battery(1,:)+C_ww_pv(:,:)+C_pv(:,1).*57.9)./10^9;%B CNY
TC_wind(:,1:2)=D_county(:,1:2)./0.95.*(C_electrolyzer(1,:)+C_battery(1,:)+C_ww_wind(:,:)+C_wind(:,1).*57.9)./10^9;%B CNY
TC_wind(:,3:4)=D_county(:,3:4)./0.95.*(C_electrolyzer(1,:)+C_battery(1,:)+C_ww_wind(:,:)+C_wind(:,1).*57.9)./10^9;%B CNY
%%%%%%% Ideal GHG mitigation strategy based on minimizing costs in each county
TC_APS30(:,1)=TC_grid(:,1);
TC_APS30(:,2)=TC_pv(:,1);
TC_APS30(:,3)=TC_wind(:,1);
TC_APS50(:,1)=TC_grid(:,2);
TC_APS50(:,2)=TC_pv(:,2);
TC_APS50(:,3)=TC_wind(:,2);
TC_CHA30(:,1)=TC_grid(:,3);
TC_CHA30(:,2)=TC_pv(:,3);
TC_CHA30(:,3)=TC_wind(:,3);
TC_CHA50(:,1)=TC_grid(:,4);
TC_CHA50(:,2)=TC_pv(:,4);
TC_CHA50(:,3)=TC_wind(:,4);
MC=zeros(2901,4);%0-No data;1-Grid;2-pv;3-wind
for i=1:2901
    if TC_APS30(i,1)==0
        MC(i,1)=0;
    else
 [min_values(i), min_indices(i)] = min(TC_APS30(i,:));   
        MC(i,1)=min_indices(i);
    end
    if TC_APS50(i,1)==0
        MC(i,2)=0;
    else
 [min_values(i), min_indices(i)] = min(TC_APS50(i,:));   
        MC(i,2)=min_indices(i);
    end    
    if TC_CHA30(i,1)==0
        MC(i,3)=0;
    else
 [min_values(i), min_indices(i)] = min(TC_CHA30(i,:));   
        MC(i,3)=min_indices(i);
    end
    if TC_CHA50(i,1)==0
        MC(i,4)=0;
    else
 [min_values(i), min_indices(i)] = min(TC_CHA50(i,:));   
        MC(i,4)=min_indices(i);
    end
end
for i=1:2901
    for j=1:4
        if MC(i,j)==1
GHG_ideal(i,j)=GHG_grid(i,j);%Mt CO2eq
WW_ideal(i,j)=WW_grid(i,j);% Mt water consumption
TC_ideal(i,j)=TC_grid(i,j);%B CNY
        elseif MC(i,j)==2
GHG_ideal(i,j)=GHG_pv(i,j);
WW_ideal(i,j)=WW_pv(i,j);
TC_ideal(i,j)=TC_pv(i,j);
        elseif MC(i,j)==3
GHG_ideal(i,j)=GHG_wind(i,j);
WW_ideal(i,j)=WW_wind(i,j);
TC_ideal(i,j)=TC_wind(i,j);
        else
GHG_ideal(i,j)=0;    
WW_ideal(i,j)=0; 
TC_ideal(i,j)=0;
        end
end
end
%%%%%% Constrained GHG mitigation oppotunities
for i=1:2901
if WC(i,1)==3
    GHG_wc(i,1)=GHG_ideal(i,1);% Constrained GHG mitigation oppotunities Mt CO2eq
    GHG_wc(i,3)=GHG_ideal(i,3);% Production Cost in Constrained counties
else
    GHG_wc(i,1)=0;
    GHG_wc(i,3)=0;
end
if WC(i,2)==3
    GHG_wc(i,2)=GHG_ideal(i,2);
    GHG_wc(i,4)=GHG_ideal(i,4);
else
    GHG_wc(i,2)=0;
    GHG_wc(i,4)=0;
end
end
%%%%%% Proposed solutions
for i=1:2901
if WC(i,1)==3
    D_wc(i,1)=D_county(i,1);% Constrained H2 demand,t
    D_wc(i,3)=D_county(i,3);
else
    D_wc(i,1)=0;
    D_wc(i,3)=0;
end
if WC(i,2)==3
    D_wc(i,2)=D_county(i,2);% Constrained H2 demand,t
    D_wc(i,4)=D_county(i,4);
else
    D_wc(i,2)=0;
    D_wc(i,4)=0;
end
end
    %S3:green hydrogen is produced on-site, with water withdrawal from reclaimed water
C_S3=csvread('S3cost.csv');
C_S3(:,1)=C_S3(:,1)./(1.02^10);
C_S3(:,2)=C_S3(:,2)./(1.02^30);
TC_S3(:,1:2)=D_wc(:,1:2)./0.95.*C_S3(:,1:2).*32.24./10^9;%B CNY
TC_S3(:,3:4)=D_wc(:,3:4)./0.95.*C_S3(:,1:2).*32.24./10^9;%B CNY
A=csvread('SeaLand.csv');%0-No constrained;1-coastal;2-Land
DJ_S3=sum(TC_S3)./sum(D_wc).*10^6.*1000;%CNY/t
GHG_S3(:,1)=-(15.32.*(1-0.419)./1000.*D_wc(:,1)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S3(:,2)=-(15.32.*(1-0.484)./1000.*D_wc(:,2)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S3(:,3)=-(15.32.*(1-0.419)./1000.*D_wc(:,3)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S3(:,4)=-(15.32.*(1-0.484)./1000.*D_wc(:,4)./0.95.*32.24)./10^6;%Mt CO2eq
%%%% the availability of reclaimed water,if not available, set as
%%%% +999999CNY,and -999999 GHG
ZSSGG=csvread('zaishengshuiwandun.csv').*10000./(10^6);%Mt Maximum capacity of reclaimed water supply
for i=1:2901
    for j=1:4
        if A(i,ceil(j./2))==0
        else
if WW_ideal(i,j)>ZSSGG(i,1) % not available
    TC_S3(i,j)=999999;
    GHG_S3(i,j)=-999999;    
else
end
        end
    end
end
GHG_S3_LAND=zeros(2901,4);
TC_S3_LAND=zeros(2901,4);
GHG_S3_SEA=zeros(2901,4);
TC_S3_SEA=zeros(2901,4);
D_wc_SEA=zeros(2901,4);
D_wc_LAND=zeros(2901,4);
for i=1:2901
    for j=1:2
if A(i,j)==1
    TC_S3_SEA(i,j)=TC_S3(i,j);%B CNY
    GHG_S3_SEA(i,j)=GHG_S3(i,j);%Mt CO2eq
    D_wc_SEA(i,j)=D_wc(i,j)./10^6;%Mt
    TC_S3_SEA(i,j+2)=TC_S3(i,j+2);%B CNY
    GHG_S3_SEA(i,j+2)=GHG_S3(i,j+2);%Mt CO2eq
    D_wc_SEA(i,j+2)=D_wc(i,j+2)./10^6;%Mt    
elseif  A(i,j)==2
    TC_S3_LAND(i,j)=TC_S3(i,j);%B CNY
    GHG_S3_LAND(i,j)=GHG_S3(i,j);%Mt CO2eq
    D_wc_LAND(i,j)=D_wc(i,j)./10^6;%Mt
    TC_S3_LAND(i,j+2)=TC_S3(i,j+2);%B CNY
    GHG_S3_LAND(i,j+2)=GHG_S3(i,j+2);%Mt CO2eq
    D_wc_LAND(i,j+2)=D_wc(i,j+2)./10^6;%Mt
else
end
end
end
for i=1:2901
    for j=1:4
        if WW_ideal(i,j)>ZSSGG(i,1)
TC_S3_SEA(i,j)=0;
TC_S3_LAND(i,j)=0;
GHG_S3_SEA(i,j)=0;
GHG_S3_LAND(i,j)=0;
D_wc_SEA1(i,j)=0;
D_wc_LAND1(i,j)=0;            
        else
D_wc_SEA1(i,j)=D_wc_SEA(i,j);
D_wc_LAND1(i,j)=D_wc_LAND(i,j);
        end
    end
end
DJ_S3_SEA=sum(TC_S3_SEA)./sum(D_wc_SEA1).*1000;%CNY/t
DJ_S3_LAND=sum(TC_S3_LAND)./sum(D_wc_LAND1).*1000;
GHGperH2_S3_SEA=sum(GHG_S3_SEA)./sum(D_wc_SEA1);%+:mitigation;-:increase GHG Mt CO2eq
GHGperH2_S3_LAND=sum(GHG_S3_LAND)./sum(D_wc_LAND1);
	%S4:green hydrogen is produced on-site, with water withdrawal from purified seawater, and only used in coastal counties
C_S4(:,1)=(37.24.*6.8-C_ww(:,1).*32.24)./(1.02^10);%CNY/t
C_S4(:,2)=(37.24.*6.8-C_ww(:,2).*32.24)./(1.02^30);
TC_S4(:,1:2)=D_wc(:,1:2)./0.95.*C_S4(:,1:2)./10^9;%B CNY
TC_S4(:,3:4)=D_wc(:,3:4)./0.95.*C_S4(:,1:2)./10^9;%B CNY
DJ_S4=sum(TC_S4)./sum(D_wc).*10^6.*1000;%CNY/t
GHG_S4(:,1)=-((4.55.*(1-0.686)-0.00019.*(1-0.318))./1000.*D_wc(:,1)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S4(:,3)=-((4.55.*(1-0.686)-0.00019.*(1-0.318))./1000.*D_wc(:,3)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S4(:,2)=-((4.55.*(1-0.914)-0.00019.*(1-0.683))./1000.*D_wc(:,2)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S4(:,4)=-((4.55.*(1-0.914)-0.00019.*(1-0.683))./1000.*D_wc(:,4)./0.95.*32.24)./10^6;%Mt CO2eq
GHG_S4_LAND=zeros(2901,4);
TC_S4_LAND=zeros(2901,4);
GHG_S4_SEA=zeros(2901,4);
TC_S4_SEA=zeros(2901,4);
for i=1:2901
    for j=1:2
if A(i,j)==1
    TC_S4_SEA(i,j)=TC_S4(i,j);%B CNY
    GHG_S4_SEA(i,j)=GHG_S4(i,j);%Mt CO2eq
    TC_S4_SEA(i,j+2)=TC_S4(i,j+2);%B CNY
    GHG_S4_SEA(i,j+2)=GHG_S4(i,j+2);%Mt CO2eq  
elseif A(i,j)==2
    TC_S4(i,j)=999999;%B CNY
    GHG_S4(i,j)=-999999;%Mt CO2eq
    TC_S4(i,j+2)=999999;%B CNY
    GHG_S4(i,j+2)=-999999;%Mt CO2eq      
end
end
end
for i=1:2901
    for j=1:4
        if A(i,ceil(j./2))==2
TC_S4_SEA(i,j)=0;
GHG_S4_SEA(i,j)=0;
D_wc_SEA2(i,j)=0;        
        else
D_wc_SEA2(i,j)=D_wc_SEA(i,j);
        end
    end
end
DJ_S4_SEA=sum(TC_S4_SEA)./sum(D_wc_SEA2).*1000;%CNY/t
GHGperH2_S4_SEA=sum(GHG_S4_SEA)./sum(D_wc_SEA2);%CNY/t,+:mitigation;-:increase GHG
    %S1: green hydrogen is produced in unconstrained counties within the province, and then transported to the constrained counties by 30 MPa tube trailers
DIS=csvread('S1distance.csv');
C_S1(:,1)=(0.01001.*DIS(:,1)+2.726).*1000./(1.02^10)./1000;%B CNY/Mt H2
C_S1(:,2)=(0.01001.*DIS(:,2)+2.726).*1000./(1.02^30)./1000;
KS=[1,17,33,201,318,422,522,582,703,719,815,905,1010,1095,1195,1332,1490,1593,1715,1839,1950,1975,2013,2196,2284,2413,2487,2594,2681,2726,2748];
JS=[16,32,200,317,420,521,581,702,718,814,904,1009,1094,1194,1331,1489,1592,1714,1838,1949,1974,2012,2195,2283,2412,2486,2593,2680,2725,2747,2853];
TC_sheng=zeros(31,4);%B CNY
GHG_sheng=zeros(31,4);%Mt CO2eq
D_sheng=zeros(31,4);%Mt H2
for i=1:31
for j=KS(1,i):JS(1,i)
if WC(j,1)==3
else
TC_sheng(i,1)=TC_sheng(i,1)+TC_ideal(j,1);
GHG_sheng(i,1)=GHG_sheng(i,1)+GHG_ideal(j,1);
D_sheng(i,1)=D_sheng(i,1)+D_county(j,1)./10^6;
TC_sheng(i,3)=TC_sheng(i,3)+TC_ideal(j,3);
GHG_sheng(i,3)=GHG_sheng(i,3)+GHG_ideal(j,3);
D_sheng(i,3)=D_sheng(i,3)+D_county(j,3)./10^6;
end
if WC(j,2)==3
else
TC_sheng(i,2)=TC_sheng(i,2)+TC_ideal(j,2);
GHG_sheng(i,2)=GHG_sheng(i,2)+GHG_ideal(j,2);
D_sheng(i,2)=D_sheng(i,2)+D_county(j,2)./10^6;
TC_sheng(i,4)=TC_sheng(i,4)+TC_ideal(j,4);
GHG_sheng(i,4)=GHG_sheng(i,4)+GHG_ideal(j,4);
D_sheng(i,4)=D_sheng(i,4)+D_county(j,4)./10^6;
end
end
    end
TC_sheng(10,:)=TC_sheng(10,:)+TC_ideal(2901,:);
GHG_sheng(10,:)=TC_sheng(10,:)+GHG_ideal(2901,:);
D_sheng(10,:)=D_sheng(10,:)+D_county(2901,:)./10^6;
TC_average=TC_sheng./(D_sheng./0.95);%B CNY/Mt H2
GHG_average=GHG_sheng./(D_sheng./0.95);%Mt CO2eq/Mt H2
TC_average_counties=zeros(2901,4);
GHG_average_counties=zeros(2901,4);
for i=1:31
for j=KS(1,i):JS(1,i)
TC_average_counties(j,:)=TC_average(i,:);%B CNY/Mt H2
GHG_average_counties(j,:)=GHG_average(i,:);%Mt CO2eq/Mt H2
end
end
for i=1:2901
if  WC(i,1)==3
    TC_S1(i,1)=TC_average_counties(i,1).*D_county(i,1)./10^6./0.95-TC_ideal(i,1)+C_S1(i,1).*D_county(i,1)./10^6;
    TC_S1(i,3)=TC_average_counties(i,3).*D_county(i,3)./10^6./0.95-TC_ideal(i,3)+C_S1(i,1).*D_county(i,3)./10^6;
    GHG_S1(i,1)=-GHG_average_counties(i,1).*D_county(i,1)./10^6./0.95+GHG_ideal(i,1)-0.049.*(1-0.259)./1000.*DIS(i,1).*D_county(i,1)./10^6;
    GHG_S1(i,3)=-GHG_average_counties(i,3).*D_county(i,3)./10^6./0.95+GHG_ideal(i,3)-0.049.*(1-0.259)./1000.*DIS(i,1).*D_county(i,3)./10^6;
else    
end
if  WC(i,2)==3
    TC_S1(i,2)=TC_average_counties(i,2).*D_county(i,2)./10^6./0.95-TC_ideal(i,2)+C_S1(i,2).*D_county(i,2)./10^6;
    TC_S1(i,4)=TC_average_counties(i,4).*D_county(i,4)./10^6./0.95-TC_ideal(i,4)+C_S1(i,2).*D_county(i,4)./10^6;
    GHG_S1(i,2)=-GHG_average_counties(i,2).*D_county(i,2)./10^6./0.95+GHG_ideal(i,2)-0.049.*(1-0.852)./1000.*DIS(i,2).*D_county(i,2)./10^6;
    GHG_S1(i,4)=-GHG_average_counties(i,4).*D_county(i,4)./10^6./0.95+GHG_ideal(i,4)-0.049.*(1-0.852)./1000.*DIS(i,2).*D_county(i,4)./10^6;
else    
end
end
for i=1:2901
    for j=1:2
if A(i,j)==1
    TC_S1_SEA(i,j)=TC_S1(i,j);%B CNY
    GHG_S1_SEA(i,j)=GHG_S1(i,j);%Mt CO2eq
    TC_S1_SEA(i,j+2)=TC_S1(i,j+2);%B CNY
    GHG_S1_SEA(i,j+2)=GHG_S1(i,j+2);%Mt CO2eq
 elseif  A(i,j)==2
    TC_S1_LAND(i,j)=TC_S1(i,j);%B CNY
    GHG_S1_LAND(i,j)=GHG_S1(i,j);%Mt CO2eq
    TC_S1_LAND(i,j+2)=TC_S1(i,j+2);%B CNY
    GHG_S1_LAND(i,j+2)=GHG_S1(i,j+2);%Mt CO2eq
else
end
end
end
DJ_S1_SEA=sum(TC_S1_SEA)./sum(D_wc_SEA).*1000;%CNY/t
DJ_S1_LAND=sum(TC_S1_LAND)./sum(D_wc_LAND).*1000;
GHGperH2_S1_SEA=sum(GHG_S1_SEA)./sum(D_wc_SEA);%tCO2/t,+:mitigation;-:increase GHG
GHGperH2_S1_LAND=sum(GHG_S1_LAND)./sum(D_wc_LAND);
 %S2: green hydrogen is produced in China's unconstrained counties, and then transported to the constrained counties via new steel pipelines with a diameter of 48 inches and operating at 80 bar
C_S2(1,1)=(0.0163.*652+6.766).*1000./(1.02^10)./1000;%B CNY/Mt H2
C_S2(1,2)=(0.0163.*652+6.766).*1000./(1.02^30)./1000;
TC_china=zeros(1,4);
GHG_china=zeros(1,4);
D_china=zeros(1,4);
for i=1:2901
if WC(j,1)==3
else
TC_china(1,1)=TC_china(1,1)+TC_ideal(i,1);
TC_china(1,3)=TC_china(1,3)+TC_ideal(i,3);
GHG_china(1,1)=GHG_china(1,1)+GHG_ideal(i,1);
GHG_china(1,3)=GHG_china(1,3)+GHG_ideal(i,3);
D_china(1,1)=D_china(1,1)+D_county(i,1)./10^6;
D_china(1,3)=D_china(1,3)+D_county(i,3)./10^6;
end
if WC(j,2)==3
else
TC_china(1,2)=TC_china(1,2)+TC_ideal(i,2);%B
TC_china(1,4)=TC_china(1,4)+TC_ideal(i,4);
GHG_china(1,2)=GHG_china(1,2)+GHG_ideal(i,2);%Mt
GHG_china(1,4)=GHG_china(1,4)+GHG_ideal(i,4);
D_china(1,2)=D_china(1,2)+D_county(i,2)./10^6;%Mt
D_china(1,4)=D_china(1,4)+D_county(i,4)./10^6;
end
end
TC_average_china=TC_china./(D_china./0.95);% B/Mt H2
GHG_average_china=GHG_china./(D_china./0.95);% Mt CO2/Mt H2
for i=1:2901
    for j=1:4
    if MC(i,j)==1
        if j==1||j==3
EF_ppl(i,j)=EF_power(i,2)./10^6;%MtCO2/MWh
        else
EF_ppl(i,j)=EF_power(i,3)./10^6;
        end
    elseif MC(i,j)==2
EF_ppl(i,j)=CF(i,3)./10^6;        
    elseif MC(i,j)==3
EF_ppl(i,j)=CF(i,4)./10^6;         
    else
    end
    end
end
for i=1:2901
if  WC(i,1)==3
TC_S2(i,1)=TC_average_china(1,1).*D_county(i,1)./10^6./(0.95-0.00004.*652)-TC_ideal(i,1)+C_S2(1,1).*D_county(i,1)./10^6./(0.95-0.00004.*652);%B
TC_S2(i,3)=TC_average_china(1,3).*D_county(i,3)./10^6./(0.95-0.00004.*652)-TC_ideal(i,3)+C_S2(1,1).*D_county(i,3)./10^6./(0.95-0.00004.*652);
GHG_S2(i,1)=GHG_ideal(i,1)-GHG_average_china(1,1).*D_county(i,1)./10^6./(0.95-0.00004.*652)-((0.71./10^3.*10^9+0.426./10^6.*10^9.*652+0.24./10^6.*10^9).*EF_ppl(i,1)+652.*0.24.*(1-0.17)./10^12.*10^9).*D_county(i,1)./10^6./(0.95-0.00004.*652);
GHG_S2(i,3)=GHG_ideal(i,3)-GHG_average_china(1,3).*D_county(i,3)./10^6./(0.95-0.00004.*652)-((0.71./10^3.*10^9+0.426./10^6.*10^9.*652+0.24./10^6.*10^9).*EF_ppl(i,3)+652.*0.24.*(1-0.17)./10^12.*10^9).*D_county(i,3)./10^6./(0.95-0.00004.*652);
else
end
if  WC(i,2)==3
TC_S2(i,2)=TC_average_china(1,2).*D_county(i,2)./10^6./(0.95-0.00004.*652)-TC_ideal(i,2)+C_S2(1,2).*D_county(i,2)./10^6./(0.95-0.00004.*652);
TC_S2(i,4)=TC_average_china(1,4).*D_county(i,4)./10^6./(0.95-0.00004.*652)-TC_ideal(i,4)+C_S2(1,2).*D_county(i,4)./10^6./(0.95-0.00004.*652);
GHG_S2(i,2)=GHG_ideal(i,2)-GHG_average_china(1,2).*D_county(i,2)./10^6./(0.95-0.00004.*652)-((0.71./10^3.*10^9+0.426./10^6.*10^9.*652+0.24./10^6.*10^9).*EF_ppl(i,2)+652.*0.24.*(1-0.51)./10^12.*10^9).*D_county(i,2)./10^6./(0.95-0.00004.*652);
GHG_S2(i,4)=GHG_ideal(i,4)-GHG_average_china(1,4).*D_county(i,4)./10^6./(0.95-0.00004.*652)-((0.71./10^3.*10^9+0.426./10^6.*10^9.*652+0.24./10^6.*10^9).*EF_ppl(i,4)+652.*0.24.*(1-0.51)./10^12.*10^9).*D_county(i,4)./10^6./(0.95-0.00004.*652);
else
end
end
for i=1:2901
    for j=1:2
if A(i,j)==1
    TC_S2_SEA(i,j)=TC_S2(i,j);%B CNY
    GHG_S2_SEA(i,j)=GHG_S2(i,j);%Mt CO2eq
    TC_S2_SEA(i,j+2)=TC_S2(i,j+2);%B CNY
    GHG_S2_SEA(i,j+2)=GHG_S2(i,j+2);%Mt CO2eq
 elseif  A(i,j)==2
    TC_S2_LAND(i,j)=TC_S2(i,j);%B CNY
    GHG_S2_LAND(i,j)=GHG_S2(i,j);%Mt CO2eq
    TC_S2_LAND(i,j+2)=TC_S2(i,j+2);%B CNY
    GHG_S2_LAND(i,j+2)=GHG_S2(i,j+2);%Mt CO2eq
else
end
end
end
DJ_S2_SEA=sum(TC_S2_SEA)./sum(D_wc_SEA).*1000;%CNY/t
DJ_S2_LAND=sum(TC_S2_LAND)./sum(D_wc_LAND).*1000;
GHGperH2_S2_SEA=sum(GHG_S2_SEA)./sum(D_wc_SEA);%tCO2/t,+:mitigation;-:increase GHG
GHGperH2_S2_LAND=sum(GHG_S2_LAND)./sum(D_wc_LAND);
%%%% Cost-effective
GHGperH2_S1_SEA=-GHGperH2_S1_SEA;
GHGperH2_S1_LAND=-GHGperH2_S1_LAND;
GHGperH2_S2_SEA=-GHGperH2_S2_SEA;
GHGperH2_S2_LAND=-GHGperH2_S2_LAND;
GHGperH2_S3_SEA=-GHGperH2_S3_SEA;
GHGperH2_S3_LAND=-GHGperH2_S3_LAND;
GHGperH2_S4_SEA=-GHGperH2_S4_SEA;
%%%%%% County-specific solutions
GHG_S1(2854:2901,:)=0;
GHG_S2(2854:2901,:)=0;
GHG_APS30(:,1)=GHG_S1(:,1);%Mt CO2eq
GHG_APS30(:,2)=GHG_S2(:,1);
GHG_APS30(:,3)=GHG_S3(:,1);
GHG_APS30(:,4)=GHG_S4(:,1);
GHG_APS50(:,1)=GHG_S1(:,2);
GHG_APS50(:,2)=GHG_S2(:,2);
GHG_APS50(:,3)=GHG_S3(:,2);
GHG_APS50(:,4)=GHG_S4(:,2);
GHG_CHA30(:,1)=GHG_S1(:,3);
GHG_CHA30(:,2)=GHG_S2(:,3);
GHG_CHA30(:,3)=GHG_S3(:,3);
GHG_CHA30(:,4)=GHG_S4(:,3);
GHG_CHA50(:,1)=GHG_S1(:,4);
GHG_CHA50(:,2)=GHG_S2(:,4);
GHG_CHA50(:,3)=GHG_S3(:,4);
GHG_CHA50(:,4)=GHG_S4(:,4);
TC_S1(2854:2901,:)=0;
TC_S2(2854:2901,:)=0;
TC_APS30(:,1)=TC_S1(:,1);%Mt CO2eq
TC_APS30(:,2)=TC_S2(:,1);
TC_APS30(:,3)=TC_S3(:,1);
TC_APS30(:,4)=TC_S4(:,1);
TC_APS50(:,1)=TC_S1(:,2);
TC_APS50(:,2)=TC_S2(:,2);
TC_APS50(:,3)=TC_S3(:,2);
TC_APS50(:,4)=TC_S4(:,2);
TC_CHA30(:,1)=TC_S1(:,3);
TC_CHA30(:,2)=TC_S2(:,3);
TC_CHA30(:,3)=TC_S3(:,3);
TC_CHA30(:,4)=TC_S4(:,3);
TC_CHA50(:,1)=TC_S1(:,4);
TC_CHA50(:,2)=TC_S2(:,4);
TC_CHA50(:,3)=TC_S3(:,4);
TC_CHA50(:,4)=TC_S4(:,4);
for i=1:2901
    if GHG_wc(i,1)==0
    else
GHG_APS30(i,1)=GHG_wc(i,1)+GHG_APS30(i,1);
GHG_APS30(i,2)=GHG_wc(i,1)+GHG_APS30(i,2);
GHG_APS30(i,3)=GHG_wc(i,1)+GHG_APS30(i,3);
GHG_APS30(i,4)=GHG_wc(i,1)+GHG_APS30(i,4);
    end
    if GHG_wc(i,2)==0
    else
GHG_APS50(i,1)=GHG_wc(i,2)+GHG_APS50(i,1);
GHG_APS50(i,2)=GHG_wc(i,2)+GHG_APS50(i,2);
GHG_APS50(i,3)=GHG_wc(i,2)+GHG_APS50(i,3);
GHG_APS50(i,4)=GHG_wc(i,2)+GHG_APS50(i,4);
    end
    if GHG_wc(i,3)==0
    else
GHG_CHA30(i,1)=GHG_wc(i,3)+GHG_CHA30(i,1);
GHG_CHA30(i,2)=GHG_wc(i,3)+GHG_CHA30(i,2);
GHG_CHA30(i,3)=GHG_wc(i,3)+GHG_CHA30(i,3);
GHG_CHA30(i,4)=GHG_wc(i,3)+GHG_CHA30(i,4);
    end
    if GHG_wc(i,4)==0
    else
GHG_CHA50(i,1)=GHG_wc(i,4)+GHG_CHA50(i,1);
GHG_CHA50(i,2)=GHG_wc(i,4)+GHG_CHA50(i,2);
GHG_CHA50(i,3)=GHG_wc(i,4)+GHG_CHA50(i,3);
GHG_CHA50(i,4)=GHG_wc(i,4)+GHG_CHA50(i,4);
    end    
end
GHG_APS30_SEA=zeros(2901,4);
GHG_APS30_LAND=zeros(2901,4);
TC_APS30_SEA=zeros(2901,4);
TC_APS30_LAND=zeros(2901,4);
GHG_APS50_SEA=zeros(2901,4);
GHG_APS50_LAND=zeros(2901,4);
TC_APS50_SEA=zeros(2901,4);
TC_APS50_LAND=zeros(2901,4);
GHG_CHA30_SEA=zeros(2901,4);
GHG_CHA30_LAND=zeros(2901,4);
TC_CHA30_SEA=zeros(2901,4);
TC_CHA30_LAND=zeros(2901,4);
GHG_CHA50_SEA=zeros(2901,4);
GHG_CHA50_LAND=zeros(2901,4);
TC_CHA50_SEA=zeros(2901,4);
TC_CHA50_LAND=zeros(2901,4);
for i=1:2901
if A(i,1)==1
GHG_APS30_SEA(i,:)=GHG_APS30(i,:);
GHG_CHA30_SEA(i,:)=GHG_CHA30(i,:);
TC_APS30_SEA(i,:)=TC_APS30(i,:);
TC_CHA30_SEA(i,:)=TC_CHA30(i,:);
elseif  A(i,1)==2
GHG_APS30_LAND(i,:)=GHG_APS30(i,:);
GHG_CHA30_LAND(i,:)=GHG_CHA30(i,:);
TC_APS30_LAND(i,:)=TC_APS30(i,:);
TC_CHA30_LAND(i,:)=TC_CHA30(i,:);
else
end
if A(i,2)==1
GHG_APS50_SEA(i,:)=GHG_APS50(i,:);
GHG_CHA50_SEA(i,:)=GHG_CHA50(i,:);
TC_APS50_SEA(i,:)=TC_APS50(i,:);
TC_CHA50_SEA(i,:)=TC_CHA50(i,:);
elseif  A(i,2)==2
GHG_APS50_LAND(i,:)=GHG_APS50(i,:);
GHG_CHA50_LAND(i,:)=GHG_CHA50(i,:);
TC_APS50_LAND(i,:)=TC_APS50(i,:);
TC_CHA50_LAND(i,:)=TC_CHA50(i,:);
else
end
end
% Maximum mitigation solution 
GHG_max_SEA=zeros(4,4);%Row:S1-S4,Column:APS30,50,CHA30,50
GHG_max_LAND=zeros(4,4);
TC_max_SEA=zeros(4,4);%Row:S1-S4,Column:APS30,50,CHA30,50
TC_max_LAND=zeros(4,4);
for i=1:2901
    if A(i,1)==1
 [max_values(i), max_indices(i)] = max(GHG_APS30_SEA(i,:));
    else
        max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_SEA(1,1)=GHG_max_SEA(1,1)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_SEA(2,1)=GHG_max_SEA(2,1)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_SEA(3,1)=GHG_max_SEA(3,1)+max_values(1,i);    
elseif max_indices(1,i)==4
GHG_max_SEA(4,1)=GHG_max_SEA(4,1)+max_values(1,i);   
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_SEA(1,1)=TC_max_SEA(1,1)+TC_APS30(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_SEA(2,1)=TC_max_SEA(2,1)+TC_APS30(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_SEA(3,1)=TC_max_SEA(3,1)+TC_APS30(i,max_indices(1,i));    
elseif max_indices(1,i)==4
TC_max_SEA(4,1)=TC_max_SEA(4,1)+TC_APS30(i,max_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,1)==1
 [max_values(i), max_indices(i)] = max(GHG_CHA30_SEA(i,:));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_SEA(1,3)=GHG_max_SEA(1,3)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_SEA(2,3)=GHG_max_SEA(2,3)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_SEA(3,3)=GHG_max_SEA(3,3)+max_values(1,i);    
elseif max_indices(1,i)==4
GHG_max_SEA(4,3)=GHG_max_SEA(4,3)+max_values(1,i);   
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_SEA(1,3)=TC_max_SEA(1,3)+TC_CHA30(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_SEA(2,3)=TC_max_SEA(2,3)+TC_CHA30(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_SEA(3,3)=TC_max_SEA(3,3)+TC_CHA30(i,max_indices(1,i));    
elseif max_indices(1,i)==4
TC_max_SEA(4,3)=TC_max_SEA(4,3)+TC_CHA30(i,max_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==1
 [max_values(i), max_indices(i)] = max(GHG_APS50_SEA(i,:));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_SEA(1,2)=GHG_max_SEA(1,2)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_SEA(2,2)=GHG_max_SEA(2,2)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_SEA(3,2)=GHG_max_SEA(3,2)+max_values(1,i);    
elseif max_indices(1,i)==4
GHG_max_SEA(4,2)=GHG_max_SEA(4,2)+max_values(1,i);   
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_SEA(1,2)=TC_max_SEA(1,2)+TC_APS50(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_SEA(2,2)=TC_max_SEA(2,2)+TC_APS50(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_SEA(3,2)=TC_max_SEA(3,2)+TC_APS50(i,max_indices(1,i));    
elseif max_indices(1,i)==4
TC_max_SEA(4,2)=TC_max_SEA(4,2)+TC_APS50(i,max_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==1
 [max_values(i), max_indices(i)] = max(GHG_CHA50_SEA(i,:));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_SEA(1,4)=GHG_max_SEA(1,4)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_SEA(2,4)=GHG_max_SEA(2,4)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_SEA(3,4)=GHG_max_SEA(3,4)+max_values(1,i);    
elseif max_indices(1,i)==4
GHG_max_SEA(4,4)=GHG_max_SEA(4,4)+max_values(1,i);   
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_SEA(1,4)=TC_max_SEA(1,4)+TC_CHA50(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_SEA(2,4)=TC_max_SEA(2,4)+TC_CHA50(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_SEA(3,4)=TC_max_SEA(3,4)+TC_CHA50(i,max_indices(1,i));    
elseif max_indices(1,i)==4
TC_max_SEA(4,4)=TC_max_SEA(4,4)+TC_CHA50(i,max_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,1)==2
 [max_values(i), max_indices(i)] = max(GHG_APS30_LAND(i,1:3));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_LAND(1,1)=GHG_max_LAND(1,1)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_LAND(2,1)=GHG_max_LAND(2,1)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_LAND(3,1)=GHG_max_LAND(3,1)+max_values(1,i);     
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_LAND(1,1)=TC_max_LAND(1,1)+TC_APS30(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_LAND(2,1)=TC_max_LAND(2,1)+TC_APS30(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_LAND(3,1)=TC_max_LAND(3,1)+TC_APS30(i,max_indices(1,i));      
else
end
end
for i=1:2901
    if A(i,1)==2
 [max_values(i), max_indices(i)] = max(GHG_CHA30_LAND(i,1:3));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_LAND(1,3)=GHG_max_LAND(1,3)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_LAND(2,3)=GHG_max_LAND(2,3)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_LAND(3,3)=GHG_max_LAND(3,3)+max_values(1,i);     
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_LAND(1,3)=TC_max_LAND(1,3)+TC_CHA30(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_LAND(2,3)=TC_max_LAND(2,3)+TC_CHA30(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_LAND(3,3)=TC_max_LAND(3,3)+TC_CHA30(i,max_indices(1,i));      
else
end
end
for i=1:2901
    if A(i,2)==2
 [max_values(i), max_indices(i)] = max(GHG_APS50_LAND(i,1:3));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_LAND(1,2)=GHG_max_LAND(1,2)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_LAND(2,2)=GHG_max_LAND(2,2)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_LAND(3,2)=GHG_max_LAND(3,2)+max_values(1,i);       
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_LAND(1,2)=TC_max_LAND(1,2)+TC_APS50(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_LAND(2,2)=TC_max_LAND(2,2)+TC_APS50(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_LAND(3,2)=TC_max_LAND(3,2)+TC_APS50(i,max_indices(1,i));    
else
end
end
for i=1:2901
    if A(i,2)==2
 [max_values(i), max_indices(i)] = max(GHG_CHA50_LAND(i,1:3));
    else
                max_indices(i)=0;
    end
end
[aaa,bbb]=size(max_indices);
for i=1:bbb
if max_indices(1,i)==1
GHG_max_LAND(1,4)=GHG_max_LAND(1,4)+max_values(1,i);
elseif max_indices(1,i)==2
GHG_max_LAND(2,4)=GHG_max_LAND(2,4)+max_values(1,i);
elseif max_indices(1,i)==3
GHG_max_LAND(3,4)=GHG_max_LAND(3,4)+max_values(1,i);    
else
end
end
for i=1:bbb
if max_indices(1,i)==1
TC_max_LAND(1,4)=TC_max_LAND(1,4)+TC_CHA50(i,max_indices(1,i));
elseif max_indices(1,i)==2
TC_max_LAND(2,4)=TC_max_LAND(2,4)+TC_CHA50(i,max_indices(1,i));
elseif max_indices(1,i)==3
TC_max_LAND(3,4)=TC_max_LAND(3,4)+TC_CHA50(i,max_indices(1,i));      
else
end
end
% Minimum cost solution
GHG_min_SEA=zeros(4,4);%Row:S1-S4,Column:APS30,50,CHA30,50
GHG_min_LAND=zeros(4,4);
TC_min_SEA=zeros(4,4);%Row:S1-S4,Column:APS30,50,CHA30,50
TC_min_LAND=zeros(4,4);
for i=1:2901
    if A(i,1)==1
 [min_values(i), min_indices(i)] = min(TC_APS30_SEA(i,:));
    else
       min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_SEA(1,1)=GHG_min_SEA(1,1)+GHG_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_SEA(2,1)=GHG_min_SEA(2,1)+GHG_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_SEA(3,1)=GHG_min_SEA(3,1)+GHG_APS30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_SEA(4,1)=GHG_min_SEA(4,1)+GHG_APS30(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_SEA(1,1)=TC_min_SEA(1,1)+TC_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_SEA(2,1)=TC_min_SEA(2,1)+TC_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_SEA(3,1)=TC_min_SEA(3,1)+TC_APS30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_SEA(4,1)=TC_min_SEA(4,1)+TC_APS30(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,1)==1
 [min_values(i), min_indices(i)] = min(TC_CHA30_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_SEA(1,3)=GHG_min_SEA(1,3)+GHG_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_SEA(2,3)=GHG_min_SEA(2,3)+GHG_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_SEA(3,3)=GHG_min_SEA(3,3)+GHG_CHA30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_SEA(4,3)=GHG_min_SEA(4,3)+GHG_CHA30(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_SEA(1,3)=TC_min_SEA(1,3)+TC_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_SEA(2,3)=TC_min_SEA(2,3)+TC_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_SEA(3,3)=TC_min_SEA(3,3)+TC_CHA30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_SEA(4,3)=TC_min_SEA(4,3)+TC_CHA30(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==1
 [min_values(i), min_indices(i)] = min(TC_APS50_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_SEA(1,2)=GHG_min_SEA(1,2)+GHG_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_SEA(2,2)=GHG_min_SEA(2,2)+GHG_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_SEA(3,2)=GHG_min_SEA(3,2)+GHG_APS50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_SEA(4,2)=GHG_min_SEA(4,2)+GHG_APS50(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_SEA(1,2)=TC_min_SEA(1,2)+TC_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_SEA(2,2)=TC_min_SEA(2,2)+TC_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_SEA(3,2)=TC_min_SEA(3,2)+TC_APS50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_SEA(4,2)=TC_min_SEA(4,2)+TC_APS50(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==1
 [min_values(i), min_indices(i)] = min(TC_CHA50_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_SEA(1,4)=GHG_min_SEA(1,4)+GHG_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_SEA(2,4)=GHG_min_SEA(2,4)+GHG_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_SEA(3,4)=GHG_min_SEA(3,4)+GHG_CHA50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_SEA(4,4)=GHG_min_SEA(4,4)+GHG_CHA50(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_SEA(1,4)=TC_min_SEA(1,4)+TC_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_SEA(2,4)=TC_min_SEA(2,4)+TC_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_SEA(3,4)=TC_min_SEA(3,4)+TC_CHA50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_SEA(4,4)=TC_min_SEA(4,4)+TC_CHA50(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,1)==2
 [min_values(i), min_indices(i)] = min(TC_APS30_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_LAND(1,1)=GHG_min_LAND(1,1)+GHG_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_LAND(2,1)=GHG_min_LAND(2,1)+GHG_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_LAND(3,1)=GHG_min_LAND(3,1)+GHG_APS30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_LAND(4,1)=GHG_min_LAND(4,1)+GHG_APS30(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_LAND(1,1)=TC_min_LAND(1,1)+TC_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_LAND(2,1)=TC_min_LAND(2,1)+TC_APS30(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_LAND(3,1)=TC_min_LAND(3,1)+TC_APS30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_LAND(4,1)=TC_min_LAND(4,1)+TC_APS30(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,1)==2
 [min_values(i), min_indices(i)] = min(TC_CHA30_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_LAND(1,3)=GHG_min_LAND(1,3)+GHG_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_LAND(2,3)=GHG_min_LAND(2,3)+GHG_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_LAND(3,3)=GHG_min_LAND(3,3)+GHG_CHA30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_LAND(4,3)=GHG_min_LAND(4,3)+GHG_CHA30(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_LAND(1,3)=TC_min_LAND(1,3)+TC_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_LAND(2,3)=TC_min_LAND(2,3)+TC_CHA30(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_LAND(3,3)=TC_min_LAND(3,3)+TC_CHA30(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_LAND(4,3)=TC_min_LAND(4,3)+TC_CHA30(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==2
 [min_values(i), min_indices(i)] = min(TC_APS50_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_LAND(1,2)=GHG_min_LAND(1,2)+GHG_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_LAND(2,2)=GHG_min_LAND(2,2)+GHG_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_LAND(3,2)=GHG_min_LAND(3,2)+GHG_APS50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_LAND(4,2)=GHG_min_LAND(4,2)+GHG_APS50(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_LAND(1,2)=TC_min_LAND(1,2)+TC_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_LAND(2,2)=TC_min_LAND(2,2)+TC_APS50(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_LAND(3,2)=TC_min_LAND(3,2)+TC_APS50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_LAND(4,2)=TC_min_LAND(4,2)+TC_APS50(i,min_indices(1,i));   
else
end
end
for i=1:2901
    if A(i,2)==2
 [min_values(i), min_indices(i)] = min(TC_CHA50_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
[aaa,bbb]=size(min_indices);
for i=1:bbb
if min_indices(1,i)==1
GHG_min_LAND(1,4)=GHG_min_LAND(1,4)+GHG_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==2
GHG_min_LAND(2,4)=GHG_min_LAND(2,4)+GHG_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==3
GHG_min_LAND(3,4)=GHG_min_LAND(3,4)+GHG_CHA50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
GHG_min_LAND(4,4)=GHG_min_LAND(4,4)+GHG_CHA50(i,min_indices(1,i));   
else
end
end
for i=1:bbb
if min_indices(1,i)==1
TC_min_LAND(1,4)=TC_min_LAND(1,4)+TC_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==2
TC_min_LAND(2,4)=TC_min_LAND(2,4)+TC_CHA50(i,min_indices(1,i));
elseif min_indices(1,i)==3
TC_min_LAND(3,4)=TC_min_LAND(3,4)+TC_CHA50(i,min_indices(1,i));    
elseif min_indices(1,i)==4
TC_min_LAND(4,4)=TC_min_LAND(4,4)+TC_CHA50(i,min_indices(1,i));   
else
end
end
%%% identify cities' solutions
%1-aps2030MAX；2-aps2050MAX；3-aps2030Min；4-aps2050Min
CHOICE=zeros(2901,4);
for i=1:2901
    if A(i,1)==1%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_APS30_SEA(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE(:,1)=CHOICE(:,1)+max_indices';
for i=1:2901
    if A(i,1)==2%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_APS30_LAND(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE(:,1)=CHOICE(:,1)+max_indices';

for i=1:2901
    if A(i,2)==1%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_APS50_SEA(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE(:,2)=CHOICE(:,2)+max_indices';
for i=1:2901
    if A(i,2)==2%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_APS50_LAND(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE(:,2)=CHOICE(:,2)+max_indices';

for i=1:2901
    if A(i,1)==1
 [min_values(i), min_indices(i)] = min(TC_APS30_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE(:,3)=CHOICE(:,3)+min_indices';
for i=1:2901
    if A(i,1)==2
 [min_values(i), min_indices(i)] = min(TC_APS30_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE(:,3)=CHOICE(:,3)+min_indices';

for i=1:2901
    if A(i,2)==1
 [min_values(i), min_indices(i)] = min(TC_APS50_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE(:,4)=CHOICE(:,4)+min_indices';
for i=1:2901
    if A(i,2)==2
 [min_values(i), min_indices(i)] = min(TC_APS50_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE(:,4)=CHOICE(:,4)+min_indices';

CHOICE2=zeros(2901,4);
for i=1:2901
    if A(i,1)==1%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_CHA30_SEA(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE2(:,1)=CHOICE2(:,1)+max_indices';
for i=1:2901
    if A(i,1)==2%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_CHA30_LAND(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE2(:,1)=CHOICE2(:,1)+max_indices';
 
for i=1:2901
    if A(i,2)==1%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_CHA50_SEA(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE2(:,2)=CHOICE2(:,2)+max_indices';
for i=1:2901
    if A(i,2)==2%0-No constrained;1-coastal;2-Land
 [max_values(i), max_indices(i)] = max(GHG_CHA50_LAND(i,:));
    else
        max_indices(i)=0;
    end
end
CHOICE2(:,2)=CHOICE2(:,2)+max_indices';
 
for i=1:2901
    if A(i,1)==1
 [min_values(i), min_indices(i)] = min(TC_CHA30_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE2(:,3)=CHOICE2(:,3)+min_indices';
for i=1:2901
    if A(i,1)==2
 [min_values(i), min_indices(i)] = min(TC_CHA30_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE2(:,3)=CHOICE2(:,3)+min_indices';
 
for i=1:2901
    if A(i,2)==1
 [min_values(i), min_indices(i)] = min(TC_CHA50_SEA(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE2(:,4)=CHOICE2(:,4)+min_indices';
for i=1:2901
    if A(i,2)==2
 [min_values(i), min_indices(i)] = min(TC_CHA50_LAND(i,:));
    else
               min_indices(i)=0;
    end
end
CHOICE2(:,4)=CHOICE2(:,4)+min_indices';
%%%%% Figure 1
D_wc_province=zeros(31,4);
for i=1:31
for j=KS(1,i):JS(1,i)
D_wc_province(i,:)=D_wc_province(i,:)+D_wc(j,:)./10^6;%Mt H2
end
end
D_wc_province(10,:)=D_wc_province(10,:)+D_wc(2901,:);
sum(D_wc_province);
%%%%% Figure 2
%FIG2a
sum(GHG_wc)./sum(GHG_ideal);%受限制的总比例
GHG_el_power=zeros(2901,4);
    GHG_el_building=zeros(2901,4);
    GHG_el_truck=zeros(2901,4);
    GHG_el_bus=zeros(2901,4);
    GHG_el_car=zeros(2901,4);
    GHG_el_ship=zeros(2901,4);
    GHG_el_air=zeros(2901,4);
    GHG_el_ammonia=zeros(2901,4);
    GHG_el_methanol=zeros(2901,4);
    GHG_el_oil=zeros(2901,4);
    GHG_el_ng=zeros(2901,4);
    GHG_el_olefin=zeros(2901,4);
    GHG_el_eg=zeros(2901,4);
    GHG_el_metallurgy=zeros(2901,4);
    GHG_el_refining=zeros(2901,4);
    GHG_el_fuel=zeros(2901,4);
    GHG_el_synfuel=zeros(2901,4);
for i=1:2901
for    j=1:2
    if MC(i,j)==1
    GHG_el_power(i,j)=GHG_WW_power_grid(i,j)-GHG_PRO_grid(i,j);
    GHG_el_building(i,j)=GHG_WW_building_grid(i,j)-GHG_PRO_grid(i,j+2);
    GHG_el_truck(i,j)=GHG_WW_truck_grid(i,j)-GHG_PRO_grid(i,j+4);
    GHG_el_bus(i,j)=GHG_WW_bus_grid(i,j)-GHG_PRO_grid(i,j+6);
    GHG_el_car(i,j)=GHG_WW_car_grid(i,j)-GHG_PRO_grid(i,j+8);
    GHG_el_ship(i,j)=GHG_WW_ship_grid(i,j)-GHG_PRO_grid(i,j+10);
    GHG_el_air(i,j)=GHG_WW_air_grid(i,j)-GHG_PRO_grid(i,j+12);
    GHG_el_ammonia(i,j)=GHG_WW_ammonia_grid(i,j)-GHG_PRO_grid(i,j+14);
    GHG_el_methanol(i,j)=GHG_WW_methanol_grid(i,j)-GHG_PRO_grid(i,j+16);
    GHG_el_oil(i,j)=GHG_WW_oil_grid(i,j)-GHG_PRO_grid(i,j+60);
    GHG_el_ng(i,j)=GHG_WW_ng_grid(i,j)-GHG_PRO_grid(i,j+62);
    GHG_el_olefin(i,j)=GHG_WW_olefin_grid(i,j)-GHG_PRO_grid(i,j+64);
    GHG_el_eg(i,j)=GHG_WW_eg_grid(i,j)-GHG_PRO_grid(i,j+66);
    GHG_el_metallurgy(i,j)=GHG_WW_metallurgy_grid(i,j)-GHG_PRO_grid(i,j+20);
    GHG_el_refining(i,j)=GHG_WW_refining_grid(i,j)-GHG_PRO_grid(i,j+26);
    GHG_el_fuel(i,j)=GHG_WW_fuel_grid(i,j)-GHG_PRO_grid(i,j+22);
    GHG_el_synfuel(i,j)=GHG_WW_synfuel_grid(i,j)-GHG_PRO_grid(i,j+24);
    elseif MC(i,j)==2
    GHG_el_power(i,j)=GHG_WW_power_pv(i,j)-GHG_PRO_pv(i,j);
    GHG_el_building(i,j)=GHG_WW_building_pv(i,j)-GHG_PRO_pv(i,j+2);
    GHG_el_truck(i,j)=GHG_WW_truck_pv(i,j)-GHG_PRO_pv(i,j+4);
    GHG_el_bus(i,j)=GHG_WW_bus_pv(i,j)-GHG_PRO_pv(i,j+6);
    GHG_el_car(i,j)=GHG_WW_car_pv(i,j)-GHG_PRO_pv(i,j+8);
    GHG_el_ship(i,j)=GHG_WW_ship_pv(i,j)-GHG_PRO_pv(i,j+10);
    GHG_el_air(i,j)=GHG_WW_air_pv(i,j)-GHG_PRO_pv(i,j+12);
    GHG_el_ammonia(i,j)=GHG_WW_ammonia_pv(i,j)-GHG_PRO_pv(i,j+14);
    GHG_el_methanol(i,j)=GHG_WW_methanol_pv(i,j)-GHG_PRO_pv(i,j+16);
    GHG_el_oil(i,j)=GHG_WW_oil_pv(i,j)-GHG_PRO_pv(i,j+60);
    GHG_el_ng(i,j)=GHG_WW_ng_pv(i,j)-GHG_PRO_pv(i,j+62);
    GHG_el_olefin(i,j)=GHG_WW_olefin_pv(i,j)-GHG_PRO_pv(i,j+64);
    GHG_el_eg(i,j)=GHG_WW_eg_pv(i,j)-GHG_PRO_pv(i,j+66);
    GHG_el_metallurgy(i,j)=GHG_WW_metallurgy_pv(i,j)-GHG_PRO_pv(i,j+20);
    GHG_el_refining(i,j)=GHG_WW_refining_pv(i,j)-GHG_PRO_pv(i,j+26);
    GHG_el_fuel(i,j)=GHG_WW_fuel_pv(i,j)-GHG_PRO_pv(i,j+22);
    GHG_el_synfuel(i,j)=GHG_WW_synfuel_pv(i,j)-GHG_PRO_pv(i,j+24);        
    elseif MC(i,j)==3
    GHG_el_power(i,j)=GHG_WW_power_wind(i,j)-GHG_PRO_wind(i,j);
    GHG_el_building(i,j)=GHG_WW_building_wind(i,j)-GHG_PRO_wind(i,j+2);
    GHG_el_truck(i,j)=GHG_WW_truck_wind(i,j)-GHG_PRO_wind(i,j+4);
    GHG_el_bus(i,j)=GHG_WW_bus_wind(i,j)-GHG_PRO_wind(i,j+6);
    GHG_el_car(i,j)=GHG_WW_car_wind(i,j)-GHG_PRO_wind(i,j+8);
    GHG_el_ship(i,j)=GHG_WW_ship_wind(i,j)-GHG_PRO_wind(i,j+10);
    GHG_el_air(i,j)=GHG_WW_air_wind(i,j)-GHG_PRO_wind(i,j+12);
    GHG_el_ammonia(i,j)=GHG_WW_ammonia_wind(i,j)-GHG_PRO_wind(i,j+14);
    GHG_el_methanol(i,j)=GHG_WW_methanol_wind(i,j)-GHG_PRO_wind(i,j+16);
    GHG_el_oil(i,j)=GHG_WW_oil_wind(i,j)-GHG_PRO_wind(i,j+60);
    GHG_el_ng(i,j)=GHG_WW_ng_wind(i,j)-GHG_PRO_wind(i,j+62);
    GHG_el_olefin(i,j)=GHG_WW_olefin_wind(i,j)-GHG_PRO_wind(i,j+64);
    GHG_el_eg(i,j)=GHG_WW_eg_wind(i,j)-GHG_PRO_wind(i,j+66);
    GHG_el_metallurgy(i,j)=GHG_WW_metallurgy_wind(i,j)-GHG_PRO_wind(i,j+20);
    GHG_el_refining(i,j)=GHG_WW_refining_wind(i,j)-GHG_PRO_wind(i,j+26);
    GHG_el_fuel(i,j)=GHG_WW_fuel_wind(i,j)-GHG_PRO_wind(i,j+22);
    GHG_el_synfuel(i,j)=GHG_WW_synfuel_wind(i,j)-GHG_PRO_wind(i,j+24);   
    else
    end
    if MC(i,j+2)==1
    GHG_el_power(i,j+2)=GHG_WW_power_grid(i,j+2)-GHG_PRO_grid(i,j+30);
    GHG_el_building(i,j+2)=GHG_WW_building_grid(i,j+2)-GHG_PRO_grid(i,j+2+30);
    GHG_el_truck(i,j+2)=GHG_WW_truck_grid(i,j+2)-GHG_PRO_grid(i,j+4+30);
    GHG_el_bus(i,j+2)=GHG_WW_bus_grid(i,j+2)-GHG_PRO_grid(i,j+6+30);
    GHG_el_car(i,j+2)=GHG_WW_car_grid(i,j+2)-GHG_PRO_grid(i,j+8+30);
    GHG_el_ship(i,j+2)=GHG_WW_ship_grid(i,j+2)-GHG_PRO_grid(i,j+10+30);
    GHG_el_air(i,j+2)=GHG_WW_air_grid(i,j+2)-GHG_PRO_grid(i,j+12+30);
    GHG_el_ammonia(i,j+2)=GHG_WW_ammonia_grid(i,j+2)-GHG_PRO_grid(i,j+14+30);
    GHG_el_methanol(i,j+2)=GHG_WW_methanol_grid(i,j+2)-GHG_PRO_grid(i,j+16+30);
    GHG_el_oil(i,j+2)=GHG_WW_oil_grid(i,j+2)-GHG_PRO_grid(i,j+60+8);
    GHG_el_ng(i,j+2)=GHG_WW_ng_grid(i,j+2)-GHG_PRO_grid(i,j+62+8);
    GHG_el_olefin(i,j+2)=GHG_WW_olefin_grid(i,j+2)-GHG_PRO_grid(i,j+64+8);
    GHG_el_eg(i,j+2)=GHG_WW_eg_grid(i,j+2)-GHG_PRO_grid(i,j+66+8);
    GHG_el_metallurgy(i,j+2)=GHG_WW_metallurgy_grid(i,j+2)-GHG_PRO_grid(i,j+20+30);
    GHG_el_refining(i,j+2)=GHG_WW_refining_grid(i,j+2)-GHG_PRO_grid(i,j+26+30);
    GHG_el_fuel(i,j+2)=GHG_WW_fuel_grid(i,j+2)-GHG_PRO_grid(i,j+22+30);
    GHG_el_synfuel(i,j+2)=GHG_WW_synfuel_grid(i,j+2)-GHG_PRO_grid(i,j+24+30);
    elseif MC(i,j+2)==2
    GHG_el_power(i,j+2)=GHG_WW_power_pv(i,j+2)-GHG_PRO_pv(i,j+30);
    GHG_el_building(i,j+2)=GHG_WW_building_pv(i,j+2)-GHG_PRO_pv(i,j+2+30);
    GHG_el_truck(i,j+2)=GHG_WW_truck_pv(i,j+2)-GHG_PRO_pv(i,j+4+30);
    GHG_el_bus(i,j+2)=GHG_WW_bus_pv(i,j+2)-GHG_PRO_pv(i,j+6+30);
    GHG_el_car(i,j+2)=GHG_WW_car_pv(i,j+2)-GHG_PRO_pv(i,j+8+30);
    GHG_el_ship(i,j+2)=GHG_WW_ship_pv(i,j+2)-GHG_PRO_pv(i,j+10+30);
    GHG_el_air(i,j+2)=GHG_WW_air_pv(i,j+2)-GHG_PRO_pv(i,j+12+30);
    GHG_el_ammonia(i,j+2)=GHG_WW_ammonia_pv(i,j+2)-GHG_PRO_pv(i,j+14+30);
    GHG_el_methanol(i,j+2)=GHG_WW_methanol_pv(i,j+2)-GHG_PRO_pv(i,j+16+30);
    GHG_el_oil(i,j+2)=GHG_WW_oil_pv(i,j+2)-GHG_PRO_pv(i,j+60+8);
    GHG_el_ng(i,j+2)=GHG_WW_ng_pv(i,j+2)-GHG_PRO_pv(i,j+62+8);
    GHG_el_olefin(i,j+2)=GHG_WW_olefin_pv(i,j+2)-GHG_PRO_pv(i,j+64+8);
    GHG_el_eg(i,j+2)=GHG_WW_eg_pv(i,j+2)-GHG_PRO_pv(i,j+66+8);
    GHG_el_metallurgy(i,j+2)=GHG_WW_metallurgy_pv(i,j+2)-GHG_PRO_pv(i,j+20+30);
    GHG_el_refining(i,j+2)=GHG_WW_refining_pv(i,j+2)-GHG_PRO_pv(i,j+26+30);
    GHG_el_fuel(i,j+2)=GHG_WW_fuel_pv(i,j+2)-GHG_PRO_pv(i,j+22+30);
    GHG_el_synfuel(i,j+2)=GHG_WW_synfuel_pv(i,j+2)-GHG_PRO_pv(i,j+24+30);
    elseif MC(i,j+2)==3
    GHG_el_power(i,j+2)=GHG_WW_power_wind(i,j+2)-GHG_PRO_wind(i,j+30);
    GHG_el_building(i,j+2)=GHG_WW_building_wind(i,j+2)-GHG_PRO_wind(i,j+2+30);
    GHG_el_truck(i,j+2)=GHG_WW_truck_wind(i,j+2)-GHG_PRO_wind(i,j+4+30);
    GHG_el_bus(i,j+2)=GHG_WW_bus_wind(i,j+2)-GHG_PRO_wind(i,j+6+30);
    GHG_el_car(i,j+2)=GHG_WW_car_wind(i,j+2)-GHG_PRO_wind(i,j+8+30);
    GHG_el_ship(i,j+2)=GHG_WW_ship_wind(i,j+2)-GHG_PRO_wind(i,j+10+30);
    GHG_el_air(i,j+2)=GHG_WW_air_wind(i,j+2)-GHG_PRO_wind(i,j+12+30);
    GHG_el_ammonia(i,j+2)=GHG_WW_ammonia_wind(i,j+2)-GHG_PRO_wind(i,j+14+30);
    GHG_el_methanol(i,j+2)=GHG_WW_methanol_wind(i,j+2)-GHG_PRO_wind(i,j+16+30);
    GHG_el_oil(i,j+2)=GHG_WW_oil_wind(i,j+2)-GHG_PRO_wind(i,j+60+8);
    GHG_el_ng(i,j+2)=GHG_WW_ng_wind(i,j+2)-GHG_PRO_wind(i,j+62+8);
    GHG_el_olefin(i,j+2)=GHG_WW_olefin_wind(i,j+2)-GHG_PRO_wind(i,j+64+8);
    GHG_el_eg(i,j+2)=GHG_WW_eg_wind(i,j+2)-GHG_PRO_wind(i,j+66+8);
    GHG_el_metallurgy(i,j+2)=GHG_WW_metallurgy_wind(i,j+2)-GHG_PRO_wind(i,j+20+30);
    GHG_el_refining(i,j+2)=GHG_WW_refining_wind(i,j+2)-GHG_PRO_wind(i,j+26+30);
    GHG_el_fuel(i,j+2)=GHG_WW_fuel_wind(i,j+2)-GHG_PRO_wind(i,j+22+30);
    GHG_el_synfuel(i,j+2)=GHG_WW_synfuel_wind(i,j+2)-GHG_PRO_wind(i,j+24+30); 
    else
        end
end
end       
GHG_ideal_sector(1,:)=sum(GHG_OU_power)+sum(GHG_el_power);
GHG_ideal_sector(2,:)=sum(GHG_OU_building)+sum(GHG_el_building);
GHG_ideal_sector(3,:)=sum(GHG_OU_truck)+sum(GHG_el_truck);
GHG_ideal_sector(4,:)=sum(GHG_OU_bus)+sum(GHG_el_bus);
GHG_ideal_sector(5,:)=sum(GHG_OU_car)+sum(GHG_el_car);
GHG_ideal_sector(6,:)=sum(GHG_OU_ship)+sum(GHG_el_ship);
GHG_ideal_sector(7,:)=sum(GHG_OU_air)+sum(GHG_el_air);
GHG_ideal_sector(8,:)=sum(GHG_OU_ammonia)+sum(GHG_el_ammonia);
GHG_ideal_sector(9,:)=sum(GHG_OU_methanol)+sum(GHG_el_methanol);
GHG_ideal_sector(10,:)=sum(GHG_OU_oil)+sum(GHG_el_oil);
GHG_ideal_sector(11,:)=sum(GHG_OU_ng)+sum(GHG_el_ng);
GHG_ideal_sector(12,:)=sum(GHG_OU_olefin)+sum(GHG_el_olefin);
GHG_ideal_sector(13,:)=sum(GHG_OU_eg)+sum(GHG_el_eg);
GHG_ideal_sector(14,:)=sum(GHG_OU_metallurgy)+sum(GHG_el_metallurgy);
GHG_ideal_sector(15,:)=sum(GHG_OU_refining)+sum(GHG_el_refining);
GHG_ideal_sector(16,:)=sum(GHG_OU_fuel)+sum(GHG_el_fuel);
GHG_ideal_sector(17,:)=sum(GHG_OU_synfuel)+sum(GHG_el_synfuel);
GHG_OU_power_nwc=zeros(2901,4);
GHG_el_power_nwc=zeros(2901,4);
GHG_OU_building_nwc=zeros(2901,4);
GHG_el_building_nwc=zeros(2901,4);
GHG_OU_truck_nwc=zeros(2901,4);
GHG_el_truck_nwc=zeros(2901,4);
GHG_OU_bus_nwc=zeros(2901,4);
GHG_el_bus_nwc=zeros(2901,4);
GHG_OU_car_nwc=zeros(2901,4);
GHG_el_car_nwc=zeros(2901,4);
GHG_OU_ship_nwc=zeros(2901,4);
GHG_el_ship_nwc=zeros(2901,4);
GHG_OU_air_nwc=zeros(2901,4);
GHG_el_air_nwc=zeros(2901,4);
GHG_OU_ammonia_nwc=zeros(2901,4);
GHG_el_ammonia_nwc=zeros(2901,4);
GHG_OU_methanol_nwc=zeros(2901,4);
GHG_el_methanol_nwc=zeros(2901,4);
GHG_OU_oil_nwc=zeros(2901,4);
GHG_el_oil_nwc=zeros(2901,4);
GHG_OU_ng_nwc=zeros(2901,4);
GHG_el_ng_nwc=zeros(2901,4);
GHG_OU_olefin_nwc=zeros(2901,4);
GHG_el_olefin_nwc=zeros(2901,4);
GHG_OU_eg_nwc=zeros(2901,4);
GHG_el_eg_nwc=zeros(2901,4);
GHG_OU_metallurgy_nwc=zeros(2901,4);
GHG_el_metallurgy_nwc=zeros(2901,4);
GHG_OU_refining_nwc=zeros(2901,4);
GHG_el_refining_nwc=zeros(2901,4);
GHG_OU_fuel_nwc=zeros(2901,4);
GHG_el_fuel_nwc=zeros(2901,4);
GHG_OU_synfuel_nwc=zeros(2901,4);
GHG_el_synfuel_nwc=zeros(2901,4);
for i=1:2901
for j=1:2
    if WC(i,j)==3
    else
GHG_OU_power_nwc(i,j)=GHG_OU_power(i,j);
GHG_el_power_nwc(i,j)=GHG_el_power(i,j);        
GHG_OU_power_nwc(i,j+2)=GHG_OU_power(i,j+2);
GHG_el_power_nwc(i,j+2)=GHG_el_power(i,j+2);
GHG_OU_building_nwc(i,j)=GHG_OU_building(i,j);
GHG_el_building_nwc(i,j)=GHG_el_building(i,j);        
GHG_OU_building_nwc(i,j+2)=GHG_OU_building(i,j+2);
GHG_el_building_nwc(i,j+2)=GHG_el_building(i,j+2);
GHG_OU_truck_nwc(i,j)=GHG_OU_truck(i,j);
GHG_el_truck_nwc(i,j)=GHG_el_truck(i,j);        
GHG_OU_truck_nwc(i,j+2)=GHG_OU_truck(i,j+2);
GHG_el_truck_nwc(i,j+2)=GHG_el_truck(i,j+2);
GHG_OU_bus_nwc(i,j)=GHG_OU_bus(i,j);
GHG_el_bus_nwc(i,j)=GHG_el_bus(i,j);        
GHG_OU_bus_nwc(i,j+2)=GHG_OU_bus(i,j+2);
GHG_el_bus_nwc(i,j+2)=GHG_el_bus(i,j+2);
GHG_OU_car_nwc(i,j)=GHG_OU_car(i,j);
GHG_el_car_nwc(i,j)=GHG_el_car(i,j);        
GHG_OU_car_nwc(i,j+2)=GHG_OU_car(i,j+2);
GHG_el_car_nwc(i,j+2)=GHG_el_car(i,j+2);
GHG_OU_ship_nwc(i,j)=GHG_OU_ship(i,j);
GHG_el_ship_nwc(i,j)=GHG_el_ship(i,j);        
GHG_OU_ship_nwc(i,j+2)=GHG_OU_ship(i,j+2);
GHG_el_ship_nwc(i,j+2)=GHG_el_ship(i,j+2);
GHG_OU_air_nwc(i,j)=GHG_OU_air(i,j);
GHG_el_air_nwc(i,j)=GHG_el_air(i,j);        
GHG_OU_air_nwc(i,j+2)=GHG_OU_air(i,j+2);
GHG_el_air_nwc(i,j+2)=GHG_el_air(i,j+2);
GHG_OU_ammonia_nwc(i,j)=GHG_OU_ammonia(i,j);
GHG_el_ammonia_nwc(i,j)=GHG_el_ammonia(i,j);        
GHG_OU_ammonia_nwc(i,j+2)=GHG_OU_ammonia(i,j+2);
GHG_el_ammonia_nwc(i,j+2)=GHG_el_ammonia(i,j+2);
GHG_OU_methanol_nwc(i,j)=GHG_OU_methanol(i,j);
GHG_el_methanol_nwc(i,j)=GHG_el_methanol(i,j);        
GHG_OU_methanol_nwc(i,j+2)=GHG_OU_methanol(i,j+2);
GHG_el_methanol_nwc(i,j+2)=GHG_el_methanol(i,j+2);
GHG_OU_oil_nwc(i,j)=GHG_OU_oil(i,j);
GHG_el_oil_nwc(i,j)=GHG_el_oil(i,j);        
GHG_OU_oil_nwc(i,j+2)=GHG_OU_oil(i,j+2);
GHG_el_oil_nwc(i,j+2)=GHG_el_oil(i,j+2);
GHG_OU_ng_nwc(i,j)=GHG_OU_ng(i,j);
GHG_el_ng_nwc(i,j)=GHG_el_ng(i,j);        
GHG_OU_ng_nwc(i,j+2)=GHG_OU_ng(i,j+2);
GHG_el_ng_nwc(i,j+2)=GHG_el_ng(i,j+2);
GHG_OU_olefin_nwc(i,j)=GHG_OU_olefin(i,j);
GHG_el_olefin_nwc(i,j)=GHG_el_olefin(i,j);        
GHG_OU_olefin_nwc(i,j+2)=GHG_OU_olefin(i,j+2);
GHG_el_olefin_nwc(i,j+2)=GHG_el_olefin(i,j+2);
GHG_OU_eg_nwc(i,j)=GHG_OU_eg(i,j);
GHG_el_eg_nwc(i,j)=GHG_el_eg(i,j);        
GHG_OU_eg_nwc(i,j+2)=GHG_OU_eg(i,j+2);
GHG_el_eg_nwc(i,j+2)=GHG_el_eg(i,j+2);
GHG_OU_metallurgy_nwc(i,j)=GHG_OU_metallurgy(i,j);
GHG_el_metallurgy_nwc(i,j)=GHG_el_metallurgy(i,j);        
GHG_OU_metallurgy_nwc(i,j+2)=GHG_OU_metallurgy(i,j+2);
GHG_el_metallurgy_nwc(i,j+2)=GHG_el_metallurgy(i,j+2);
GHG_OU_refining_nwc(i,j)=GHG_OU_refining(i,j);
GHG_el_refining_nwc(i,j)=GHG_el_refining(i,j);        
GHG_OU_refining_nwc(i,j+2)=GHG_OU_refining(i,j+2);
GHG_el_refining_nwc(i,j+2)=GHG_el_refining(i,j+2);
GHG_OU_fuel_nwc(i,j)=GHG_OU_fuel(i,j);
GHG_el_fuel_nwc(i,j)=GHG_el_fuel(i,j);        
GHG_OU_fuel_nwc(i,j+2)=GHG_OU_fuel(i,j+2);
GHG_el_fuel_nwc(i,j+2)=GHG_el_fuel(i,j+2);
GHG_OU_synfuel_nwc(i,j)=GHG_OU_synfuel(i,j);
GHG_el_synfuel_nwc(i,j)=GHG_el_synfuel(i,j);        
GHG_OU_synfuel_nwc(i,j+2)=GHG_OU_synfuel(i,j+2);
GHG_el_synfuel_nwc(i,j+2)=GHG_el_synfuel(i,j+2);
    end
end
end
GHG_ideal_sector_nwc(1,:)=sum(GHG_OU_power_nwc)+sum(GHG_el_power_nwc);
GHG_ideal_sector_nwc(2,:)=sum(GHG_OU_building_nwc)+sum(GHG_el_building_nwc);
GHG_ideal_sector_nwc(3,:)=sum(GHG_OU_truck_nwc)+sum(GHG_el_truck_nwc);
GHG_ideal_sector_nwc(4,:)=sum(GHG_OU_bus_nwc)+sum(GHG_el_bus_nwc);
GHG_ideal_sector_nwc(5,:)=sum(GHG_OU_car_nwc)+sum(GHG_el_car_nwc);
GHG_ideal_sector_nwc(6,:)=sum(GHG_OU_ship_nwc)+sum(GHG_el_ship_nwc);
GHG_ideal_sector_nwc(7,:)=sum(GHG_OU_air_nwc)+sum(GHG_el_air_nwc);
GHG_ideal_sector_nwc(8,:)=sum(GHG_OU_ammonia_nwc)+sum(GHG_el_ammonia_nwc);
GHG_ideal_sector_nwc(9,:)=sum(GHG_OU_methanol_nwc)+sum(GHG_el_methanol_nwc);
GHG_ideal_sector_nwc(10,:)=sum(GHG_OU_oil_nwc)+sum(GHG_el_oil_nwc);
GHG_ideal_sector_nwc(11,:)=sum(GHG_OU_ng_nwc)+sum(GHG_el_ng_nwc);
GHG_ideal_sector_nwc(12,:)=sum(GHG_OU_olefin_nwc)+sum(GHG_el_olefin_nwc);
GHG_ideal_sector_nwc(13,:)=sum(GHG_OU_eg_nwc)+sum(GHG_el_eg_nwc);
GHG_ideal_sector_nwc(14,:)=sum(GHG_OU_metallurgy_nwc)+sum(GHG_el_metallurgy_nwc);
GHG_ideal_sector_nwc(15,:)=sum(GHG_OU_refining_nwc)+sum(GHG_el_refining_nwc);
GHG_ideal_sector_nwc(16,:)=sum(GHG_OU_fuel_nwc)+sum(GHG_el_fuel_nwc);
GHG_ideal_sector_nwc(17,:)=sum(GHG_OU_synfuel_nwc)+sum(GHG_el_synfuel_nwc);
FIG2A=GHG_ideal_sector-GHG_ideal_sector_nwc;
sum(GHG_ideal_sector)-sum(GHG_ideal_sector_nwc)
%FIG2b
FIG2b_power=zeros(31,4);
FIG2b_building=zeros(31,4);
FIG2b_transport=zeros(31,4);
FIG2b_industry=zeros(31,4);
for i=1:31
for j=KS(1,i):JS(1,i)
FIG2b_power(i,:)=FIG2b_power(i,:)+GHG_OU_power(j,:)+GHG_el_power(j,:)-GHG_OU_power_nwc(j,:)-GHG_el_power_nwc(j,:);
FIG2b_building(i,:)=FIG2b_building(i,:)+GHG_OU_building(j,:)+GHG_el_building(j,:)-GHG_OU_building_nwc(j,:)-GHG_el_building_nwc(j,:);
FIG2b_transport(i,:)=FIG2b_transport(i,:)+GHG_OU_truck(j,:)+GHG_el_truck(j,:)+GHG_OU_car(j,:)+GHG_el_car(j,:)+GHG_OU_bus(j,:)+GHG_el_bus(j,:)+GHG_OU_ship(j,:)+GHG_el_ship(j,:)+GHG_OU_air(j,:)+GHG_el_air(j,:)-GHG_OU_truck_nwc(j,:)-GHG_el_truck_nwc(j,:)-GHG_OU_car_nwc(j,:)-GHG_el_car_nwc(j,:)-GHG_OU_bus_nwc(j,:)-GHG_el_bus_nwc(j,:)-GHG_OU_ship_nwc(j,:)-GHG_el_ship_nwc(j,:)-GHG_OU_air_nwc(j,:)-GHG_el_air_nwc(j,:);
FIG2b_industry(i,:)=FIG2b_industry(i,:)+GHG_OU_ammonia(j,:)+GHG_el_ammonia(j,:)+GHG_OU_methanol(j,:)+GHG_el_methanol(j,:)+GHG_OU_oil(j,:)+GHG_el_oil(j,:)+GHG_OU_ng(j,:)+GHG_el_ng(j,:)+GHG_OU_olefin(j,:)+GHG_el_olefin(j,:)+GHG_OU_eg(j,:)+GHG_el_eg(j,:)+GHG_OU_metallurgy(j,:)+GHG_el_metallurgy(j,:)+GHG_OU_refining(j,:)+GHG_el_refining(j,:)+GHG_OU_fuel(j,:)+GHG_el_fuel(j,:)+GHG_OU_synfuel(j,:)+GHG_el_synfuel(j,:)-GHG_OU_ammonia_nwc(j,:)-GHG_el_ammonia_nwc(j,:)-GHG_OU_methanol_nwc(j,:)-GHG_el_methanol_nwc(j,:)-GHG_OU_oil_nwc(j,:)-GHG_el_oil_nwc(j,:)-GHG_OU_ng_nwc(j,:)-GHG_el_ng_nwc(j,:)-GHG_OU_olefin_nwc(j,:)-GHG_el_olefin_nwc(j,:)-GHG_OU_eg_nwc(j,:)-GHG_el_eg_nwc(j,:)-GHG_OU_metallurgy_nwc(j,:)-GHG_el_metallurgy_nwc(j,:)-GHG_OU_refining_nwc(j,:)-GHG_el_refining_nwc(j,:)-GHG_OU_fuel_nwc(j,:)-GHG_el_fuel_nwc(j,:)-GHG_OU_synfuel_nwc(j,:)-GHG_el_synfuel_nwc(j,:);
end
end
j=2901;
FIG2b_power(10,:)=FIG2b_power(10,:)+GHG_OU_power(j,:)+GHG_el_power(j,:)-GHG_OU_power_nwc(j,:)-GHG_el_power_nwc(j,:);
FIG2b_building(10,:)=FIG2b_building(10,:)+GHG_OU_building(j,:)+GHG_el_building(j,:)-GHG_OU_building_nwc(j,:)-GHG_el_building_nwc(j,:);
FIG2b_transport(10,:)=FIG2b_transport(10,:)+GHG_OU_truck(j,:)+GHG_el_truck(j,:)+GHG_OU_car(j,:)+GHG_el_car(j,:)+GHG_OU_bus(j,:)+GHG_el_bus(j,:)+GHG_OU_ship(j,:)+GHG_el_ship(j,:)+GHG_OU_air(j,:)+GHG_el_air(j,:)-GHG_OU_truck_nwc(j,:)-GHG_el_truck_nwc(j,:)-GHG_OU_car_nwc(j,:)-GHG_el_car_nwc(j,:)-GHG_OU_bus_nwc(j,:)-GHG_el_bus_nwc(j,:)-GHG_OU_ship_nwc(j,:)-GHG_el_ship_nwc(j,:)-GHG_OU_air_nwc(j,:)-GHG_el_air_nwc(j,:);
FIG2b_industry(10,:)=FIG2b_industry(10,:)+GHG_OU_ammonia(j,:)+GHG_el_ammonia(j,:)+GHG_OU_methanol(j,:)+GHG_el_methanol(j,:)+GHG_OU_oil(j,:)+GHG_el_oil(j,:)+GHG_OU_ng(j,:)+GHG_el_ng(j,:)+GHG_OU_olefin(j,:)+GHG_el_olefin(j,:)+GHG_OU_eg(j,:)+GHG_el_eg(j,:)+GHG_OU_metallurgy(j,:)+GHG_el_metallurgy(j,:)+GHG_OU_refining(j,:)+GHG_el_refining(j,:)+GHG_OU_fuel(j,:)+GHG_el_fuel(j,:)+GHG_OU_synfuel(j,:)+GHG_el_synfuel(j,:)-GHG_OU_ammonia_nwc(j,:)-GHG_el_ammonia_nwc(j,:)-GHG_OU_methanol_nwc(j,:)-GHG_el_methanol_nwc(j,:)-GHG_OU_oil_nwc(j,:)-GHG_el_oil_nwc(j,:)-GHG_OU_ng_nwc(j,:)-GHG_el_ng_nwc(j,:)-GHG_OU_olefin_nwc(j,:)-GHG_el_olefin_nwc(j,:)-GHG_OU_eg_nwc(j,:)-GHG_el_eg_nwc(j,:)-GHG_OU_metallurgy_nwc(j,:)-GHG_el_metallurgy_nwc(j,:)-GHG_OU_refining_nwc(j,:)-GHG_el_refining_nwc(j,:)-GHG_OU_fuel_nwc(j,:)-GHG_el_fuel_nwc(j,:)-GHG_OU_synfuel_nwc(j,:)-GHG_el_synfuel_nwc(j,:);
FIG2b=FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry;

FIG2b_bili_power=FIG2b_power./(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry);
FIG2b_bili_building=FIG2b_building./(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry);
FIG2b_bili_transport=FIG2b_transport./(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry);
FIG2b_bili_industry=FIG2b_industry./(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry);
FIG2b_bili_power_china=sum(FIG2b_power)./(sum(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry));
FIG2b_bili_building_china=sum(FIG2b_building)./(sum(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry));
FIG2b_bili_transport_china=sum(FIG2b_transport)./(sum(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry));
FIG2b_bili_industry_china=sum(FIG2b_industry)./(sum(FIG2b_power+FIG2b_building+FIG2b_transport+FIG2b_industry));
FIG2b_CHINA(1,:)=FIG2b_bili_power_china(1,:);
FIG2b_CHINA(2,:)=FIG2b_bili_building_china(1,:);
FIG2b_CHINA(3,:)=FIG2b_bili_transport_china(1,:);
FIG2b_CHINA(4,:)=FIG2b_bili_industry_china(1,:);

FIG3a=zeros(16,4);
FIG3a(1,1)=GHGperH2_S1_LAND(1,1);
FIG3a(1,2)=GHGperH2_S1_SEA(1,1);
FIG3a(2,1)=GHGperH2_S2_LAND(1,1);
FIG3a(2,2)=GHGperH2_S2_SEA(1,1);
FIG3a(3,1)=GHGperH2_S3_LAND(1,1);
FIG3a(3,2)=GHGperH2_S3_SEA(1,1);
FIG3a(4,1)=0;
FIG3a(4,2)=GHGperH2_S4_SEA(1,1);
FIG3a(1,3)=DJ_S1_LAND(1,1);
FIG3a(1,4)=DJ_S1_SEA(1,1);
FIG3a(2,3)=DJ_S2_LAND(1,1);
FIG3a(2,4)=DJ_S2_SEA(1,1);
FIG3a(3,3)=DJ_S3_LAND(1,1);
FIG3a(3,4)=DJ_S3_SEA(1,1);
FIG3a(4,3)=0;
FIG3a(4,4)=DJ_S4_SEA(1,1);

FIG3a(1+4,1)=GHGperH2_S1_LAND(1,2);
FIG3a(1+4,2)=GHGperH2_S1_SEA(1,2);
FIG3a(2+4,1)=GHGperH2_S2_LAND(1,2);
FIG3a(2+4,2)=GHGperH2_S2_SEA(1,2);
FIG3a(3+4,1)=GHGperH2_S3_LAND(1,2);
FIG3a(3+4,2)=GHGperH2_S3_SEA(1,2);
FIG3a(4+4,1)=0;
FIG3a(4+4,2)=GHGperH2_S4_SEA(1,2);
FIG3a(1+4,3)=DJ_S1_LAND(1,2);
FIG3a(1+4,4)=DJ_S1_SEA(1,2);
FIG3a(2+4,3)=DJ_S2_LAND(1,2);
FIG3a(2+4,4)=DJ_S2_SEA(1,2);
FIG3a(3+4,3)=DJ_S3_LAND(1,2);
FIG3a(3+4,4)=DJ_S3_SEA(1,2);
FIG3a(4+4,3)=0;
FIG3a(4+4,4)=DJ_S4_SEA(1,2);

FIG3a(1+4+4,1)=GHGperH2_S1_LAND(1,3);
FIG3a(1+4+4,2)=GHGperH2_S1_SEA(1,3);
FIG3a(2+4+4,1)=GHGperH2_S2_LAND(1,3);
FIG3a(2+4+4,2)=GHGperH2_S2_SEA(1,3);
FIG3a(3+4+4,1)=GHGperH2_S3_LAND(1,3);
FIG3a(3+4+4,2)=GHGperH2_S3_SEA(1,3);
FIG3a(4+4+4,1)=0;
FIG3a(4+4+4,2)=GHGperH2_S4_SEA(1,3);
FIG3a(1+4+4,3)=DJ_S1_LAND(1,3);
FIG3a(1+4+4,4)=DJ_S1_SEA(1,3);
FIG3a(2+4+4,3)=DJ_S2_LAND(1,3);
FIG3a(2+4+4,4)=DJ_S2_SEA(1,3);
FIG3a(3+4+4,3)=DJ_S3_LAND(1,3);
FIG3a(3+4+4,4)=DJ_S3_SEA(1,3);
FIG3a(4+4+4,3)=0;
FIG3a(4+4+4,4)=DJ_S4_SEA(1,3);

FIG3a(1+4+4+4,1)=GHGperH2_S1_LAND(1,3+1);
FIG3a(1+4+4+4,2)=GHGperH2_S1_SEA(1,3+1);
FIG3a(2+4+4+4,1)=GHGperH2_S2_LAND(1,3+1);
FIG3a(2+4+4+4,2)=GHGperH2_S2_SEA(1,3+1);
FIG3a(3+4+4+4,1)=GHGperH2_S3_LAND(1,3+1);
FIG3a(3+4+4+4,2)=GHGperH2_S3_SEA(1,3+1);
FIG3a(4+4+4+4,1)=0;
FIG3a(4+4+4+4,2)=GHGperH2_S4_SEA(1,3+1);
FIG3a(1+4+4+4,3)=DJ_S1_LAND(1,3+1);
FIG3a(1+4+4+4,4)=DJ_S1_SEA(1,3+1);
FIG3a(2+4+4+4,3)=DJ_S2_LAND(1,3+1);
FIG3a(2+4+4+4,4)=DJ_S2_SEA(1,3+1);
FIG3a(3+4+4+4,3)=DJ_S3_LAND(1,3+1);
FIG3a(3+4+4+4,4)=DJ_S3_SEA(1,3+1);
FIG3a(4+4+4+4,3)=0;
FIG3a(4+4+4+4,4)=DJ_S4_SEA(1,3+1);
FIG3a(:,1:2)=-FIG3a(:,1:2);
FIG3a(:,3:4)=FIG3a(:,3:4)./1000;
sum(TC_ideal).*10^6./sum(D_county)
sum(GHG_ideal_sector).*10^6./sum(D_county)
save XIE20241224.mat






