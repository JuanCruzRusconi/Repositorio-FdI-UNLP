program parcialt2

const
    totalMarcas = 130;
type
    rangoMarcas = 1..130;

    repuesto = record
        cod: integer;
        precio: real;
        codMarca: rangoMarcas;
        pais: string;
    end;
    listaRepuestos = ^nodo;
    nodo = record
        elem: repuesto;
        sig: ^listaRepuestos;
    end;

    vectorMarcas = array[rangoMarcas] of string;
    vectorMasBarato = array[rangoMarcas] of real;

    procedure cargarListaRepuestos ( var l : listaRepuestos) // se dispone

    procedure leerRepuesto ( var c: rangoMarcas; var m : string )
    var
    begin
        read(c);
        read(m);
    end;

    procedure cargarVectorMarcas ( var v : vectorMarcas)
    var
        i: rangoMarcas; codigo: rangoMarcas; marca: string;
    begin
        for i := 1 to totalMarcas do
            begin
                leer(codigo, marca);
                v[codigo]:= marca;
            end;
    end;

    procedure inicializarVectorMasBarato (var v: vectorMasBarato)
    var
        i: rangoMarcas;
    begin
        for i:= 1 to totalMarcas do
            v[i] := 99999;
    end;

    procedure actualizarMinimo ( var precioActual: real; var precioNuevo: real)
    var
    begin
        if(precioNuevo < precioActual) then precioActual:= precioNuevo;
    end;

    function codigoNingun0(c: integer) : boolean
    var 
        num: integer; seguir: boolean
    begin
        seguir:= true;
        while(c <> 0) and (seguir = true) do
            begin
            num:= c MOD 10
            if( num = 0 ) then seguir false;
            num:= c DIV 10;
            end;
        if(seguir = true) then codigoNingun0:= true;
        else codigoNingun0:= false;
    end;

    procedure procesarInformacion(l: listaRepuestos, var vMB: vectorMasBarato, var cant100: integer, var cantN0: integer)
    var
        paisActual: string; repPorPais: integer;
    begin
        cant100:= 0;
        cantN0:= 0;
        inicializarVectorMasBarato(vMB);
        while(l <> nil) do
            begin
                repPorPais:= 0;
                paisActual:= l^.elem.pais;
                while(l <> nil) and (paisActual = l^.elem.pais) do
                    begin
                        repPorPais:= repPorPais + 1;
                        actualizarMinimo(vMB[l^.elem.codMarca], l^.elem.precio);
                        if(codigoNingun0(l^.elem.cod)) then cantN0:= cantN0 + 1;
                        l:= l^.sig;
                    end;
                if(repPorPais > 100) then cant100:= cant100 + 1;
            end;
    end;

    procedure informarMasBarato(v: vectorMasBarato, vM: vectorMarcas)
    var
        i: rangoMarcas
    begin
        for i:= 1 to totalMarcas do
            begin
                write("Marca: ", vM[i]);
                write("Repuesto mas barato: ", v[i]);
            end;
    end;

var
    lR: listaRepuestos; vMarcas: vectorMarcas; vMasBarato: vectorMasBarato; 
    cantMas100: integer; cantNingun0: integer;
begin
    lR:= nil;
    cargarListaRepuestos(lR); // se dispone
    cargarVectorMarcas(vMarcas);
    procesarInformacion(lR, vMarcas, vMasBarato, cantMas100, cantNingun0);
    write("La cantidad de paises que a los que se le compro mas de 100 repuestos es: ", cant100);
    informarMasBarato(vMasBarato, vMarcas);
    write("La cantidad de repuestos que no poseen ningun 0 en su codigo es: ", cantNingun0);
end.