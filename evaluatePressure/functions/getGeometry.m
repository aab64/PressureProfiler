function L_W_H = getGeometry(geom_type)

id = geom_type;

switch id
    case 'wellmixed'
        disp('ID: Well-mixed')
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 180e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; L34; L56; L67];
        
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; h34; h56; h67];
        
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 120e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; w34; w56; w67];
    case 'pfrlike'
        disp('ID: PFR-like')
        L23 = 500e-6;
        L34 = 70e-6;
        L44 = 216e-6;
        L56 = L23;
        L67 = 21e-3;
        Lij = [L23; L34; L44; L34; L56; L67];
        
        h23 = 100e-9;
        h34 = 100e-9;
        h44 = 100e-9;
        h56 = 100e-9;
        h67 = 60e-6;
        Hij = [h23; h34; h44; h34; h56; h67];
        
        w23 = 10e-6;
        w34 = 10e-6;
        w44 = 10e-6;
        w56 = 10e-6;
        w67 = 150e-6;
        Wij = [w23; w34; w44; w34; w56; w67];
        %     case <add new geometry case expression here>
    otherwise
        disp('Unknown geometry.')
        disp('Currently configured options are: wellmixed or pfrlike')
        disp('To add a new geometry, please edit setGeometry.m')
        Lij = 0;    % [m]
        Wij = 0;    % [m]
        Hij = 0;    % [m]
end

L_W_H = [Lij, Wij, Hij];    % [m]

end