%% Visualize sparse matrix
% see also <spy https://www.mathworks.com/help/releases/R2017b/matlab/ref/spy.html>.
function plotsparse( s )

[row, col] = find(s);
plot(col, -row, '.');
axis([0 size(s,2) -size(s,1) 0]);
axis equal;
axis off
end

