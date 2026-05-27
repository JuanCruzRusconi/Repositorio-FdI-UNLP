Una empresa posee un archivo que contiene información sobre los ingresos percibidos por diferentes
empleados en concepto de comisión. De cada empleado se conoce: código de empleado, nombre y
monto de la comisión.
La información del archivo se encuentra ordenada por código de empleado, y cada empleado puede
aparecer más de una vez en el archivo de comisiones.
Se solicita realizar un procedimiento que reciba el archivo anteriormente descrito y lo compacte. Como
resultado, deberá generar un nuevo archivo en el cual cada empleado aparezca una única vez, con el
valor total acumulado de sus comisiones.
Nota: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única
vez.

Program ejercicio1;

const
    valorAlto = 9999;
type
    empleado = record
        codigo: integer;
        nombre: string;
        monto: real;
    end;

    archivoEmpleado = file of empleado;

    archivoCompactado = file of empleado;

    procedure leer(var empleados: archivoEmpleado, var e: empleado)
    var

    begin
        if(not EOF(empleados)) then 
            read(empleados, e)
        else
            e.codigo := valorAlto;
    end;

var
    empleados: archivoEmpleado;
    compactado: archivoCompactado;
    e: empleado;
    nuevo: empleado;
    codActual: integer;
    nombreActual: string;
    montoActual: real;
begin
    assign(empleados, 'archivo_empleados');
    reset(empleados);

    assign(compactado, 'archivo_compactado');
    rewrite(compactado);

    leer(empleados, e);

    while(e.codigo <> valorAlto) do begin
        nombreActual := e.nombre;
        codActual := e.codigo;
        montoActual := 0;
        while(e.codigo = codActual) do begin
            montoActual := montoActual + e.monto;
            leer(empleados, e);
        end;
        nuevo.nombre := nombreActual;
        nuevo.codigo := codActual;
        nuevo.monto := montoActual;
        write(compactado, nuevo);
    end;

    close(empleados);
    close(compactado);

end.