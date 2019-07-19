classdef mctask
    %MCTASK Mixed-criticality task.
    %   Class represents mixed-criticality task which can be represented 
    %   as a set {C, T, D, L}.
    
    properties
        C = [];
        T = 0;
        D = 0;
        L = 0;
    end
    
    methods
        function obj = mctask(C, T, D, L)
            if nargin == 0
                C = [0 0];
                T = 0;
                D = 0;
                L = 2;
            end
            obj.C = C;
            obj.T = T;
            obj.D = D;
            obj.L = L;
            assert(L <= length(C), "Invalid task level: length");
            assert(L >= 1, "Invalid task level: nonpositive");
        end
        
        function u = utilization_lo(obj)
            u = obj.C(1) / obj.T;
        end
        
        function u = utilization_hi(obj)
            u = obj.C(2) / obj.T;
        end
        
    end
    
end

