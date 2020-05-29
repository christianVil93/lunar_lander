clc; clear all; close all;

%% parameters
run('parameters.m');

%% simulation
simout = sim('lunar_lander.slx');

%% post process

sim.s_Lunar = simout.s_Lunar.signals.values(:,1);
sim.time = simout.s_Lunar.time;
sim.m_Lunar_aktuell = simout.m_Lunar_aktuell.signals.values(:,1);
sim.g_Mond = simout.g_Mond.signals.values(:,1);

figure(1)
subplot(3,1,1)
plot(sim.time, sim.s_Lunar);
title('Height above Moon Surface');
title('Height [m]');

subplot(3,1,2);
plot(sim.time, sim.m_Lunar_aktuell/10);
title('Mass Lunar Lander')
ylabel('Mass [t]');

subplot(3,1,3);
plot(sim.time, sim.g_Mond);
xlabel('Time [s]');
ylabel('Grav. Acceleration [m]');
title('Moon Gravitational Acceleration');
sgtitle(sprintf('Lunar Landing - Entry Velocity: %d m/s', v_Lunar)); 