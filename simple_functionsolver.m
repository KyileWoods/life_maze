%Open up a maze, with walls designated as ones and zeroes
close all
clear all
tic
maze = imread('simple_maze.png');

hsvmaze = rgb2hsv(maze);
binmaze = hsvmaze(:,:,3) >= 0.3;

%Fill the entire passageways with life
A = binmaze==0;
imshow(A)

%The values below are the Chosen start and end co-ordinate for 'simple_maze.png'.
start_x = 150;
start_y = 1;
end_x = 170;
end_y = 320;

%%Simulation Function
A=maze_solver(A, start_x ,start_y , end_x, end_y);

%%Ending portion
toc

pathline = 255.*(uint8(~A));
%imshow(pathline)
tracedmaze=maze;
tracedmaze(:, :, 2:3)=tracedmaze(:, :, 2:3)-pathline;
%tracedmaze(:,:,1)=maze(:,:,1)+pathline

figure
   imagesc(tracedmaze);