%% Lunar Lander Main Script
% run this script to simulate moon landing
% 
% This script and simulink model were created by group 20
% Michael Kofler, Cara Drsticka, Christian Mayrhofer & 
% Christian Villscheider
%
% Files needed: lunar_lander.slx
%               parameters.m 
%               plotRocket.m 
%               animate_result.m
%
%
% 2020 written in Matlab2020a

%% parameters
clear; close all; clc;
run('parameters.m');

%% simulation
simout = sim('lunar_lander.slx');

%% post process
% assign simulation output to sim struct
sim.s_Lunar = simout.s_Lunar.signals.values(:,1);
sim.time = simout.s_Lunar.time;
sim.v_Lunar = simout.v_Lunar.signals.values;
sim.m_Fuel = simout.m_Fuel.signals.values;
sim.Bremse = simout.Bremse.signals.values;


%% animation
% prepare subplot figure
fh = figure('Name','Apollo 11 Moon Landing','numbertitle','off');
fh.WindowState = 'maximized';

% prepare height vs. time subplot
plots.s_Lunar = subplot(3,3,2:3);
title('Height above Moon Surface');
xlabel('Time [s]');
ylabel('Height [m]');
ylim([-200 s_Lunar+200])
xlim([0 ceil(sim.time(end))])
set(plots.s_Lunar, 'YLimMode', 'manual');
set(plots.s_Lunar, 'XLimMode', 'manual');
set(plots.s_Lunar,'NextPlot','replacechildren') ;
grid on

% prepare velocity vs. time subplot
plots.v_Lunar = subplot(3,3,5:6);
title('Velocity Lunar Lander')
xlabel('Time [s]');
ylabel('Velocity [m/s]');
ylim([min(sim.v_Lunar)-2 0])
xlim([0 ceil(sim.time(end))])
set(plots.v_Lunar, 'YLimMode', 'manual');
set(plots.v_Lunar, 'XLimMode', 'manual');
set(plots.v_Lunar,'NextPlot','replacechildren') ;
grid on

% prepare fuel vs. time subplot
plots.m_Fuel = subplot(3,3,8:9);
xlabel('Time [s]');
ylabel('Mass [kg]');
title('Mass of Fuel');
ylim([-400 m_Tank+400])
xlim([0 ceil(sim.time(end))])
set(plots.m_Fuel, 'YLimMode', 'manual');
set(plots.m_Fuel, 'XLimMode', 'manual');
set(plots.m_Fuel,'NextPlot','replacechildren') ;
grid on

% prepare visualization subplot
plots.graphic = subplot(3,3,1:3:9);
% plot random stars
stars_per_sqm = 0.0005; % 0.5 stars per square meter
n_stars = ceil(100*max(s_Lunar + 500)*stars_per_sqm); % number of total stars
rand_x = rand(1,n_stars); % generate random x coordinates [0...1]
rand_y = rand(1,n_stars); % generate random y coordinates [0...1]

% rand [0...1] -> meter
scatter(rand_x*100 - 50, rand_y*max(s_Lunar+500),'yellow',...
    'Marker', '*');
box on
hold on

% start animation
animate_result(sim, plots);