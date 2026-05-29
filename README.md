# 📊 Credit Risk Analytics Pipeline
### dbt + BigQuery | Arquitetura em Camadas | Data Quality

![dbt](https://img.shields.io/badge/dbt-Analytics%20Engineering-orange)
![BigQuery](https://img.shields.io/badge/Google-BigQuery-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)

---

## 💼 Contexto de Negócio

Dados inconsistentes em sistemas de crédito podem gerar impactos diretos no negócio, como aprovações indevidas ou recusas injustas de crédito.

Este projeto simula um pipeline de dados de uma fintech, garantindo que dados brutos sejam tratados, padronizados e estruturados para análise de risco de crédito.

---

## 🏗️ Arquitetura em Camadas

Raw (BigQuery) → Staging → Intermediate → Marts

- **Raw:** dados brutos ingeridos do Kaggle no BigQuery  
- **Staging:** limpeza, padronização e tipagem dos dados  
- **Intermediate:** regras de negócio e criação de features de risco  
- **Marts:** tabelas finais para consumo analítico e dashboards  

---

## 📊 Dataset

**Give Me Some Credit — Kaggle**  
https://www.kaggle.com/datasets/brycecf/give-me-some-credit-dataset

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| customer_id | INT | ID do cliente |
| default_last_2y | INT | Inadimplência nos últimos 2 anos (0/1) |
| credit_utilization_ratio | FLOAT | Utilização do limite de crédito rotativo |
| age | INT | Idade do cliente |
| late_payments_30_59_days | INT | Atrasos entre 30 e 59 dias |
| debt_to_income_ratio | FLOAT | Relação entre dívida e renda |
| monthly_income | FLOAT | Renda mensal (valores inválidos tratados como NULL) |
| total_credit_lines | INT | Linhas de crédito e empréstimos abertos |
| late_payments_90_plus_days | INT | Atrasos acima de 90 dias |
| real_estate_loans_count | INT | Empréstimos imobiliários |
| late_payments_60_89_days | INT | Atrasos entre 60 e 89 dias |
| dependents_count | INT | Número de dependentes |

---

## ⚙️ Stack

- dbt Core — transformação de dados (Analytics Engineering)  
- Google BigQuery — data warehouse  
- SQL — linguagem principal  
- Python — ambiente e automação  
- Git — versionamento  

---

## 📁 Estrutura do Projeto

```
credit-risk-dbt/
├── models/
│   ├── staging/
│   │   └── stg_credit.sql
│   ├── intermediate/
│   └── marts/
├── tests/
├── macros/
├── dbt_project.yml
└── README.md
```

---

## 🧪 Qualidade dos Dados

Validações aplicadas via dbt tests:

- `not_null` — campos obrigatórios  
- `unique` — identificação única de clientes  
- `accepted_values` — variável target (0/1)  
- `SAFE_CAST` — tratamento de tipos inconsistentes  
- Tratamento de dados inválidos:
  - idade ≤ 0 → NULL  
  - valores negativos em variáveis financeiras → NULL  
  - conversão segura de renda e dependentes  

---

## 🔄 Modelos dbt

### Staging — `stg_credit.sql`

- Renomeação e padronização das colunas do dataset raw  
- Conversão de tipos com `SAFE_CAST`  
- Tratamento de valores inválidos (idade, renda, dependentes)  
- Estruturação dos dados para camada analítica  

---

### Intermediate *(em construção)*

- Criação de features de risco de crédito  
- Segmentação de comportamento financeiro  
- Regras de negócio para classificação de clientes  

---

### Marts *(em construção)*

- KPIs de inadimplência  
- Segmentação de clientes  
- Base para dashboards analíticos  

---

## 🚀 Como Executar

```bash
git clone https://github.com/vitorlubschinski/credit-risk-analytics-dbt.git
cd credit-risk-analytics-dbt
```

```bash
venv\Scripts\activate
pip install dbt-bigquery
```

```bash
dbt run
dbt test
```

---

## 📈 Próximos Passos

- Intermediate com score de risco de crédito  
- Marts com KPIs de inadimplência  
- Testes avançados de qualidade de dados  
- Macros reutilizáveis no dbt  
- Dashboard no Power BI  
- CI/CD com GitHub Actions  

---

## 👤 Autor

Vitor Gabriel Zanini  
Aspiring Analytics Engineer | SQL · dbt · BigQuery · Python
```

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Vitor%20Zanini-blue)](https://linkedin.com/in/vitorgabrielzanini)
[![GitHub](https://img.shields.io/badge/GitHub-vitorlubschinski-black)](https://github.com/vitorlubschinski)