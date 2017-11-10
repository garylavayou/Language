function plotsparse( s )

[row, col] = find(s);
plot(col, -row, '.');
axis([0 size(s,2) -size(s,1) 0]);
axis equal;
axis off
end

