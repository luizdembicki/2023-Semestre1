clear
clc

//água

t0 = 0 //tempo inicial (s)
tn = 40 //tempo final (s), especificado no enunciado
y0 = 1 //theta inicial - Th(t0) (adimensional)
n = 1500 //número de passos, varíavel

T0 = 147.1 //temperatura inicial do sólido (°C)
Tinf = 19.8 //temperatura final do sólido e do fluido (°C)

//propriedades da esfera:
D = 0.0044 //diâmetro (m)
Cps = 173 //calor específico (J/(kg°C))
ro = 8600 //massa específica (kg/m^3)

A = %pi*D^2 //área superficial da esfera (m^2)
V = %pi*D^3/6 //volume da esfera (m^3)

//propriedades do fluido:
B = 2.95e-4 //coeficiente de expansão térmica (K^(-1))
Cpf = 4180 //calor específico (J/(kg°C))
    //coeficientes para o cálculo de "mi":
    a1 = 1.47e-7
    b1 = -2.53e-5
    c1 = 1.44e-3
    //coeficientes para o cálculo de "ni":
    a2 = 1.46e-10
    b2 = -2.51e-8
    c2 = 1.44e-6
    //coeficientes para o cálculo de k:
    a3 = -9e-6
    b3 = 2.04e-3
    c3 = 0.561

g = 9.78 //aceleração da gravidade (m/s^2)

function f = fun(t, y) //equação diferencial a ser resolvida
    T = y*(T0 - Tinf) + Tinf //temperatura do sólido em função de theta
    Tf = (T + Tinf)/2 //temperatura de filme do sólido
    
    mi = a1*Tf^2 + b1*Tf + c1 //viscosidade dinâmica do fluido (kg(m.s))
    ni = a2*Tf^2 + b2*Tf + c2 //viscosidade cinemmática do fluido (m^2/s)
    k = a3*Tf^2 + b3*Tf + c3 //condutividade térmica do fluido (W/(m°C))
    
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
tc = [25.8, 26.6, 27.5, 28.9, 30.5, 32.0, 33.2, 34.8, 35.1, 37.8, 39.4, 41.0, 42.2, 43.2, 44.8, 47.5, 50.6, 52.0, 60.0]

//temperatura medida (°C):
tm = [147.1, 141.8, 74.5, 36.2, 28.1, 25.1, 23.4, 22.4, 21.8, 21.3, 20.9, 20.7, 20.5, 20.4, 20.2, 20.1, 20.0, 19.9, 19.8]

//fazendo tc(1) = 0 e convertendo as temperaturas medidas em theta:
x = size(tc, "*") //número de medidas
for i = 1:x
    tr(i) = tc(i) - tc(1)
    th(i) = (tm(i)-Tinf)/(T0- Tinf)
end

//confecção do gráfico:
plot(t, y)
scatter(tr, th, 10, "red")
xtitle("Theta(t) para a água", "t (s)", "Theta")

r = gca()
r.data_bounds = [0, -0.1; tn, 1] //[xmin, ymin; xmax, ymax] para os eixos
