clc; clear all; close all;

%% parameters
run('parameters.m');

%% simulation
simout = sim('lunar_lander.slx');

%% post process

sim.s_above_ground = simout.s_Lunar.signals.values(:,1) - r_Mond;
sim.time = simout.s_Lunar.time;
sim.m_Lunar_aktuell = simout.m_Lunar_aktuell.signals.values(:,1);
sim.g_Mond = simout.g_Mond.signals.values(:,1);

figure(1)
subplot(3,1,1)
plot(sim.time, sim.s_above_ground);

subplot(3,1,2);
plot(sim.time, sim.m_Lunar_aktuell);

subplot(3,1,3);
plot(sim.time, sim.g_Mond);