/*
Escriba un programa que lea las alturas de los 15 jugadores de un equipo de básquet y las almacene 
en un vector. Luego informe: - la altura promedio - la cantidad de jugadores con altura por encima del 
promedio NOTA: Dispone de un esqueleto para este programa en Ej02Jugadores.ja
*/

package javaapplication1;

import PaqueteLectura.Lector;
public class JavaApplication1 {

    public static void main(String[] args) {
       
        double [] alturas = new double[15];
        double promedio = 0;
        int mayorAlPromedio = 0;
       
        for (int i=0; i<15; i++) {
            System.out.println("Ingrese la altura del jugador");
            double altura = Lector.leerDouble();
            alturas[i] = altura;
        }
       
        System.out.println("Imprimo las alturas");
        for(int i=0; i<15; i++) {
            System.out.println("Vector posicion " + i + " jugador altura: " + alturas[i]);
            promedio = promedio + alturas[i];
        }
       
        promedio = promedio / 15;
        System.out.println("El promedio de alturas es: " + promedio);
       
        for(int i=0; i<15; i++) {
            if(alturas[i] > promedio)
                mayorAlPromedio = mayorAlPromedio + 1;
        }
       
        System.out.println("La cantidad de jugadores con altura amyor al promedio es de: " + mayorAlPromedio);
       
    }
   
}

