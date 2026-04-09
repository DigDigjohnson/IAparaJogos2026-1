# \# 🎮 Steering Behaviors - Godot

# 

# \## 📌 Sobre o projeto

# 

# Este projeto foi desenvolvido na Godot com o objetivo de implementar alguns \*\*Steering Behaviors\*\* usados em IA para jogos.

# 

# A ideia é mostrar como um agente se movimenta de formas diferentes dependendo do comportamento escolhido.

# 

# \---

# 

# \## 🧠 Behaviors implementados

# 

# \* \*\*Seek / Flee\*\*

# 

# &#x20; \* Seek: o agente vai até o alvo.

# &#x20; \* Flee: o agente foge do alvo quando chega perto.

# 

# \* \*\*Arrival / Departure\*\*

# 

# &#x20; \* Arrival: o agente vai até o alvo desacelerando.

# &#x20; \* Departure: o agente se afasta quando está próximo.

# 

# \* \*\*Wander\*\*

# 

# &#x20; \* Movimento aleatório, simulando algo mais “natural”.

# 

# \* \*\*Obstacle Avoidance\*\*

# 

# &#x20; \* O agente desvia de obstáculos no caminho.

# 

# \* \*\*Pursuit (extra)\*\*

# 

# &#x20; \* O agente tenta prever a posição do alvo e interceptar.

# 

# \---

# 

# \## 🎮 Como usar

# 

# \* Rode o projeto na Godot.

# \* Use as teclas para trocar os comportamentos:

# 

# | Tecla | Ação      |

# | ----- | --------- |

# | 1     | Seek      |

# | 2     | Arrival   |

# | 3     | Flee      |

# | 4     | Wander    |

# | 5     | Departure |

# 

# \* O mouse controla o alvo (Target).

# \* O agente reage em tempo real.

# \* Existe um obstáculo na cena que o agente tenta evitar.

# 

# \---

# 

# \## 🗂️ Estrutura do projeto

# 

# \* `character.gd` → script principal do agente

# \* `target.gd` → faz o alvo seguir o mouse

# \* Cena principal contém:

# 

# &#x20; \* Character (agente)

# &#x20; \* Target

# &#x20; \* Obstacle

# &#x20; \* HUD

# 

# Cada comportamento foi implementado em uma função separada no script.

# 

# \---

# 

# \## ⚠️ Dificuldades

# 

# \* Alguns behaviors não apareciam direito (tipo Wander e Flee)

# &#x20; → resolvido ajustando parâmetros

# 

# \* Obstacle avoidance interferia nos outros

# &#x20; → resolvido usando pesos e aplicando só quando necessário

# 

# \* Difícil ver diferença entre behaviors

# &#x20; → resolvido com troca por teclado e target seguindo o mouse

# 

# \---

# 

# \## 📚 Referências

# 

# \* Material da disciplina

# \* Documentação da Godot Engine

# \* Artigo do Craig Reynolds sobre Steering Behaviors

# 

# \---

# 

# \## ✅ Observação

# 

# O projeto permite testar os comportamentos em tempo real e entender melhor como eles funcionam na prática.



