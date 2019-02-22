%% Initialisation
close all
N = 500;        % number of steps
C = 500;        % number of cells

clear A
A = false(N+1, C); % an empty logical array representing the state at each iteration
A(1,:) = randi([0,1],1,C);   % set the initial state

% figure
% imshow(~A, 'InitialMagnification', 'Fit')  % live cells are black


%% Simulation
for n = 1:N

    % Arrays of centre, left and right neighbours for the current iteration
    P = A(n,:);
    L = [P(C), P(1:C-1)];  % assume left ghost cell is the right boundary cell
    R = [P(2:C), P(1)];    % assume right ghost cell is the left boundary cell

    % Logical arrays of all possible configurations
    C000 = (L == 0 & P == 0 & R == 0);
    C001 = (L == 0 & P == 0 & R == 1);
    C010 = (L == 0 & P == 1 & R == 0);
    C011 = (L == 0 & P == 1 & R == 1);
    C100 = (L == 1 & P == 0 & R == 0);
    C101 = (L == 1 & P == 0 & R == 1);
    C110 = (L == 1 & P == 1 & R == 0);
    C111 = (L == 1 & P == 1 & R == 1);

    % Determine the logical mask for our simulation
    live_mask = C001 | C010 | C011 | C101 | C110;
    % according to our rules, these are the configurations that lead to a live cell at the next iteration

    % Set the live cells for the next iteration (the rest are dead by default since we initialised A with false)
    A(n+1, live_mask) = 1;
end

%% Plot
figure
imshow(~A, 'InitialMagnification', 'Fit')  % live cells are black