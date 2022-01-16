# README

## Sobre o Projeto

Este é um projeto de exercício do programa Quero Ser Dev 7 da Locaweb. O projeto consiste em um sistema de gerenciamento de galpões.


## API

### Galpões

#### Listar todos os galpões

**Requisiçao:**

```
GET /api/v1/warehouses
```
**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
  },
  
  {
    "id": 2,
    "name": "JF Galpões",
    "code": "JFG",
  }
]
```
#### Listar detalhes de um galpão

**Requisiçao:**

```
GET /api/v1/warehouses/2
```
**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 2,
    "name": "JF Galpões",
    "code": "JFG",
    "description": "Lindo galpão a beira mar",
    "address": "Av. Rio Branco, 1254",
    "city": "Juiz de Fora",
    "state": "MG",
    "zip_code": "36015-412",
    "total_area": 10000,
    "useful_area": 2500
  }
]
```
#### Criar um galpão

**Requisiçao:**

```
POST /api/v1/warehouses
```
**Resposta:**

```
Status: 201 (Criado)

[
  {
    "id": 2,
    "name": "JF Galpões",
    "code": "JFG",
    "description": "Lindo galpão a beira mar",
    "address": "Av. Rio Branco, 1254",
    "city": "Juiz de Fora",
    "state": "MG",
    "zip_code": "36015-412",
    "total_area": 10000,
    "useful_area": 2500
  }
]
```


