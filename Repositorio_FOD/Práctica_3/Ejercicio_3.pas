Realizar un programa que gestione un archivo de libros de una librería. De cada libro se registra:
código, género, título, autor, cantidad de páginas y precio. El programa debe presentar un menú
con las siguientes opciones:
a. Crear el archivo y cargarlo con datos ingresados por teclado, utilizando la técnica de
lista invertida para recuperar espacio libre en el archivo.
b. Abrir el archivo existente y permitir su mantenimiento mediante las siguientes
operaciones:
i. Dar de alta un libro leyendo la información desde el teclado. Para esta
operación, en caso de ser posible, deberá recuperarse el espacio libre usando la
lista invertida.
ii. Modificar los datos de un libro leyendo la información desde el teclado. El
código del libro no puede ser modificado.
iii. Eliminar un libro cuyo código es ingresado por teclado.
c. Exportar el contenido del archivo de libros a un archivo de texto llamados “libros.txt”,
excluyendo los registros marcados como borrados.
NOTAS:
● Debe utilizar una lista invertida para la recuperación del espacio libre.
○ El primer registro del archivo se utiliza como cabecera de la lista.
■ El campo código de la cabecera tiene el valor cero (0) si no hay espacio libre.
■ Si el campo código de la cabecera tiene un valor negativo, indica la posición del
primer registro a reutilizar.
○ Los registros libres (aquellos marcados como borrados) utilizan el campo código como
enlace, almacenando la posición en forma negativa del siguiente registro en la lista
invertida
○ En la operación de alta:
■ Si la cabecera indica que hay espacio libre, se debe reutilizar el primer registro
disponible. Además, se debe actualizar la cabecera con la siguiente posición en
la lista invertida de espacios libres.
■ Si la cabecera indica que no hay espacio libre, se debe agregar el nuevo registro
al final del archivo.
○ En la operación de baja:
■ El registro borrado se debe incorporar a la lista invertida de espacios libres. Al ser
una lista invertida (o pila), el último registro borrado es el próximo a ser reutilizado.
Para ello, en el registro borrado se almacena el valor actual de la cabecera,
mientras que la cabecera se actualiza con la posición (en valor negativo) del
registro borrado.
● Tanto en la creación como en la apertura el nombre del archivo debe ser proporcionado por el
usuario.

program ejercicio3;
const
    valorAlto = 9999;
