%% parameter file
F_Thrust        = 12500; %N
m_Lunar_leer    = 2134; % kg
m_Impuls        = 140; %s
m_Tank          = 8200; % kg
r_Mond          = 1737000; % m
m_Mond           = 7.346e22; % kg
G               = 6.6743e-11; % m^3/(kg*s^2)

% todo: choose s_Lunar
s_above_ground  = 1000; %m
s_Lunar         = r_Mond + s_above_ground; % m

% todo: choose v_Luaner (2 dimensionen? radial und tangential?)
v_Lunar         = -50; %m/s