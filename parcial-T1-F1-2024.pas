program practica

const
    paises = 200;
type
    rangoPaises = 1..paises;
    vectorPaises = array[rangoPaises] of string;

    repuesto = record;
        codigo: integer;
        precio: real;
        codigoPais: rangoPaises;
    end;
    listaRepuestos = ^nodo;
    nodo = record;
        elem: repuesto;
        sig: listaRepuestos;
    end;

    vectorRepuestosPorPais = array[rangoPaises] of integer;
    vectorMasCaro = array[rangoPaises] of real;

    procedure cargarVector (var v: vectorPaises) // se dispone

    procedure leerRepuesto (var r: repuesto)
    var
    bagin
        read(r.codigo)
        if(r.codigo <> -1) then
            begin
                read(r.precio);
                read(r.codigoPais);
            end;
    end;

    procedure cargarLista (var l: listaRepuestos)
    var
        r: repuesto
    begin
        leerRepuesto(r);
        while(r.codigo <> -1) do
            begin
                agregarAdelante(l, r);
                leerRepuesto(r);
            end;
    end;

    procedure agregarAdelante (var l: listaRepuestos, rep: repuesto)
    var
        nuevo: listaRepuestos;
    begin
        new(nuevo); nuevo^.elem:= rep; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else
            begin
                nuevo^.sig:= l;
                l:= nuevo;
            end;
    end;

    procedure inicializarVectores (var v1: vectorRepuestosPorPais, var v2: vectorMasCaro)
    var 
        i: rangoPaises
    begin
        for i:= 1 to paises do
            begin
                v1[i]:= 0;
                v2[i]:= 0;
            end;
    end;

    procedure actualizarMaximo( elem: real, precio: real)
    var 
    begin
        if( precio >= elem) then elem := precio;
    end;

    function rep3Ceros (cod: integer) : boolean
    var
        num, cant: integer
    begin 
        cant:= 0;
        while (cod <> 0) and (cant < 3) do
        begin
            num:= cod MOD 10
            if((num DIV 10) = 0) then cant:= cant + 1;
            num MOD 10;
        end;
        if(cant = 3) then
        rep3Ceros:= true;
        else rep3Ceros:= false;
    end;

    function calcularPromedio(v: vectorRepuestosPorPais): real
    var 
        i: rangoPaises; cant: integer;
    begin
        cant:= 0;
        for i := 1 to paises do
            begin
                cant:= cant + v[i];
            end;
        calcularPromedio:= cant/paises;
    end;

    procedure promedioPorPais (v: vectorRepuestosPorPais, prom: real, var cant: integer)
    var
        i: rangoPaises
    begin
        for i: 1 to paises do
            begin
                if(v[i] < prom) then cant:= cant + 1;
            end;
    end;

    procedure procesarDatos (v: vectorPaises, l: listaRepuestos, vRP: vectorRepuestosPorPais, vMC: vectorMasCaro, cantP: integer, cant3: integer)
    var
        promedio: real;
    begin
        inicializarVectores(vRP, vMC);
        cantP:= 0;
        cant3:= 0;    
        while(l <> nil) do
            begin
                vRP[l^.elem.codPais] = vRP[l^.elem.codPais] + 1;
                actualizarMaximo(vMC[l^.elem.codPais], l^.elem.precio);
                if(rep3Ceros(l^.elem.codigo)) then cant3 := cant3 + 1;
                l:= l^.sig;
            end;
        promedio := calcularPromedio(vRP);
        promedioPorPais(vRP, promedio, cantP);
    end;

    procedure informarRepMasCaro(v: vectorMasCaro, vPaises: vectorPaises)
    var
        i: rangoPaises;
    begin
        for i:= 1 to paises do  
            begin 
                write(vPaises[i]);
                write(v[i]);
            end;
    end;
var
    vPaises: vectorPaises; lista: listaRepuestos; vRepPais: vectorRepuestosPorPais, vMasCaro: vectorMasCaro; cantPaises: integer; cant3Ceros: integer;
begin
    cargarVector (vPaises); // se dispone
    lista:= nil;
    cargarLista (lista);
    procesarDatos(vPaises, lista, vRepPais, vMasCaro, cant3Ceros);
    write(`Cantidad de paises menores al promedio:` cantPaises);
    informarRepMasCaro(vMasCaro, vPaises);
    write(`La cantidad de repuestos con 3 ceros en su codigo es:` cant3Ceros)
end;