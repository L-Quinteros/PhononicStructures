function [Opt_band_diagram, Opt_bandgap, Opt_solution_vector] = mainOptimization(n, nc, x0, niter)
    % Output variables:
    % Opt_band_diagram: Optimized band diagram
    % Opt_bandgap: The absolute value of the optimized band gap
    % Opt_solution_vector: The optimal vector

    % Input variables:
    % n: The optimizer maximizes the distance between the nth and (n+1)th band
    % nc: Number of cells, which are the same for x and y
    % x0: Initial vector
    % niter: Number of iterations of the optimization

    %% Physical and materials properties

    % Lpc: Length of the cell (length per cell in meters)
    Lpc = 0.025; % [m]
    % nx = ny = nc as described before
    % Lx = Ly = Lc the previous relation implies this
    nx = nc;
    ny = nc;
    Lc = Lpc * nc;
    Lx = Lc;
    Ly = Lc;

    % Generate the unit cell mesh
    % If type == 1 => X pattern
    % If type == 2 => square pattern
    % Set to 1
    type = 1;
    [nn, ne, coord, connect] = Truss_mesh(Lx, nx, Ly, ny, type);

    % Mechanical Properties
    % rho: Matrix of density in kg/m3
    % E: Matrix of Young's Modulus in Pa
    % A: Matrix of cross-section area in m2
    % These values have to be introduced in the mec_prop function for two
    % materials, creating a matrix of (ne x 2) dimension
    [rho, E, A] = mec_prop(ne);

    %% Optimization setting
    % If the P-norm formulation is desired, select a P value different from 0
    P = 30;
    % Number of eigenvalues to compute
    nav = 8;
    % Number of intervals in the IBZ path
    NINT = 10;
    % Wave vector in the first Brillouin zone
    [theta_x, theta_y] = wave_vector(NINT, Lx, Ly);

    % Symmetry map for the FBZ (Physical symmetry)
    S = Symmetry_Map_FBZ(nc, type);

    % Reduced number of design variables
    nxred = size(S, 2);

    % Objective function
    if P == 0
        df = @(x) -1 * dObjectivenum(S, x, A, E, rho, n, nn, ne, coord, connect, Lx, Ly, ...
                                      nx, ny, nav, theta_x, theta_y, nxred) / (2 * pi);
        f = @(x) -1 * Objective(n, Lx, Ly, nx, ny, ne, nn, coord, connect, E, A, rho, x, ...
                                nxred, S, nav, theta_x, theta_y) / (2 * pi);
    else
        df = @(x) -1 * dObjectivenum_pnorm(S, x, P, A, E, rho, n, nn, ne, coord, connect, Lx, Ly, ...
                                          nx, ny, nav, theta_x, theta_y, nxred) / (2 * pi);
        f = @(x) -1 * Objective_pnorm(n, Lx, Ly, nx, ny, ne, coord, connect, E, A, rho, ...
                                     x, nxred, S, P, nav, theta_x, theta_y) / (2 * pi);
    end

    %% Optimization options

    % These variables are selected to vary between both materials for each
    % truss element
    xminf = 0.0 * ones(nxred, 1);
    xmsup = 1.0 * ones(nxred, 1);

    % These variables are selected to vary between both cross sections
    % for each truss element
    xainf = 0.0 * ones(nxred, 1);
    xasup = 1.0 * ones(nxred, 1);

    % Maximum and minimum values for the design variables
    xmax = [xmsup; xasup];
    xmin = [xminf; xainf];

    % In this problem, there are no constraints, so:
    cons = @(x) 0;
    dcons = @(x) zeros(1, 2 * nxred);

    % Use the MMA algorithm
    [Opt_solution_vector, Opt_bandgap] = MMA_opt(f, df, cons, dcons, x0, xmin, xmax, niter);

    % Use the GCMMA algorithm (uncomment to use GCMMA instead of MMA)
    % [Opt_solution_vector, Opt_bandgap] = GCMMA_opt(f, df, cons, dcons, x0, xmin, xmax, niter);

    xm = Opt_solution_vector(1:nxred);
    xa = Opt_solution_vector(nxred+1:2*nxred);

    x_expandedm = S * xm;
    x_expandeda = S * xa;
    x_expanded = [x_expandedm; x_expandeda];
    Opt_band_diagram = Bands(Lx, Ly, nx, ny, ne, coord, connect, E, A, rho, round(x_expanded), nav, theta_x, theta_y) / (2 * pi);

end

