Una empresa dispone de una estructura de datos con los clientes de su comercio (500 a lo sumo). De cada cliente se conoce
el numero de cliente, numero de dni y monto que paga. Se pide implementar un programa que informa la cantidad de clientes 
cuyo numero de dni es capicua (es igual leerlo de izquiera a derecha y viceversa.)

Program empresa;

const
    maxClientes = 500;
type
    rangoClientes = 1..maxClientes;

    cliente = record
        num: integer;
        dni: integer;
        monto: real;
    end;

    vectorClientes = array[rangoClientes] of cliente;

    procedure leerCliente (var c: cliente)
    begin
        read(c.dni);
        if(c.dni <> 0) then begin
            read(c.num);
            read(c.monto);
        end;
    end;

    procedure cargarDatos(var v: vectorClientes; var dimL: integer) // se dispone
    var
        c: cliente;
    begin
        leerCliente(c);
        while(dimL < maxClientes) and (c.dni <> 0 )do begin
            dimL:= dimL + 1;
            v[dimL]:= c;
            leerCliente(c);
        end;
    end;

    function esCapicua(dni: integer): boolean
    var
        dig, original, invertido: integer
    begin
        original:= dni;
        invertido:= 0;
        while(dni <> 0) do begin
            dig:= dni MOD 10;
            invertido:= invertido * 10 + dig;
            dni:= dni DIV 10;
        end;
        esCapicua:= (original = invertido);
    end;

    procedure procesarDatos(v: vectorClientes; dimL: integer; var cant: integer)
    var
        i: integer;
    begin
        for i:= 1 to dimL do begin
            if(esCapicua(v[i].dni)) then cant:= cant + 1;
        end;
    end;

var
    vC: vectorClientes;
    dimL: integer;
    cant: integer;
begin
    dimL:= 0;
    cargarDatos(vC, dimL); // se dispone
    cant:= 0;
    procesarDatos(vC, dimL, cant);
    writeln("La cantidad de dni capicua es de: ", cant);
end;