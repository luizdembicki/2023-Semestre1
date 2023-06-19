clear
clc

//ar

t0 = 0 //tempo inicial (s)
tn = 150 //tempo final (s), especificado no enunciado
y0 = 1 //theta inicial - Th(t0) (adimensional)
n = 1500 //número de passos, varíavel

T0 = 152.9 //temperatura inicial do sólido (°C)
Tinf = 20.2 //temperatura final do sólido e do fluido (°C)

//propriedades da esfera:
D = 0.0044 //diâmetro (m)
Cps = 173 //calor específico (J/(kg°C))
ro = 8600 //massa específica (kg/m^3)

A = %pi*D^2 //área superficial da esfera (m^2)
V = %pi*D^3/6 //volume da esfera (m^3)

//propriedades do fluido:
Cpf = 1010 //calor específico (J/(kg°C))
    //coeficientes para o cálculo de "mi":
    a1 = 4.46e-8
    b1 = 1.72e-5
    //coeficientes para o cálculo de "ro":
    a2 = 8.78e-6
    b2 = -4.33e-3
    c2 = 1.29
    //coeficientes para o cálculo de k:
    a3 = -3.44e-8
    b3 = 7.61e-5
    c3 = 2.44e-2

g = 9.78 //aceleração da gravidade (m/s^2)

function f = fun(t, y) //equação diferencial a ser resolvida
    T = y*(T0 - Tinf) + Tinf //temperatura do sólido em função de theta
    Tf = (T + Tinf)/2 //temperatura de filme do sólido
    
    B = 1/Tf //coeficiente de expansão térmica (K^(-1))
    mi = a1*Tf + b1 //viscosidade dinâmica do fluido (kg(m.s))
    rof = a2*Tf^2 + b2*Tf + c2 //massa específica do fluido (kg/m^3)
    ni = mi/rof //viscosidade cinemática do fluido (m^2/s)
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
tc = [19.8, 21.3, 22.8, 24.3, 25.6, 27.2, 28.6, 30.1, 31.6, 33.0, 34.5, 36.0, 37.4, 38.8, 40.1, 41.6, 43.0, 44.5, 46.0, 47.4, 48.8, 50.3, 51.8, 53.3, 54.6, 55.2, 57.6, 58.9, 60.4, 61.8, 63.3, 64.7, 66.2, 67.6, 68.9, 70.4, 72.0, 73.3, 74.8, 76.0, 77.6, 79.0, 80.4, 81.6, 83.2, 84.6, 86.2, 87.6, 89.0, 90.5, 92.0, 93.3, 94.8, 96.2, 97.6, 99.0, 100.5, 102.0, 103.6, 104.8, 106.0, 107.6, 109.0, 110.6, 112.0, 113.4, 114.8, 116.3, 117.6, 119.0, 120.6, 122.0, 123.3]

//temperatura medida (°C):
tm = [152.9, 147.9, 142.6, 137.8, 132.8, 128.3, 122.0, 120.1, 116.5, 112.9, 109.3, 106.3, 103.3, 100.5, 97.6, 94.8, 92.1, 89.5, 86.8, 84.3, 81.9, 79.7, 77.6, 75.5, 73.4, 71.5, 69.6, 67.9, 66.1, 64.4, 62.8, 61.1, 59.6, 58.0, 56.5, 55.1, 53.8, 52.5, 51.3, 50.1, 49.0, 48.0, 47.0, 46.0, 45.0, 44.1, 43.2, 42.5, 41.7, 40.9, 40.2, 39.5, 38.9, 38.3, 37.8, 37.1, 36.5, 35.9, 35.5, 34.9, 34.5, 34.1, 33.8, 33.3, 32.9, 32.5, 31.9, 31.6, 31.2, 30.9, 30.6, 30.3, 29.9]


//fazendo tc(1) = 0 e convertendo as temperaturas medidas em theta:
x = size(tc, "*") //número de medidas
for i = 1:x
    tr(i) = tc(i) - tc(1)
    th(i) = (tm(i)-Tinf)/(T0- Tinf)
end

//confecção do gráfico:
plot(t, y)
scatter(tr, th, 10, "red")
xtitle("Theta(t) para o ar", "t (s)", "Theta")

r = gca()
r.data_bounds = [0, -0.1; tn, 1] //[xmin, ymin; xmax, ymax] para os eixos
