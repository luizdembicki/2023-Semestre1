clear
clc

//azeite
t0 = 0 //tempo inicial (s)
tn = 150 //tempo final (s), especificado no enunciado
y0 = 1 //theta inicial - Th(t0) (adimensional)
n = 1500 //número de passos, varíavel

T0 = 139.6 //temperatura inicial do sólido (°C)
Tinf = 20.4 //temperatura final do sólido e do fluido (°C)

//propriedades da esfera:
D = 0.0044 //diâmetro (m)
Cps = 173 //calor específico (J/(kg°C))
ro = 8600 //massa específica (kg/m^3)

A = %pi*D^2 //área superficial da esfera (m^2)
V = %pi*D^3/6 //volume da esfera (m^3)

//propriedades do fluido:
B = 0.0007 //coeficiente de expansão térmica (K^(-1))
Cpf = 4180 //calor específico (J/(kg°C))
rof = 879 //massa específica do luido (kg/m^3)
k = 0.165 //condutividade térmica do fluido (W/(m°C))
    
//coeficientes para o cálculo de "mi":
a1 = 228
b1 = 119

g = 9.78 //aceleração da gravidade (m/s^2)

function f = fun(t, y) //equação diferencial a ser resolvida
    T = y*(T0 - Tinf) + Tinf //temperatura do sólido em função de theta
    Tf = (T + Tinf)/2 //temperatura de filme do sólido
    
    mi = (a1 - b1*log10(Tf))/1000 //viscosidade dinâmica do fluido (kg(m.s))
    ni = mi/rof //viscosidade cinemática do fluido (m^2/s) 
    
    Pr = mi*Cpf/k //número de Prandtl
    Ra = g*B*(T-Tinf)*D^3*Pr/ni^2 //número de Rayleigh
    
    //para o cálculo de Nu:
    n1 = 0.589*Ra^(1/4)
    n2 = (0.469/Pr)^(9/16)
    n3 = (1 + n2)^(4/9)
    
    Nu = 2 + (n1/n3) //número de Nusselt
    
    h = k*Nu/D //coeficiente de transf. de calor por conveccção
    
    b = (h*A)/(ro*V*Cps)
    
    f = -b*y
endfunction

function [t, y] = rk4(f, t0, y0, tn, n)
    H = (tn-t0)/n //passo de integração
    
    t(1) = t0
    y(1) = y0
    
    for i = 1:n
        t(i+1) = t(i)+H
        f1 = f(t(i), y(i))
        f2 = f(t(i)+H/2, y(i)+H/2*f1)
        f3 = f(t(i)+H/2, y(i)+H/2*f2)
        f4 = f(t(i)+H, y(i)+H*f3)
        y(i+1) = y(i) + H/6*(f1+2*f2+2*f3+f4)
    end
endfunction


[t, y] = rk4(fun, t0, y0, tn, n)

disp([t, y])

//dados experimentais:
//tempo no cronômetro (s):
tc = [20.8, 21.4, 22.8, 24.3, 25.8, 27.0, 28.6, 30.0, 31.5, 32.8, 34.3, 35.8, 37.1, 38.6, 40.2, 41.4, 43.0, 44.3, 45.8, 47.3, 48.6, 50.0, 51.6, 53.0, 54.5, 56.0, 57.3, 58.8, 60.2, 61.6, 63.0, 64.5, 65.8, 67.4, 68.8, 70.2, 71.6, 73.0, 74.5, 76.0, 77.4, 78.8, 80.1, 81.6, 84.5, 85.9, 90.2, 93.0, 97.4, 98.8, 102.0, 107.4, 111.6, 121.6, 127.4, 141.6, 158.8]

//temperatura medida (°C):
tm = [139.6, 135.3, 99.5, 78.4, 67.0, 58.5, 52.1, 47.3, 43.4, 40.3, 37.8, 35.6, 33.9, 32.6, 31.4, 30.3, 29.3, 28.6, 27.8, 27.3, 26.7, 26.2, 25.8, 25.4, 25.0, 24.7, 24.4, 24.1, 23.9, 23.6, 23.4, 23.2, 23.1, 22.9, 22.7, 22.6, 22.5, 22.4, 22.3, 22.2, 22.1, 22.0, 21.9, 21.8, 21.6, 21.5, 21.4, 21.3, 21.2, 21.1, 21.0, 20.9, 20.8, 20.7, 20.6, 20.5, 20.4]

//fazendo tc(1) = 0 e convertendo as temperaturas medidas em theta:
x = size(tc, "*") //número de medidas
for i = 1:x
    tr(i) = tc(i) - tc(1)
    th(i) = (tm(i)-Tinf)/(T0- Tinf)
end

//confecção do gráfico:
plot(t, y)
scatter(tr, th, 10, "red")
xtitle("Theta(t) para o azeite", "t (s)", "Theta")

r = gca()
r.data_bounds = [0, -0.1; tn, 1] //[xmin, ymin; xmax, ymax] para os eixos
