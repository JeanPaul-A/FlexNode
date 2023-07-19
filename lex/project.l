%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

ExtraerNumeros(char* values, int figura){

    /*Convertir el dato char a double y cortarlo*/
    char* endParam1;
    double param1 = strtod(values, &endParam1);

    char* endParam2;
    double param2 = strtod(endParam1 + 1, &endParam2);
    
    char* endParam3;
    double param3 = strtod(endParam2 + 1, &endParam3);
    
    switch(figura){
        case 1:
            Circulo(param1);
            break;
        case 2:
            Cuadrado(param1);
            break;
        case 3:
            Rectangulo(param1, param2);
            break;
        case 4:
            Triangulo(param1, param2);
            break;
        case 5:
            Trapecio(param1, param2, param3);
            break;
    }
}

Circulo(double radio){
    double area = 3.14 * radio * radio;
    printf("Área del círculo: %f\n", area);
}

Cuadrado(double lado){
    double area = lado * lado;
    printf("Área del cuadrado: %f\n", area);
}

Rectangulo(double largo, double ancho){
    double area = largo * ancho;
    printf("Área de rectángulo: %f\n", area);
}

Triangulo(double base, double altura){
    double area = (base * altura) /2;
    printf("Área del triángulo: %f\n", area);
}

Trapecio(double baseMayor, double baseMenor, double altura){
    double area = ((baseMayor + baseMenor) / 2) * altura;
    printf("Área del trapecio: %f\n", area);
}
%}

%%
("Circulo"|"Cuadrado"|"Rectangulo"|"Triangulo"|"Trapecio")"("(([a-zA-Z])(",")?)+")" { printf("Solo son válidos parámetros numéricos"); }

"Circulo("[\t\n]?")" { printf("Es necesario el radio\n"); }
"Circulo("[1-9]+(\.[0-9]+)?")" { ExtraerNumeros(yytext + 8, 1); }
"Circulo("[1-9]+(\.[0-9]+)?(","[1-9]+(\.[0-9]+)?)+")" { printf("Parámetros innecesarios"); }

"Cuadrado("[\t\n]?")" { printf("Es necesario el lado\n"); }
"Cuadrado("[1-9]+(\.[0-9]+)?")" { ExtraerNumeros(yytext + 9, 2); }
"Cuadrado("[1-9]+(\.[0-9]+)?(","[1-9]+(\.[0-9]+)?)+")" { printf("Parámetros innecesarios"); }

"Rectangulo("[\t\n]?")" { printf("Son necesarios la base y altura"); }
"Rectangulo("[1-9]+(\.[0-9]+)?(",")?")" { printf("Hace falta un parámetro"); }
"Rectangulo("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?")" { ExtraerNumeros(yytext + 11, 3); }
"Rectangulo("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?(","[1-9]+(\.[0-9]+)?)+")" { printf("Parámetros innecesarios"); }

"Triangulo("[\t\n]?")" { printf("Son necesarios la base y altura"); }
"Triangulo("[1-9]+(\.[0-9]+)?(",")?")" { printf("Hace falta un parámetro"); }
"Triangulo("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?")" { ExtraerNumeros(yytext + 10, 4); }
"Triangulo("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?(","[1-9]+(\.[0-9]+)?)+")" { printf("Parámetros innecesarios"); }

"Trapecio("[\t\n]?")" { printf("Son necesarios la base mayor, base menor y altura"); }
"Trapecio("[1-9]+(\.[0-9]+)?(",")?")" { printf("Hacen falta dos parámetros"); }
"Trapecio("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?(",")?")" { printf("Hace falta un parámetro"); }
"Trapecio("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?")" { ExtraerNumeros(yytext + 9, 5); }
"Trapecio("[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?","[1-9]+(\.[0-9]+)?(","[1-9]+(\.[0-9]+)?)+")" { printf("Parámetros innecesarios"); }

.* { printf("Digite respetando la estructura"); }
%%

int main(){
    yyin = stdin;
    yylex(); 
    return 0;
}