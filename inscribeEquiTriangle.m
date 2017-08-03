function len = inscribeEquiTriangle(N,theta)
    x = cos(0:(2*pi/N):2*pi);
    y = sin(0:(2*pi/N):2*pi);
    P = vertcat(x,y);

    L = 1.1*[0,cos(theta);0,sin(theta)];
    X = poly2poly(L,P);
    a = X(:,1);
    A = repmat(a,1,length(P(1,:)));

    rot = pi/3;
    R1 = [cos(rot),-sin(rot);sin(rot),cos(rot)]*(P - A) + A;
    R2 = [cos(rot),sin(rot);-sin(rot),cos(rot)]*(P - A) + A;

    Y1 = poly2poly(P,R1);
    p1 = Y1(:,end);
    Y2 = poly2poly(P,R2);
    p2 = Y2(:,end);
    
    len = norm(a - p1);

    clf;
    set(gcf, 'Position', [100, 500, 900, 300])
    subplot(131);
    plot(P(1,:),P(2,:),'-k');
    hold on;
    scatter(a(1),a(2),25,'b');
    axis([-2 2 -2 2]);
    axis square;
    xlabel('Choose Point');

    subplot(132);
    plot(P(1,:),P(2,:),'-k');
    hold on;
    scatter([a(1) p1(1) p2(1)],[a(2) p1(2) p2(2)],25,'b');
    plot(R1(1,:),R1(2,:),'--r');
    plot(R2(1,:),R2(2,:),'--r');
    axis([-2 2 -2 2]);
    axis square;
    xlabel('Rotate Polygon');

    subplot(133);
    plot(P(1,:),P(2,:),'-k');
    hold on;
    plot([a(1) p1(1) p2(1) a(1)],[a(2) p1(2) p2(2) a(2)],'b');
    axis([-2 2 -2 2]);
    axis square;
    xlabel('Inscribe Triangle');
end
