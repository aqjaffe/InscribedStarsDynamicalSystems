function minlen = inscribeAllEquiTriangles(N,res,ttime)
    lens = zeros(1,N);
    ii = 1;
    tdur = ttime / res;
    for theta = 0:(2*pi/(N*res)):(2*pi/N)
        lens(ii) = inscribeEquiTriangle(N,theta);
        ii = ii + 1;
        pause(tdur);
    end
    %minlen = min(lens(lens > 1));
    minlen = min(lens);
    %clf;
    figure;
    plot(0:(2*pi/(N*res)):(2*pi/N),lens);
    title('Inscribed Equilateral Side Length');
    xlabel('theta');
    ylabel('Side Lengt h');
end