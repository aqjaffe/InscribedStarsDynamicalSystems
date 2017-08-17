function r = inscribeEquiStar(n,k,t,animation)
    % some constants
    epsilon = 0.00001;           % the tolerance of the stepping
    
    if mod(n,2) == 0
        rn = 2*cos(pi/n);
    else
        rn = 1+cos(2*pi/n)/cos(pi/n);
    end
    
    [w,rmin,rmax] = inscribeEquiStarHelper(n,k,t,0,rn,animation);
    while(abs(w - (k-1)/2) >= epsilon)
        [w,rmin,rmax] = inscribeEquiStarHelper(n,k,t,rmin,rmax,animation);
    end
    r = 0.5*(rmin+rmax);
    if(animation == "still" || animation == "full")
        dynamicalSystem(n,k,t,r,"still");
    end
end

function [w,newrmin,newrmax] = inscribeEquiStarHelper(n,k,t,rmin,rmax,animation)  
    % search for the correct value of r
    % within the range (rmin,rmax).
    
    tdur = 0.25;
    
    r = 0.5*(rmin + rmax);
    if(animation == "none" || animation == "still")
        w = dynamicalSystem(n,k,t,r,"none");
    else
        w = dynamicalSystem(n,k,t,r,"still");
        pause(tdur)
    end
    if w < (k-1)/2  % the point was slow
        newrmin = r;
        newrmax = rmax;
    else            % the point was fast
        newrmin = rmin;
        newrmax = r;
    end
end