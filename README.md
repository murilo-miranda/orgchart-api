# README

# Projeto - Organograma da Empresa

## Informações técnicas

- Ruby 3.2.7
- Rails 8.0.2
- Postgres 14

## Como executar o projeto

- Instale docker na máquina
- Faça clone do projeto
- Na raiz do projeto, gere a imagem com o comando:
```
docker build .
```
- Na raiz do projeto, execute o container com o comando:
```
docker compose up
```
- Na raiz do projeto, acesse o container com o comando:
```
docker exec -it orgchart-api-web-1 bash
```

### Como executar os testes
- Dentro do container, execute o comando:
```
rspec
```

## Endpoints

### Empresa

#### Criar uma empresa:
- argumento (name:)
- Query:
```
mutation {
  createCompany(input: {name: "Uol"}) {
    company {
      id
      name
    }
    errors {
      message
      path
    }
  }
}
```
- Resposta de sucesso
```
{
  "data": {
    "createCompany": {
      "company": {
        "id": "53",
        "name": "Uol"
      },
      "errors": []
    }
  }
}
```
- Resposta de falha
```
{
  "data": {
    "createCompany": {
      "company": null,
      "errors": [
        {
          "message": "can't be blank",
          "path": [
            "attributes",
            "name"
          ]
        }
      ]
    }
  }
}
```

#### Listar empresas:
- Query:
```
{
  companies {
    id
    name
  }
}
```
- Resposta de sucesso
```
{
  "data": {
    "companies": [
      {
        "id": "1",
        "name": "UOL"
      },
      {
        "id": "2",
        "name": "Qulture Rocks"
      }
    ]
  }
}
```

#### Listar informação de uma empresa:
- argumento (id:)
- Query:
```
{
  company(id: 1) {
    id
    name
  }
}
```
- Resposta de sucesso
```
{
  "data": {
    "company": {
      "id": "1",
      "name": "UOL"
    }
  }
}
```
- Resposta de falha
```
{
  "data": {
    "company": null
  },
  "errors": [
    {
      "message": "Couldn't find Company with 'id'=3",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ],
      "path": [
        "company"
      ]
    }
  ]
}
```
