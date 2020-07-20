function [q,fval] = runnested1(params,qVec)
    [q, fval] = fmincon(@cost_function,qVec,[],[],[],[],[],[],@nonlinear_constraints);
    
    function y = cost_function(rotVec)
        l = params.mode;        
        r.w = rotVec(1);
        r.x = rotVec(1);
        r.y = rotVec(1);
        r.z = rotVec(1);
        
        qRotated.w =  -1*(l.w * r.w - (l.x * r.x + l.y * r.y + l.z * r.z));
        qRotated.x =  -1*(l.w * r.x +  l.x * r.w + l.y * r.z - l.z * r.y);
        qRotated.y =  -1*(l.w * r.y -  l.x * r.z + l.y * r.w + l.z * r.x);
        qRotated.z =  -1*(l.w * r.z +  l.x * r.y - l.y * r.x + l.z * r.w);
        
        dw = qRotated.w;% - params.R.w;
        dx = qRotated.x - params.R.x;
        dy = qRotated.y - params.R.y;
        dz = qRotated.z - params.R.z;
        
        y = norm(dw,'fro') + norm(dx,'fro') + norm(dy,'fro') + norm(dz,'fro');        
    end


    function [c,ceq] = nonlinear_constraints(rot)
        c = [];
        % nonlinear equality constraint
        ceq(1) = rot'*rot - 1;  
    end

%     q = quaternion(q(1),q(2),q(3),q(4));
    
end
