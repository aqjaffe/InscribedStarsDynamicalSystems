function r = inscribeEquiStar(n,k,t)
    % some constants
    epsilon = 0.001;           % the tolerance of the stepping
    
    if mod(n,2) == 0
        rn = 2*cos(pi/n);
    else
        rn = 1+cos(2*pi/n)/cos(pi/n);
    end
    
    [w,rmin,rmax] = inscribeEquiStarHelper(n,k,t,0,rn);
    while abs(w - (k-1)/2) >= epsilon
        [w,rmin,rmax] = inscribeEquiStarHelper(n,k,t,rmin,rmax);
    end
    r = 0.5*(rmin+rmax);
end

function [w,newrmin,newrmax] = inscribeEquiStarHelper(n,k,t,rmin,rmax)  
    % search for the correct value of r
    % within the range (rmin,rmax).
    r = 0.5*(rmin + rmax);
    w = dynamicalSystemPlot(n,k,t,r);
    pause(0.25)
    if w < (k-1)/2  % the point was slow
        newrmin = r;
        newrmax = rmax;
    else            % the point was fast
        newrmin = rmin;
        newrmax = r;
    end
end