Un sistema de gestión de correos electrónicos desea manejar los correos recibidos por cada cliente. De cada cliente 
conoce su código (1..1000), dirección de email y todos los mensajes de correo que ha recibido. De cada mensaje conoce 
la dirección del emisor, la fecha de envío, el asunto, el texto y si ya fue leído.
Realizar un programa que invoque a módulos para:
1. Leer y almacenar los correos electrónicos en una estructura de datos eficiente para la búsqueda por código de cliente. 
La lectura finaliza al ingresar el cliente O.
De cada correo se lee el id del cliente, su dirección de correo y toda la información del mensaje. La información debe 
quedar agrupada por cliente.
2. Leer un código de cliente e informar la cantidad de correos sin leer.
3. Leer una dirección de correo e informar la cantidad de correos enviados desde dicha dirección.

Program EjercicioVideo;
type
    rangoCod = 1..1000;
    mensaje = record
        dirEmisor: string;
        fecha: string;
        asunto: string;
        texto: string;
        leido: boolean;
    end;

    listaMensajes = ^nodo;
    nodo = record
        elem: mensaje;
        sig: listaMensajes;
    end;

    cliente = record
        cod: rangoCod;
        dir: string;
    end;

    mensajeLeido = record
        cli: cliente;
        mens: mensaje;
    end;

    correosCliente = record
        cli: cliente;
        mens: listaMensajes;
    end;

    arbol = ^nodoAr;
    nodoAr = record
        elem: correosCliente;
        hi: arbol;
        hd: arbol;
    end;

    procedure leerCorreo(var m: mensajeLeido);
    var
        leido: integer;
    begin
        writeln('Ingrese código: ');
        readln(m.cli.cod);
        if(m.cli.cod <> 0) then begin
            writeln('Ingrese dirección: ');
            readln(m.cli.dir);
            writeln('Ingrese emisor: ');
            readln(m.mens.dirEmisor);
            writeln('Ingrese fecha: ');
            readln(m.mens.fecha);
            writeln('Ingrese asunto: ');
            readln(m.mens.asunto);
            writeln('Ingrese el texto: ');
            readln(m.mens.texto);
            writeln('Ingrese 1 en caso de haberlo leido, 0 en caso conttrario:');
            readln(leido);
            if(leido = 1) then m.mens.leido:= true
            else m.mens.leido:= false;
        end;
    end;
    
    procedure agregarAdelanteLista(var l: listaMensajes; m: mensaje);
    var
        nuevo: listaMensajes;
    begin
        new(nuevo); nuevo^.elem:= m; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure agregarAlArbol(var a: arbol; m: mensajeLeido);
    begin
        if(a = nil) then
            begin
                new(a);
                a^.elem.cli:= m.cli;
                a^.elem.mens:= nil;
                agregarAdelanteLista(a^.elem.mens, m.mens);
                a^.hi:= nil;
                a^.hd:= nil;
            end
        else 
            if(a^.elem.cli.cod = m.cli.cod) then agregarAdelanteLista(a^.elem.mens, m.mens)
            else
                if(a^.elem.cli.cod > m.cli.cod) then agregarAlArbol(a^.hi, m)
                else agregarAlArbol(a^.hd, m);
    end;

    procedure cargarInformacion(var a: arbol);
    var
        m: mensajeLeido;
    begin
        leerCorreo(m);
        while(m.cli.cod <> 0) do begin
            agregarAlArbol(a, m);
            writeln(m.cli.cod);
            writeln(m.cli.dir);
            leerCorreo(m);
        end;    
    end;


    function recorrerLista(l: listaMensajes): integer;
    var
        cant: integer;
    begin
        cant:= 0;
        while(l <> nil) do
        begin
            if(l^.elem.leido = false) then cant:= cant + 1;
            l:= l^.sig;
        end;
        recorrerLista:= cant;
    end;
    
    function retornarMensajesSinLeer(a: arbol; cod: rangoCod): integer;
    begin
        if(a = nil) then retornarMensajesSinLeer:= -1
        else begin
            if(a^.elem.cli.cod = cod) then retornarMensajesSinLeer:= recorrerLista(a^.elem.mens)
            else begin
                if(a^.elem.cli.cod > cod) then retornarMensajesSinLeer(a^.hi, cod)
                else retornarMensajesSinLeer(a^.hd, cod);
            end;
        end;
    end;

    function contarClienteActual(l: listaMensajes; dir: string): integer;
        cant: integer;
    begin
        cant:= 0
        while(l <> nil) do
            begin
                if(l^.elem.dirEmisor = dir) then cant:= cant + 1;
                l:= l^.sig;
            end;
        contarClienteActual:= cant;
    end;

    function cantidadCorreosEnviados(a: arbol; dir: string): integer;
    begin
        if(a = nil) then cantidadCorreosEnviados:= -1;
        else
            begin
                cantidadCorreosEnviados:= contarClienteActual(a^.elem.mens, dir) + cantidadCorreosEnviados(a^.hi) + cantidadCorreosEnviados(a^.hd);
            end;
    end;

var
    a: arbol;
    codCliente: rangoCod;
    dirCorreo: string;
    cant: integer;
begin
    cargarInformacion(a);
    writeln('Ingrese un codigo de cliente:');
    readln(codCliente);
    retornarMensajesSinLeer(a, codCliente);
    writeln('Ingrese una dirección de correo:');
    readln(dirCorreo);
    cant:= cantidadCorreosEnviados(a);
end.