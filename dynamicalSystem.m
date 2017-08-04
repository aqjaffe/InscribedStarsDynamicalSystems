function windingNumber = dynamicalSystem(n,k,t,r)
    % Computes k steps of the radius-r dynamical system on P_n,
    % starting at point (1-t)+tw.

    % INPUTS:
    %   n -- the number of sides in the ambient polygon
    %   k -- the number of steps
    %   t -- the barycentric coordinate for the initial point
    %   r -- the stepping radius
    
    % OUTPUT:
    %   windingNumber -- the winding number of the resulting path
    
    % ERRORS:
    %   - Input radius r must be such that the intersection of the
    %     polygon with ball around each point is connected.

    % Some constants
    ncirc = 1000;                % number of sides used to approximate the circle
    epsilon = 0.0001;           % the tolerance of the stepping
    
    % Check connectivity
    if (mod(n,2) == 0 && r >= 2*cos(2*pi/n)) || ...
            (mod(n,2) == 1 && r >= 1+cos(2*pi/n)/(pi/n))
        warning('Input radius may lead to disconnected regions.')
    end
    
    % Define some geometric objects
    P = vertcat(cos(0:(2*pi/n):2*pi),sin(0:(2*pi/n):2*pi));
    C = vertcat(r*cos(0:(2*pi/ncirc):2*pi),r*sin(0:(2*pi/ncirc):2*pi));
    S = zeros(2,k);
    S(:,1) = (1-t)*P(:,1)+t*P(:,2);
    
    % Run the dynamics
    C_ = C + repmat(S(:,1),1,length(C(1,:)));
    Y = poly2poly(C_,P);
    S(:,2) = Y(:,1); % USE THIS TO CHANGE THE DIRECTION OF THE SYSTEM
    for i = 3:k+1
        C_ = C + repmat(S(:,i-1),1,length(C(1,:)));
        Y = poly2poly(C_,P);
        if norm(Y(:,1) - S(:,i-2)) < epsilon
            S(:,i) = Y(:,2);
        else
            S(:,i) = Y(:,1);
        end
    end
    
    thetas = unwrap(atan2(S(2,:),S(1,:)));
    windingNumber = (thetas(end) - thetas(1))/(2*pi);
end
