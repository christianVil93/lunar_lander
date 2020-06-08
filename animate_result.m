%% animate_result
% animates simulated moon landing

% input: sim...     struct containing s_Lunar, v_Lunar, m_Fuel, Bremse
%        plots...   struct containing axis handles for subplots

function animate_result(sim, plots)
tic
time = 0;

% iterate through simulation time in realtime
while time < sim.time(end)
    % at every iteration, the time is set to tic, to simulate real time
    time = toc;
    
    time_idx = sim.time<time;
    s_Lunar = sim.s_Lunar(time_idx);
    m_Fuel = sim.m_Fuel(time_idx);
    Bremse = sim.Bremse(time_idx);
    
    % update data plots
    plot(plots.s_Lunar, sim.time(time_idx), s_Lunar);
    plot(plots.v_Lunar, sim.time(time_idx), sim.v_Lunar(time_idx));
    plot(plots.m_Fuel, sim.time(time_idx), m_Fuel);
    
    % update rocket visualization
    plotRocket(plots.graphic, s_Lunar(end), m_Fuel(end), Bremse(end));
    
    % update title to show simulation time
    sgtitle(plots.s_Lunar.Parent,...
            sprintf('Maneuver Time:  %f.3 s', time)); 
    drawnow();
    

end
end