3. A partir de información sobre la alfabetización en la Argentina, se desea actualizar un archivo maestro
que contiene los siguientes datos: nombre de la provincia, cantidad de personas alfabetizadas y total de
encuestados.
Para ello, se dispone de dos archivos detalle, provenientes de distintas agencias de censo. Cada uno de
estos archivos contiene: nombre de la provincia, código de localidad, cantidad de personas alfabetizadas
y cantidad de encuestados.
Se solicita desarrollar los módulos necesarios para actualizar el archivo maestro a partir de la
información contenida en ambos archivos detalle.
Nota: Todos los archivos están ordenados por nombre de provincia. En los archivos detalle pueden
existir cero, uno o más registros por cada provincia.

Program ejercicio3;

const
    valorAlto = 'ZZZ';
type
    provincia = record
        nombre: string[20];
        cant: integer;
        encues: integer;
    end;
    archMaestro: file of provincia;

    dato = record
        nombre: string[20];
        cod: integer;
        cant: integer;
        encues: integer;
    end;

    archDetalle = file of dato;

    procedure leer(var detalle: archDetalle, var d: dato);
    begin
        if(not EOF(detalle)) then
            read(detalle, d)
        else
            d.nombre := valorAlto;
    end;

    procedure minimo(var detalle1, detalle2: archDetalle; var d1, d2, minimo: dato);
    begin
        if(d1.nombre <= d2.nombre) then begin
            minimo := d1;
            leer(detalle1, d1);
        end
        else begin
            minimo := d2;
            leer(detalle2, d2);
        end;
    end;

var
    p: provincia;
    d1: dato;
    d2: dato;
    maestro: archMaestro;
    detalle1: archDetalle;
    detalle2: archDetalle;
    provActual: string[20];
    cantPer: integer;
    cantEncues: integer;
    minimo: dato;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(detalle1, 'archivo_detalle1');
    reset(detalle1);

    assign(detalle2, 'archivo_detalle2');
    reset(detalle2);

    read(maestro, p);
    leer(detalle1, d1);
    leer(detalle2, d2);

    minimo(detalle1, detalle2, d1, d2, minimo);

    while(minimo.nombre <> valorAlto) do begin
        provActual := minimo.nombre
        cantPer := 0;
        cantEncues := 0;

        while(minimo.nombre = provActual) do begin
            cantPer := cantPer + minimo.cant;
            cantEncues := cantEncues + minimo.encues;
            minimo(detalle1, detalle2, d1, d2, minimo);
        end;

        while(p.nombre <> provActual) do
            read(maestro, p);

        p.cant := p.cant + cantPer;
        p.encues := p.encues + cantEncues;
        seek(maestro, filePos(maestro) - 1);
        write(maestro, p);

        if(not EOF(maestro)) read(maestro, p);
    end;

    close(maestro);
    close(detalle1);
    close(detalle2);
end.