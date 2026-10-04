# Délix — App de Delivery

Aplicação de cardápio online e pedidos, desenvolvida em **Flutter** com **Firebase**.


## Sobre

O Délix permite ao utilizador criar conta, consultar o cardápio, marcar favoritos, adicionar produtos ao carrinho e fazer pedidos. Inclui também uma área para cadastrar, editar e remover produtos. Os preços são apresentados em Kwanzas (Kz).

## Funcionalidades

- Registo e login com e-mail e senha
- Sessão guardada no dispositivo, com login e logout automáticos
- Catálogo com pesquisa e filtro por categoria (Alimentos e Refrigerantes)
- Favoritos guardados por utilizador
- Carrinho com contador de itens e opção de anular
- Finalização de pedidos e histórico de compras
- Gestão de produtos (criar, editar e excluir)
- Animações e transições (Hero, formulários e cartões animados)

## Tecnologias

- **Flutter** e **Dart**
- **Provider** — gestão de estado
- **Firebase Authentication** e **Realtime Database** (via API REST)
- **http**, **shared_preferences** e **intl**

## Como executar

Requisitos: Flutter 3.38 ou superior.

```bash
git clone https://github.com/leopoldokiala/delix.git
cd delix
flutter pub get
flutter run
```

## Autor

**Leopoldo Kiala** — Desenvolvedor Flutter
[GitHub @leopoldokiala](https://github.com/leopoldokiala)