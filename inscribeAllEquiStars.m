function minlen = inscribeAllEquiStars(n,k,res)
    lens = zeros(1,res+1);
    tdur = 0.01;
    ii = 1;
    for t = 0:1/res:1
        %disp(t);
        lens(ii) = inscribeEquiStarPlot(n,k,t);
        ii = ii + 1;
        pause(tdur);
    end
    %minlen = min(lens(lens > 1));
    minlen = min(lens);
    %clf;
    figure;
    plot(0:1/res:1,lens);
    title('Inscribed Equilateral Side Length');
    xlabel('t');
    ylabel('Side Length');
end
