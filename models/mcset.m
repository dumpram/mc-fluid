classdef mcset
    %MCSET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mctasks = []
        levels = []
    end
    
    methods
        function obj = mcset(mctasks, levels)
            obj.mctasks = mctasks;
            obj.levels = levels;
        end
        
        function u = utilization_lo(obj)
            C = [obj.mctasks.C];
            C = C(1:obj.levels:end);
            T = [obj.mctasks.T];
            u = sum(C ./ T);
        end
        
        function u = utilization_hi(obj)
            tasks = obj.mctasks;
            C = [];
            T = [];
            for i=1:length(tasks)
                if (tasks(i).L == 2)
                    C = [C tasks(i).C(2)];
                    T = [T tasks(i).T];
                end
            end
            u = sum(C ./ T);
        end
    end
end

