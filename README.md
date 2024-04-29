
# **My Recipes App!**  Made with Flutter.

Este projeto foi desenvolvido para consolidar os conceitos estudados nos cursos **"Flutter com Web API: integrando sua aplicação"** e **"Flutter: aplicando persistência de dados".**

O objetivo do projeto além de por em prática conceitos visto, é estudar como o Dart junto ao framework Flutter lida com requisições para WebAPI's.

Foi utilizado Node.js para levantar uma fakeAPI em um servidor local, fornecendo endpoints para autenticação e para realização de todo CRUD de receitas da aplicação.

Também foi utilizada a API de imagens da "Pexels", ao criar/editar uma receita ou categoria o usuário pode escolher uma imagem das fornecidas pelo Pexels para representar sua receita ou categoria.

Na pasta "Screenshots_Here" é possível visualizar prints das telas do aplicativo

As bibliotecas utilizadas foram:
* **uuid**: usada para gerar identificadores únicos universais (UUIDs).
* **http**: fornece um conjunto de funções de alto nível para realizar solicitações HTTP em aplicativos Dart.
* **http_interceptor**: usada para interceptar solicitações HTTP e respostas
* **logger**: facilita o processo de log no desenvolvimento, ajudando no diagnóstico e na solução de problemas de aplicações.
* **shared_preferences**: é usada para persistir dados de forma leve e simples em armazenamento local.
* **flutter_dotenv**: Utilizada para gerenciar configurações que podem variar entre diferentes ambientes de desenvolvimento, como URLs de APIs, chaves secretas, e outras configurações sensíveis que não devem ser hard-coded no código-fonte
