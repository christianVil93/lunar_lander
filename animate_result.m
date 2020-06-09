%% animate_result
% animates simulated moon landing

% input: sim...     struct containing s_Lunar, v_Lunar, m_Fuel, Bremse
%        plots...   struct containing axis handles for subplots

function animate_result(sim, plots)
tic
real_time = 0;

% iterate through simulation time in realtime
while real_time < sim.time(end)
    % at every iteration, the time is set to tic to simulate real time
    real_time = toc;
    
    % calculate indizes that are within our current real time
    time_idx = sim.time<real_time;
    
    % extract current values from simulation data
    sim_time = sim.time(time_idx);
    s_Lunar = sim.s_Lunar(time_idx);
    m_Fuel = sim.m_Fuel(time_idx);
    Bremse = sim.Bremse(time_idx);
    v_Lunar = sim.v_Lunar(time_idx);
    
    % update data plots
    plot(plots.s_Lunar, sim_time, s_Lunar);
    plot(plots.v_Lunar, sim_time, v_Lunar);
    plot(plots.m_Fuel, sim_time, m_Fuel);
    
    % update rocket visualization
    plotRocket(plots.graphic, s_Lunar(end), m_Fuel(end), Bremse(end));
    
    % update title to show simulation time
    sgtitle(plots.s_Lunar.Parent,...
        sprintf('Maneuver Time:  %0.2f s', sim_time(end))); 
    drawnow();
end
end