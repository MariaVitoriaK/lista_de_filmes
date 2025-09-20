# 🎬 Movie App — Trabalho Prático Flutter

Este projeto foi desenvolvido como parte do **Trabalho Prático — Desenvolvimento Mobile 3 (Flutter)**, cujo objetivo é criar um aplicativo mobile utilizando **Flutter** que consome uma **API REST** e implementa funcionalidades de autenticação, cadastro, CRUD de recursos e integração com serviços externos.

---

## 📱 Funcionalidades Implementadas

### 🔑 Autenticação

- Tela de **Login** com autenticação local (armazenamento via `SharedPreferences`).
- Tela de **Registro** para criação de novos usuários, também armazenados localmente.
- Usuário deve estar logado para acessar as demais telas.

### 🖼 Splash Screen

- Tela inicial exibida no carregamento do aplicativo.
- Implementada através do `pubspec.yaml`, conforme instruções do professor.

### 🎥 CRUD de Recurso (Filmes)

- Recurso escolhido: **Filmes**.
- Integração com [MockAPI](https://mockapi.io/).
- Funcionalidades:
  - **Listar** filmes (Home).
  - **Adicionar** novo filme.
  - **Editar** filme existente.
  - **Excluir** filme.

### ℹ️ Tela Sobre

- Exibe informações sobre os desenvolvedores (nome, matrícula e curso).

### ⚙️ Tela de Configuração

- Mostra informações do usuário logado.
- Permite **alterar a cor primária do aplicativo (tema)**.
- Implementação via `SettingsProvider`.

### 🗺 Tela com Google Maps

- Integração com `google_maps_flutter`.
- Exibe mapa centralizado na **Universidade de Passo Fundo (UPF)**.
- Coordenadas:
  - Latitude: **-28.232667**
  - Longitude: **-52.381083**

---

## 👨‍💻 Desenvolvedor

- **Nome:** Maria Vitória Kuhn
- **Matrícula:** 197960
- **Curso:** Análise e Desenvolvimento de Sistemas
