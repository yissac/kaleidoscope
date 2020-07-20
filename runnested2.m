function [q,fval] = runnested2(params,qVec)
    [q, fval] = fmincon(@cost_function,qVec,[],[],[],[],[],[],@nonlinear_constraints);
    
    function y = cost_function(rotVec)      
        l = params.mode;
        r = rotVec;
        rotated_w =  l.w * rotVec(1) - (l.x * rotVec(2) + l.y * rotVec(3) + l.z * rotVec(4));
        y = norm(rotated_w);
    end

    function [c,ceq] = nonlinear_constraints(rot)
        c = [];
        % nonlinear equality constraint
        ceq(1) = rot'*rot - 1;
    end

%     q = quaternion(q(1),q(2),q(3),q(4));
    
end
