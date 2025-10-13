{Se desea procesar la información de las ventas de productos de 
un comercio (como máximo 50). 
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un 
vector. De cada venta se conoce el día de la venta, código del
 producto (entre 1 y 15) y cantidad vendida (como máximo 99 u
 nidades). El código y el dia deben generarse automáticamente 
 (random) y la cantidad se debe leer. El ingreso de las ventas 
 finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).

e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores 
que se ingresan como parámetros. 
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada 
código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).
}
Program Ejercicio1;
const
    dimF = 50;
    maxCod = 15;
type
    maxVec = 1..50;
    codProd = 1..15;
    maxVend = 1..99;

    venta = record
        dia: integer;
        cod: codProd;
        cantVend: maxVend;
    end;
    vector = array[maxVec] of venta;

    producto = record
        cod: codProd;
        cant: integer;
    end;
    vectorCodigoPar = array[codProd] of producto;

    procedure leerVenta (var v: venta);
    begin
        writeln('Ingrese dia');
        readln(v.dia);
        if(v.dia <> 0) then begin
            v.cod:= Random(15) + 1;
            writeln('Se generó el producto ', v.cod);
            writeln('Ingrese cantidad');
            readln(v.cantVend);
        end;
    end;

    procedure cargarVector (var vec: vector; var dL: integer);
    var
        ven: venta;
    begin
        Randomize;
        leerVenta(ven);
        while(ven.dia <> 0) and (dL<dimF) do
            begin
                dL:= dL + 1;
                vec[dL]:= ven;
                leerVenta(ven);
            end;

    end;

    procedure imprimirVenta (v: venta);
    begin
        writeln('Dia ', v.dia);
        writeln('Codigo ', v.cod);
        writeln('Cantidad ', v.cantVend);
    end;

    procedure imprimirVector (v: vector; dL: integer);
    var 
        i: integer;
    begin
        for i:= 1 to dL do
            imprimirVenta(v[i]);
    end;

    //ORDENACIÓN - SELECCIÓN
    procedure ordenarVectorVentas (var v: vector; dimL: integer);
    var
        pos, i, j: integer;
        item: venta;
    begin
        for i:= 1 to dimL-1 do
            begin
                pos:= i;
                for j:= pos to dimL do
                    if(v[j].cod < v[pos].cod) then pos:= j;
                item:= v[pos];
                v[pos]:= v[i];
                v[i]:= item;
            end;
    end;

    procedure eliminarVentasCodigo (var v: vector; dimL: integer; nA, nB: codProd);
    begin
        if(nA <= dimL) and (nB <= dimL) then
            
    end;

    procedure inicializarVector (var v: vectorCodigoPar);
    var
        i: integer;
    begin
        for i:= 1 to maxCod do
            v[i].cant:= 0
    end;

    procedure cargarVectorCodigoPar (vec: vector; dimL: integer; var v: vectorCodigoPar; var dimLP: integer);
    var
        i: integer;
        prod: producto;
    begin
        inicializarVector(v);
        i:= 1;
        while(i <= dimL) do
        begin
            if(vec[i].cod MOD 2 = 0) then
            begin
                prod.cod:= vec[i].cod;
                prod.cant:= 0;
                while(i <= dimL) and (vec[i].cod = prod.cod) do
                begin
                    prod.cant:= prod.cant + vec[i].cantVend;
                    i:= i + 1;
                end;
                dimLP:= dimLP + 1;
                v[dimLp]:= prod;
            end;
            else
            begin
                i:= i + 1;
            end;
        end;
    end;

    procedure imprimirVectorCodPar (v: vectorCodigoPar; dimLP: integer);
    var
        i: integer;
    begin
        for i:= 1 to dimLP do
        begin
            writeln('Producto codigo: ', v[i].cod, ' ventas totales: ', v[i].cant);
        end;
    end;

var
    vec: vector; 
    vecCodPar: vectorCodigoPar;
    dimL, dimLP: integer;
    numA, numB: codProd;
begin
    dimL:= 0;
    dimLP:= 0;
    cargarVector(vec, dimL);
    writeln('Vector imprezo:');
    imprimirVector(vec,dimL);
    ordenarVectorVentas(vec,dimL);
    writeln('Vector ordenado imprezo:');
    imprimirVector(vec,dimL);
    // writeln('Ingrese un numero del 1 al 15');
    // readln(numA);
    // writeln('Ingrese otro numero del 1 al 15');
    // readln(numB);
    // eliminarVentasCodigo(vec, dimL, numA, numB);
    // imprimirVector(vec,dimL);
    cargarVectorCodigoPar(vec, dimL, vecCodPar, dimLP);
    imprimirVectorCodPar(vecCodPar, dimLP);
end.