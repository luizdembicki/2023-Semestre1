---
marp: true
theme: gaia
class: invert
---
# Exercício de troca de calor radiante

Um gás de chaminé a Tg=1000K e PT=2atm, com composição dada na tabela, flui sobre um banco de tubos disposto segundo um arranjo triangular/quadrado equilátero, tendo os tubos D=7,6 cm e espaçamento S=2D. Os tubos são mantidos a uma Tw=500K uniforme e são considerados negros. 

---

##### Exercício de troca de calor radiante

Calcule o intercâmbio líquido de calor radiante entre a mistura gasosa e os tubos, por m² da superfície da parede dos tubos. Adicionalmente, justifique os resultados encontrados por você e faça uma análise crítica dos mesmos mediante comparação com os resultados obtidos em outras condições.
Informações adicionais: 2 Atm; 0,6 $H_2O$ ; 0,3 $CO_2$;

---

# Resolução

Utilizamos:
$$ q = \sigma (\mathcal{E}_g T_g^4 - \alpha_g T_w^4 ) $$
Precisamos descobrir $\mathcal{E}_g$ e $\alpha_g$, para tanto usamos o comprimento equivalente:
$$ L = 3 (S - D) $$
$$ L = 3 (7,6 \ cm \cdot 2 - 7,6 \ cm) = 22,8cm$$

---
# Resolução
$$ P_w = 0,6 \cdot 2 \ atm  = 1,2 \ atm $$
$$ P_{CO_2} = 0,3 \cdot 2 \ atm  = 0,6 \ atm $$
Para água:
$$  22,8 \ cm \ \cdot 1,2 \ atm \approx 0,27 \ m \cdot atm \to \mathcal{E}_{g,1000k} \approx 0,2 $$
$$ \to \mathcal{E}_{g,500k} \approx 0,27 $$
Para $CO_2$:
$$  22,8 \ cm \ \cdot 0,6 \ atm \approx 0,13 \ m \cdot atm \to \mathcal{E}_{g,1000k} \approx 0,13 \to \mathcal{E}_{g,500k} \approx 0,11 $$
---
# Resolução
Corrigimos 
Para água:
$$ \frac{P_w + P_T}{2} = 1,6 \to \approx 1,5 \to \mathcal{E}_{g,1000k} \approx 0,2 \cdot 1,5 = 0,3 $$
$$ \to \mathcal{E}_{g,500k} \approx 0,27 \cdot 1,5 \approx 0,41 $$
Para $CO_2$:
$$ P_T = 2 \to \approx 1,2 \to \mathcal{E}_{g,1000k} \approx 0,13 \cdot 1,2 \approx 0,16 $$
$$ \to \mathcal{E}_{g,500k} \approx 0,11 \cdot 1,2 \approx 0,13 $$
---
# Resolução
Juntamos:
$$ \frac{P_w}{P_{CO_2} + P_w} \approx 0,6 \to P_w \cdot L + P_{CO_2} \cdot L = 0,4 \ m \cdot atm \approx 1,3 ft \cdot atm $$
$$ \to \Delta \mathcal{E}_{1000K} \approx  0,02 \ ; \ \Delta \mathcal{E}_{500K} \approx  0,04 $$
Assim:
$$ \mathcal{E}_{g} = 0,3 + 0,16 + 0,02 = 0,48 $$
$$ \alpha_{g} = 0,27 + 0,11 + 0,04 = 0,42 $$
---
# Resolução
Por fim:
$$ q = 5,67\cdot 10^{−8} W·m^{−2}·K^{−4}(0,48 \cdot  1000K^4 - 0,42 \cdot 500K^4 ) $$
$$ \therefore q \approx 25,73 kW/m^2 $$
---
# Obrigado!