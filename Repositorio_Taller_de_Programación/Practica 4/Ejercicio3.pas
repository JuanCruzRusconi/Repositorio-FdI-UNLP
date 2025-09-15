Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.

Program Ejercicio3;
type
    producto = record
        cod: integer;
        cant: integer;
        monto: real;
    end;

    venta = record
        cod: integer;
        codProd: integer;
        cant: integer;
        precio: real;
    end;

    arbol = ^nodo;
    nodo = record
        elem: producto;
        hi: arbol;
        hd: arbol;
    end;

    procedure leerVenta(var v: venta);
    begin
        writeln('Ingrese codigo de venta:');
        read(v.cod);
        if(v.cod <> -1) then begin
            writeln('Ingrese codigo de producto:');
            read(v.codProd);
            writeln('Ingrese cantidad de unidades vendidas:');
            read(v.cant);
            writeln('Ingrese el precio unitario:');
            read(v.precio);
        end;
    end;

    procedure agregarAlArbol(var a: abrol; v: venta);
    var
        p: producto;
    begin
        if(a = nil) then begin
            new(a);
            a^.elem.cod:= v.codProd;
            a^.elem.cant:= v.cant;
            a^.elem.monto:= v.cant * v.precio;
            a^.elem:= p;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            if(a^.elem.cod = v.codProd) then begin
                a^.elem.cant:= a^.elem.cant + v.cant;
                a^.elem.monto:= a^.elem.monto + (v.cant * v.precio); 
            end
            else
                if(a^.elem.cod > v.codProd) then agregarAlArbol(a^.hi, v);
                else agregarAlArbol(a^.hd, v);
    end;

    procedure cargarInformacion(var a: arbol);
    var
        v: venta
    begin
        leerVenta(v);
        while(v.cod <> -1) do begin
            agregarAlArbol(a, v);
            leerVenta(v);
        end;
    end;

    procedure imprimirNodo(p: producto);
    begin
        writeln('Producto codigo: ', p.cod);
        writeln('Cantidad total: ', p.cant);
        writeln('Monto total: ', p.monto);
    end;

    procedure imprimirArbol(a: arbol);
    begin
        if(a <> nil) then begin
            if(a^.hi <> nil) then imprimirArbol(a^.hi);
            imprimirNodo(a^.elem);
            if(a^.hd <> nil) then imprimirArbol(a^.hd);
        end;
    end;

    procedure retornarProdMasUnidadesVendidas(a: arbol; var max: integer);
    begin
        if(a <> nil) then begin
            actualizarMaximo(a^.elem.cant, max);
            retornarProdMasUnidadesVendidas(a^.hi, max);
            retornarProdMasUnidadesVendidas(a^.hd, max);
        end;
    end;

var
    a: arbol;
    prodMasUVendidas: integer;
    max: integer;
begin
    a:= nil;
    cargarInformacion(a);
    imprimirArbol(a);
    max:= -1;
    retornarProdMasUnidadesVendidas(a, max);
end;