# 🎮 Steering Behaviors - Godot

## 📌 Sobre o projeto

Projeto feito na Godot para demonstrar alguns Steering Behaviors usados em IA de jogos.

A ideia é mostrar como um agente muda seu movimento dependendo do comportamento escolhido.

---

## 🧠 Behaviors implementados

* **Seek / Flee**

  * Seek: vai até o alvo
  * Flee: foge quando está perto

* **Arrival / Departure**

  * Arrival: chega desacelerando
  * Departure: se afasta quando está próximo

* **Wander**

  * Movimento aleatório

* **Obstacle Avoidance**

  * Desvia de obstáculos

* **Pursuit (extra)**

  * Tenta interceptar o alvo

---

## 🎮 Como usar

* Rode o projeto na Godot
* Use as teclas:

| Tecla | Ação      |
| ----- | --------- |
| 1     | Seek      |
| 2     | Arrival   |
| 3     | Flee      |
| 4     | Wander    |
| 5     | Departure |

* O mouse controla o Target
* O agente reage em tempo real

---

## 🗂️ Estrutura

* `character.gd` → agente
* `target.gd` → alvo segue o mouse

Cena:

* Character
* Target
* Obstacle
* HUD

---

## ⚠️ Dificuldades

* Wander e Flee pouco visíveis
  → ajustei parâmetros

* Avoidance interferindo
  → usei pesos

* Diferença entre behaviors
  → resolvido com teclado + mouse

---

## 📚 Referências

* Material da disciplina
* Documentação da Godot
* Craig Reynolds
