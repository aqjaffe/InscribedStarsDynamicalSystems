function windingNumber = dynamicalSystem(n,k,t,r,animation)
    % Computes k steps of the radius-r dynamical system on P_n,
    % starting at point (1-t)+tw.

    % INPUTS:
    %   n -- the number of sides in the ambient polygon
    %   k -- the number of steps
    %   t -- the barycentric coordinate for the initial point
    %   r -- the stepping radius
    %   animation -- "none", "still", "full"
    
    % OUTPUT:
    %   windingNumber -- the winding number of the resulting path
    
    % ERRORS:
    %   - Input radius r must be such that the intersection of the
    %     polygon with ball around each point is connected.

    % Some constants
    ncirc = 1000;                % number of sides used to approximate the circle
    epsilon = 0.0001;           % the tolerance of the stepping
    tdur = 0.5;
    
    % Check connectivity
    if (mod(n,2) == 0 && r >= 2*cos(pi/n)) || ...
            (mod(n,2) == 1 && r >= 1+cos(2*pi/n)/(pi/n))
        warning('Input radius may lead to disconnected regions.')
    end
    
    % Define some geometric objects
    P = vertcat(cos(0:(2*pi/n):2*pi),sin(0:(2*pi/n):2*pi));
    C = vertcat(r*cos(0:(2*pi/ncirc):2*pi),r*sin(0:(2*pi/ncirc):2*pi));
    S = zeros(2,k);
    S(:,1) = (1-t)*P(:,1)+t*P(:,2);
    
    if(animation == "full") % Plot the first point
        plot(P(1,:),P(2,:),'-k');
        hold on;
        scatter(S(1,1),S(2,1),'g');
        scatter(S(1,1),S(2,1),'r');
        axis([-2 2 -2 2]);
        axis square;
        xlabel('Inscribed Star');
        pause(tdur);
    end
    
    if(animation == "full") % Plot the second point
        clf;
        C_ = C + repmat(S(:,1),1,length(C(1,:)));
        Y = poly2poly(C_,P);
        S(:,2) = Y(:,1); % USE THIS TO CHANGE THE DIRECTION OF THE SYSTEM
        plot(P(1,:),P(2,:),'-k');
        hold on;
        plot(S(1,1:2),S(2,1:2),'b');
        scatter(S(1,1),S(2,1),'g');
        scatter(S(1,2),S(2,2),'r');
        axis([-2 2 -2 2]);
        axis square;
        xlabel('Inscribed Star');
        pause(tdur);
    end
    
    % Run the dynamics
    C_ = C + repmat(S(:,1),1,length(C(1,:)));
    Y = poly2poly(C_,P);
    S(:,2) = Y(:,1); % USE THIS TO CHANGE THE DIRECTION OF THE SYSTEM
    for ii = 3:k+1
        C_ = C + repmat(S(:,ii-1),1,length(C(1,:)));
        Y = poly2poly(C_,P);
        if norm(Y(:,1) - S(:,ii-2)) < epsilon
            S(:,ii) = Y(:,2);
        else
            S(:,ii) = Y(:,1);
        end
        if(animation == "full" || (animation == "still" && ii == k + 1)) % Plot the next point
            clf;
            plot(P(1,:),P(2,:),'-k');
            hold on;
            plot(S(1,1:ii),S(2,1:ii),'b');
            scatter(S(1,1),S(2,1),'g');
            scatter(S(1,ii),S(2,ii),'r');
            axis([-2 2 -2 2]);
            axis square;
            xlabel('Inscribed Star');
            if(ii ~= k + 1)
                pause(tdur);
            end
        end
    end
    
    barys = zeros(1,k);
    for ii = 1:k
        barys(ii) = bary(S(:,ii),n);
    end
    barys
    thetas = unwrap(atan2(S(2,:),S(1,:)));
    windingNumber = (thetas(end) - thetas(1))/(2*pi);
end

function coord = bary(pt,n)
    prop = atan2(pt(2),pt(1))/(2*pi);
    k = floor(prop*n);
    a = [cos(2*pi*k/n) sin(2*pi*k/n)];
    b = [cos(2*pi*(k+1)/n) sin(2*pi*(k+1)/n)];
    coord = norm(pt'-a)/norm(b-a);
end
