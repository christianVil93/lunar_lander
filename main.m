clear all; close all;

%% parameters
run('parameters_v2.m');

%% simulation
simout = sim('lunar_lander_v2.slx')

%% post process

sim.s_Lunar = simout.s_Lunar.signals.values(:,1);
sim.time = simout.s_Lunar.time;
% sim.m_Lunar_aktuell = simout.m_Lunar_aktuell.signals.values(:,1);
% sim.g_Mond = simout.g_Mond.signals.values(:,1);
sim.v_Lunar = simout.v_Lunar.signals.values;
sim.m_Fuel = simout.m_Fuel.signals.values;


figure('Name','Apollo 11 Mondlandung','numbertitle','off')
subplot(3,1,1)
plot(sim.time, sim.s_Lunar);
title('Height above Moon Surface');
xlabel('Time [s]');
ylabel('Height [m]');
ylim([-200 s_Lunar+200])
grid on

subplot(3,1,2);
plot(sim.time, sim.v_Lunar);
title('Velocity Lunar Lander')
xlabel('Time [s]');
ylabel('Velocity [m/s]');
ylim([min(sim.v_Lunar)-2 0])
grid on

subplot(3,1,3);
plot(sim.time, sim.m_Fuel);
xlabel('Time [s]');
ylabel('Mass [kg]');
title('Mass of Fuel');
sgtitle(sprintf('Lunar Landing - Entry Velocity: %d m/s', v_Lunar)); 
ylim([-400 m_Tank+400])
grid on