type
    libro = record
        codigo: integer;
        gonero: string[10];
        titulo: string[10];
        autor: string[10];
        cantpag: integer;
        precio: real;
    end;
    archivo = file of libro;

    archTexto = file of text;

    procedure leerTeclado(var l: libro);
    begin
        writeln("Ingrese el codigo del libro");
            readln(l.codigo);
            writeln("Ingrese el genero del libro");
            readln(l.genero);
            writeln("Ingrese el titulo del libro");
            readln(l.titulo);
            writeln("Ingrese el autor del libro");
            readln(l.autor);
            writeln("Ingrese la cantidad de paginas del libro");
            readln(l.cantpag);
            writeln("Ingrese el precio del libro");
            readln(l.precio);
    end;

    procedure crearYCargar(var arch: archivo);
    var
        nombreArch: string[10];
        l: libro;
    begin
        writeln("Ingrese el nombre del archivo a utilizar");
        readln(nombreArch);
        assign(arch, nombreArch);
        rewrite(arch);

        l.codigo:= 0;
        write(arch, l);
        leerTeclado(l);

        while(l.codigo <> valorAlto) do begin
            write(arch, l);
            leerTeclado(l);
        end;
        close(arch);
    end;

    procedure mantenimientoArch(var arch: archivo);
    var
        nombreArch: string[10];
        opcion: integer;
        l, nuevo: libro;
        libModi, libEli: integer;
        baja: integer;
    begin
        writeln("Ingrese el nombre del archivo a utilizar");
        readln(nombreArch);
        assign(arch, nombreArch);
        reset(arch);

        writeln("Ingrese la opcion a realizar");
        writeln("Opcion i: Dar de alta un libro");
        writeln("Opcion ii: Modificar los datos de un libro");
        writeln("Opcion iii: Eliminar un libro");
        writeln("Opcion 0 para terminar");

        readln(opcion);

        while(opcion <> 0) do begin
            if(opcion = 1) then begin
                leerTeclado(nuevo);
                while(nuevo.codigo <> valorAlto) do begin
                    seek(arch, 0);
                    read(arch, cabecera);
                    if(cabecera.codigo <> 0) then begin
                        posLibre:= -cabecera.codigo;
                        seek(arch, posLibre);
                        read(arch, l);

                        cabecera.codigo:= l.codigo;
                        seek(arch, 0);
                        write(arch, cabecera);

                        seek(arch, posLibre);
                        write(arch, nuevo);
                    end
                    else begin
                        seek(arch, fileSize(arch));
                        write(arch, nuevo);
                    end;
                    leerTeclado(nuevo);
                end;
            end
            else if(opcion = 2) then begin
                writeln("Ingrese el codigo del libro a modificar");
                readln(libModi);
                leer(arch, l);

                while(l.codigo <> valorAlto) and (l.codigo <> libModi) do
                    leer(arch, l);
                if(l.nom = libModi) then begin
                    writeln("Ingrese el genero del libro");
                    readln(l.genero);
                    writeln("Ingrese el titulo del libro");
                    readln(l.titulo);
                    writeln("Ingrese el autor del libro");
                    readln(l.autor);
                    writeln("Ingrese la cantidad de paginas del libro");
                    readln(l.cantpag);
                    writeln("Ingrese el precio del libro");
                    readln(l.precio);

                    seek(arch, filePos(arch) - 1);
                    write(arch, l);
                end;
            end
            else begin
                writeln("Ingrese el codigo del libro a eliminar");
                readln(libEli);
                leer(arch, l);

                while(l.codigo <> valorAlto) and (l.codigo <> libEli) do
                    leer(arch, l);
                
                if(libEli = l.codigo) then begin
                    seek(arch, 0);
                    read(arch, cabecera);
                    
                    baja:= filePos(arch) - 1;
                    l.codigo:= cabecera.codigo;

                    seek(arch, baja);
                    write(arch, l);

                    cabecera.codigo:= -baja;
                    seek(arch, 0);
                    write(arch, cabecera);
                end
                else
                    writeln("Libro no encontrado");
            end;
            writeln("Ingrese la opcion a realizar");
            readln(opcion);
        end;

        close(arch);
    end;

    procedure exportar(arch: archivo; var archTexto: text);
    var
        nombreArch: string[10];
        l: libro;
    begin
        writeln(Ingrese el nombre de archivo a utilizar");
        readln(nombreArch);
        assign(arch, nombreArch);
        reset(arch);

        assign(archTexto, 'libros.txt');
        rewrite(archTexto);

        leer(arch, l);
        while(l.codigo <> valorAlto) do begin
            if(l.codigo > 0) then
                writeln(archTexto, l.codigo, ' ', l.genero, ' ', l.titulo, ' ', l.autor, ' ', l.cantpag, ' ', l.precio);
            leer(arch, l);
        end;
        close(arch);
        close(archTexto);
    end;

var
    arch: archivo;
    l: libro;
    opcion: integer;
    texto: archTexto;
begin
    writeln("Ingrese la opcion a realizar");
    writeln("Opcion 1: Crear y cargar archivo");
    writeln("Opcion 2: Mnatenimiento de archivo");
    writeln("Opcion 3: Exportar archivo");
    writeln("Opcion 0 para terminar");

    readln(opcion);
    
    while(opcion <> 0) do begin
        if(opcion = 1) then crearYCargarArch(arch)
        else if(opcion = 2) then mantenimientoArch(arch)
        else exportarArch(arch, archTexto);
        readln(opcion);
    end;
end;
