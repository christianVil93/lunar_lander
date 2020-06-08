function animate_result(sim, plots)
tic
time = 0;
while time < sim.time(end)
    time = toc;
    time_idx = sim.time<time;
    s_Lunar = sim.s_Lunar(time_idx);
    m_Fuel = sim.m_Fuel(time_idx);
    Bremse = sim.Bremse(time_idx);
    plot(plots.s_Lunar, sim.time(time_idx), s_Lunar);
    plot(plots.v_Lunar, sim.time(time_idx), sim.v_Lunar(time_idx));
    plot(plots.m_Fuel, sim.time(time_idx), m_Fuel);
    
    plotRocket(plots.graphic, s_Lunar(end), m_Fuel(end), Bremse(end));
    sgtitle(plots.s_Lunar.Parent,...
            sprintf('Maneuver Time:  %f.3 s', time)); 
    drawnow();
end
end