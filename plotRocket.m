function plotRocket(axes_handle, vertical_position, m_Fuel, Bremse, zoom_factor)

if ~exist('zoom_factor','var')
   zoom_factor = 1; 
end

z = vertical_position;

rocket_width = 10;
top_height = 20;
body_height = 60;

%% generate top shape
x = [0, top_height];
y = [0, rocket_width/2, 0, -(rocket_width)/top_height];
spl_top = spline(x,y);
x_val = linspace(0, top_height, 100);
rot90_left = [0, -1; 1, 0];
top_left = rot90_left*[x_val; ppval(spl_top, x_val)];
top_right = rot90_left*[x_val; -ppval(spl_top, x_val)];
x_top_left = top_left(1,:);
y_top_left = top_left(2,:) + body_height;
x_top_right = top_right(1,:);
y_top_right = top_right(2,:) + body_height;


%% generate flame shape
x = [0, top_height];
y = [0.5, 0.4*rocket_width, 0, -(rocket_width)/top_height];
spl_flame = spline(x,y);
x_val = linspace(0, max(x), 100);
rot90_right = [0, 1; -1, 0];
flame_left = rot90_right*[x_val; ppval(spl_flame, x_val)];
flame_right = rot90_right*[x_val; -ppval(spl_flame, x_val)];
x_flame_left = flame_left(1,:);
y_flame_left = flame_left(2,:);
x_flame_right = flame_right(1,:);
y_flame_right = flame_left(2,:);

%% todo: implement smaller flame inside big flame


%%

% clear previous plot
delete(findobj('Tag','rocket'))

% animate rocket
rocket_x = [x_top_left, fliplr(x_top_right), -rocket_width/2*[-1, -1, 1, 1]];
rocket_z = [y_top_left, fliplr(y_top_right), [body_height, 0, 0, body_height]] + z;

% animate fuel tank
tank_x = rocket_width*0.4*[-1, -1, 1, 1];
tank_y = z + body_height*(0.1 + 0.8*[0, 1, 1, 0]);
fuel_x = rocket_width*0.4*[-1, -1, 1, 1];
fuel_y = z + body_height*(0.1 + 0.8*[0, 1, 1, 0])*m_Fuel/8200;

%% animate flame
flame_x = [x_flame_left, fliplr(x_flame_right)];
flame_y = z + [y_flame_left, fliplr(y_flame_right)];

fill(axes_handle, rocket_x, rocket_z, [0.8, 0.8, 0.8], 'Tag','rocket')
fill(axes_handle, tank_x, tank_y, 'white', 'Tag', 'rocket');
fill(axes_handle, fuel_x, fuel_y, [0.9294, 0.6941, 0.1255], 'Tag', 'rocket');

% plot flame only when Bremse is active
if Bremse
    fill(axes_handle, flame_x, flame_y, [1, 1, 0.0667], 'Tag', 'rocket');
end

% plot moon surface
rectangle('Position',[-50,-100,100,100],'FaceColor',[0.9 0.9 0.9])

% set aspect ratios to be equal
daspect(axes_handle, [1,1,1]);

limits_moving = z + [-1, 1]*(body_height + top_height)*1.2/zoom_factor;
limits_fixed = [0, 2]*(body_height + top_height)*1.2/zoom_factor;
if limits_moving(1)> -20
    axes_handle.YLim = limits_moving;
else
    axes_handle.YLim = limits_fixed-20;
end

axes_handle.Color = [0, 0.4471, 0.7412];
end