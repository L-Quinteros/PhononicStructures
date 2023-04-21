% Results

% Band to optimize
n_band = 3;

% Cell number
n_cells = 4;

% Initial vector x0
% This is calculated just to know the dimension of x0
% Symmetry map for the FBZ (Physical symmetry)
symmetry_map = Symmetry_Map_FBZ(n_cells, 1);
x0_dimension = size(symmetry_map, 2);
x0 = rand(2 * x0_dimension, 1);

% Number of iterations of the optimization algorithm
n_iterations = 50;

% Please note that the "Opt_band_diagram" has the design variables
% rounded to 0-1. This is what is referred to in the article as the
% post-processing because the optimization tends towards 0 and 1. However,
% sometimes there are subtle differences.

[optimized_band, f, final_x] = mainOptimization(n_band, n_cells, x0, n_iterations);

% Plot the optimized band
plot_band(optimized_band);

% In order to maintain the postprocessing, the 'final_x' will be rounded as well.
plot_truss(n_cells, round(final_x));
