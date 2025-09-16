a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada 
producto deben quedar almacenados su código, la cantidad total de unidades vendidas y el monto total. De cada venta 
se cargan código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso 
de las ventas finaliza cuando se lee el código de venta 0.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el menor código de producto.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.


Program Ejercicio1
type
    producto = record
        cod: integer;
        cant: integer;
        monto: real;
    end;

    venta = record
        cod: integer
        codProd: integer;
        cant: integer;
        precio: real;
    end;

    arbol = ^nodo
    nodo = record
        elem: producto;
        hi: arbol;
        hd: arbol;
    end;

    procedure generarVenta(var v: venta);
    begin
        v.cod:= random(50) + 1;
        if(v.cod <> 0) do begin
            v.codProd:= random(100) + 1;
            v.cant:= random(20) + 1;
            v.precio:= (100 + random(100))/2;
        end;
    end;

    procedure generarProducto(v: venta; var p: producto);
    begin
        p.cod:= v.codProd;
        p.cant:= v.cant;
        p.monto:= v.cant * v.precio;
    end;

    procedure agregarAlArbol(var a: arbol, v: venta);
    var
        p: producto;
    begin
        if(a = nil) then begin
            new(a);
            generarProducto(v, p);
            a^.elem:= p;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            if(v.codProd = a^.elem.cod) then begin
                a^.elem.cant:= a^.elem.cant + v.cant;
                a^.elem.monto:= a^.elem.monto + (v.cant * v.precio)
            end
            else 
                if(v.codProd < a^.elem.cod) then agregarAlArbol(a^.hi, v);
                else agregarAlArbol(a^.hd, v);
    end;

    procedure cargarDatos(var a : arbol);
    var
        v: venta;
    begin   
        generarVenta(v);
        while(v.cod <> 0) do begin
            agregarAlArbol(a, v);
            generarVenta(v);
        end;
    end;

    procedure imprimirNodos(p: producto);
    begin
        writeln('Producto codigo: ', p.cod);
        writeln('Cantidad total: ', p.cant);
        writeln('Monto total: ', p.monto);
    end;

    procedure imprimirArbol(a: arbol);
    begin
        if(a <> nil) then begin
            if(a^.hi <> nil) then imprimirArbol(a^.hi);
            imprimirNodos(a^.elem);
            if(a^.hd <> nil) then imprimirArbol(a^.hd);
        end;
    end;

    function retornarMenorCodigo(a: arbol): integer;
    begin
        if(a = nil) then retornarMenorCodigo:= 0
        else
        begin
            if(a^.hi = nil) then retornarMenorCodigo:= a^.elem.cod
            else retornarMenorCodigo(a^.hi);
        end;
    end;

    function cantidadCodigosMenores(a: arbol; cod: integer): integer;
    begin
        if(a = nil) then cantidadCodigosMenores:= 0;
        else
        begin
            if(a^.elem.cod < cod) then cantidadCodigosMenores:= 1 + cantidadCodigosMenores(a^.hi, cod) + cantidadCodigosMenores(a^.hd, cod);
            else cantidadCodigosMenores:= cantidadCodigosMenores(a^.hi, cod);
        end;
    end;
    // CONSULTAR
    function retornarMontoTotalEntreValores(a: arbol; vA, vB: integer): real;
    begin
        if(a = nil) then retornarMontoTotalEntreValores:= 0;
        else
            begin
                if (a^.elem.cod > vA) and (a^.elem.cod < vB) then retornarMontoTotalEntreValores:= a^.elem.monto 
                                                                    + retornarMontoTotalEntreValores(a^.hi, vA, vB) 
                                                                    + retornarMontoTotalEntreValores(a^.hd, vA, vB)
                else if (a^.elem.cod > vB) then retornarMontoTotalEntreValores:= retornarMontoTotalEntreValores(a^.hi, vA, vB)
                else retornarMontoTotalEntreValores:= retornarMontoTotalEntreValores(a^.hd, vA, vB);
            end;
    end;

var
    a: arbol;
    menorCod: integer;
    cod: integer;
    cantCodMenores: integer;
    valorA: integer;
    valorB: integer;
    montoTotal: real;
begin
    Randomize;
    a:= nil;
    cargarDatos(a);
    imprimirArbol(a);
    menorCod:= retornarMenorCodigo(a);
    writeln();
    writeln('Ingrese un codigo: ');
    readln(cod);
    cantCodMenores:= cantidadCodigosMenores(a, cod);
    writeln('La cantidad de codigos menores a ', cod, ' es de: ', cantCodMenores);
    writeln('Ingrese un codigo A: ');
    readln(valorA);
    writeln('Ingrese un codigo B: ');
    readln(valorB);
    montoTotal:= retornarMontoTotalEntreValores(a, valorA, valorB);
    writeln('El monto total entre todos los códigos de productos comprendidos entre 
            dos valores recibidos ', valorA, ' y ', valorB, ' es: ', montoTotal);
end.