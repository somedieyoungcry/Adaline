clear all; clc;
disp('Ingreso de Datos')
%Declaracion de patrones
p1 = [0;0];
p2 = [0;1];
p3 = [1;0];
p4 = [1;1];
P = {p1,p2,p3,p4};
Pi = [p1 p2 p3 p4]
%Salida en valor a T
T = [0 0 0 1]
%Peso, Ganancia y Aprendizaje
w = [0.5 0.5];
b =  0.5;
W = {w};
B={b};
alp = 0.9;

%Se grafican los puntos iniciales 
hold on;
for i = 1: size(P,2)
   
    if(T(i)>0)
        plot(P{i}(1),P{i}(2),'*b');
    else
        plot(P{i}(1),P{i}(2),'*r');
    end
end

%Imprimimos los valores iniciales
xi = -b/w(1);
yi = -b/w(2);
disp('Inicio:');
fprintf('Ganancia: %f\n',b); #Imprime la ganancia
fprintf('Peso: [%f %f]\n',w); #Imprime el peso que se tiene hasta el momento
fprintf('X(0)= %f ,Y(0)=%f\n',xi,yi);
plot(xi,yi,'xblack');


%Asignamos titulo a la grafica que se dibujara
title('Graficacion de puntos y errores');
xlabel('X');
ylabel('Y');
j = 1;

%Comenzamos con el calculo y las iteraciones
for n = 1: 100
    fprintf('Iteracion No: %d\n',n); #Indica el numero de iteracion en la que se va
    cont = 0;
    for i = 1 : size(P,2)
        fprintf('Patron No: %d\n',i); #Indica el patron que se tiene
        ai = hardlim(w*P{i}+b);
        fprintf('a(%d)= %f\n',i,ai);
        ei = T(i) - ai;
        fprintf('e(%d) = %f\n',i,ei);
        if(ei ~= 0)
           disp('Ajuste:'); #Indica el ajuste que se hace
           W{j+1} =  w+(2*alp*ei*P{i})';
           fprintf('w(%d) = [%f %f] \n',i,W{j+1});
           B{j+1} = b + 2*alp*ei;
           fprintf('b(%d)= %f\n',i,B{j+1});
           j = j + 1;
        else
            cont = cont + 1;
        end     
        w = W{j};
        b = B{j};
        disp('__________________');
    end
    
   
    %Peso y Ganancia dados en las ultimas iteraciones
    fprintf('Ganancia: %f\n',b);
    fprintf('Peso: [%f %f]\n', w);
    xi = -b/w(1); 
    yi = -b/w(2);
    fprintf('X(%d)= %f ,Y(%d)=%f\n',n,xi,n,yi);
    plot(xi,yi,'xblack'); #Grafica la ganancia y el peso de las ultimas iteraciones
    if(cont==size(P,2))
        x = -10:0.1:10;
        y = -w(1)*x/w(2) - b/w(2);
        plot(x,y,'black');
        break;
    end
   ddisp('**********************************************'); 
end
hold off;
