// Consigna

program Panaderia

const 
    categorias = 26;
type
    rangoCategorias = 1..categorias;
    
    compra = record
        dni: integer;
        cat: rangoCategorias;
        cantKilos: real;
    end;
    listaCompras = ^nodo
        elem: compra;
        sig: ^listaCompras;
    end;

    categoria = record
        nombre: string;
        precio: real;
    end;

    vectorCategorias = array[rangoCategorias] of categoria;

    vectorMontoTotalCategoria = array[rangoCategorias] of real;

    procedure cargarListaCompras ( var l : listaCompras) // se dispone

    procedure leerCategoria ( var cod: integer ; var cat: categoria)
    var
    begin
        read(cod);
        read(cat.nombre);
        read(cat.precio);
    end;

    procedure cargarVectorCategorias ( var v : vectorCategorias)
    var
        i: rangoCategorias; cod: integer; c: categoria;
    begin
        for i := 1 to categorias do
            begin
                leerCategoria(cod, c);
                v[cod] := c;
            end;
    end;

    procedure inicializarVectorRecaudadoPorCat ( var v : vectorMontoTotalCategoria)
    var 
        i: rangoCategorias;
    begin
        for i:= 1 to categorias do
            begin
                v[i] := 0;
            end;
    end;

    function alMenos3Pares(dni: integer) : boolean
    var
        num: integer; cant: integer
    begin
        cant:= 0;
        while(dni <> 0) and (cant < 3) do
            begin
                num:= dni MOD 10;
                if((num MOD 2) = 0) then cant:= cant + 1;
                num:= dni DIV 10;
            end;
        if(cant = 3) then alMenos3Pares:= true;
        else alMenos3Pares:= false;
    end;

    procedure actualizarMaximo (compras: integer; dni: integer; maximo: integer; var dniMax: integer)
    var
    begin
        if(compras > maximo) then
            begin
                maximo:= compras;
                dniMax:= dni;
            end;
    end;

    procedure procesarInformacion (l: listaCompras; v: vectorCategorias; var vMTC: vectorMontoTotalCategoria;
                                    var dniMC: integer; var total3P: integer)
    var
        dniActual: integer; comprasActual: integer; masCompras: integer;
    begin
        inicializarVectorRecaudadoPorCat(vMTC);
        masCompras:= 0;
        total3P:= 0;
        while (l <> nil) do
            begin
                dniActual:= l^.elem.dni
                comprasActual:= 0;
                while (l <> nil) and (dniActual = l^.elem.dni) do
                    begin
                        comprasActual:= comprasActual + 1;
                        vMTC[l^.elem.cat] := vMTC[l^.elem.cat] + (l^.elem.cantKilos * v[l^.elem.cat].precio);
                        l:= l^.sig;
                    end;
                if(alMenos3Pares(dniActual)) then total3P:= total3P + comprasActual;
                actualizarMaximo(comprasActual, dniActual, masCompras, dniMC);
            end;
    end;

    procedure informarMontoTotalPorCategoria ( vCat: vectorCategorias; vMonto: vectorMontoTotalCategoria)
    var 
        i: rangoCategorias;
    begin
        for i:= 1 to categorias do
            begin
                write("Categoria: ", vCat[i].nombre);
                write("Monto total recaudado: ", vMonto[i]);
            end;
    end;

var
    lC: listaCompras; vC: vectorCategorias; vMTC: vectorMontoTotalCategoria; 
    dniMasCompras: integer; totalCompras3pares: integer;
begin
    lC:= nil;
    cargarListaCompras(lC); // se dispone
    cargarVectorCategorias(vC);
    procesarInformacion(lC, vC, vMTC, dniMasCompras, totalCompras3pares);
    write("El dni del cliente que mas compras ha realizado es: ", dniMasCompras);
    informarMontoTotalPorCategoria(vC, vMTC);
    write("La cantidad total de compras de clientes con al menos 3 digistos pares en su dni es: ", totalCompras3pares);

end.