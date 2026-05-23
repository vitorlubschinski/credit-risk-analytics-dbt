# 📊 Credit Risk Analytics Pipeline | dbt + BigQuery
### dbt + BigQuery |  Arquitetura em Camadas | Data Quality

![dbt](https://img.shields.io/badge/dbt-Analytics%20Engineering-orange)
![BigQuery](https://img.shields.io/badge/Google-BigQuery-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)

---

## 💼 Contexto de Negócio

Dados incorretos em sistemas de crédito causam prejuízos
reais — aprovações indevidas ou recusas injustas impactam
diretamente o negócio e o cliente final.

Este projeto simula o pipeline de dados de uma fintech,
garantindo que apenas dados confiáveis e bem modelados
alimentem decisões de crédito.

---

## 🏗️ Arquitetura em Camadas

Raw → Staging → Intermediate → Marts (Analytics Pipeline)

- **Raw:** dados brutos ingeridos do Kaggle para o BigQuery  
- **Staging:** limpeza, padronização e tipagem dos dados  
- **Intermediate:** regras de negócio e features de risco  
- **Marts:** tabelas finais para consumo analítico e dashboards  

---

## 📊 Dataset

**Give Me Some Credit — Kaggle**
https://www.kaggle.com/datasets/brycecf/give-me-some-credit-dataset

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| customer_id | INT | ID sequencial do cliente |
| is_default_2y | INT | Inadimplência nos últimos 2 anos (0/1) |
| credit_utilization | FLOAT | Utilização do limite de crédito rotativo |
| customer_age | INT | Idade do cliente |
| dpd_30_59 | INT | Atrasos entre 30 e 59 dias |
| debt_ratio | FLOAT | Relação entre dívida e renda mensal |
| monthly_income | FLOAT | Renda mensal (valores inválidos → NULL) |
| open_credit_lines | INT | Linhas de crédito e empréstimos abertos |
| dpd_90_plus | INT | Atrasos acima de 90 dias |
| real_estate_loans | INT | Empréstimos imobiliários abertos |
| dpd_60_89 | INT | Atrasos entre 60 e 89 dias |
| num_dependents | INT | Número de dependentes |
| is_suspicious | BOOLEAN | Flag is_suspicious para registros inconsistentes (regras de qualidade de dados) |

---

## ⚙️ Stack

- **dbt Core** — transformação e modelagem de dados (analytics engineering)
- **Google BigQuery** — data warehouse
- **SQL** — linguagem principal dos modelos
- **Python** — ambiente virtual e automação
- **Git** — versionamento de código

---

## 📁 Estrutura do Projeto

```
credit-risk-dbt/
├── models/
│   ├── staging/
│   │   └── stg_credit.sql        ✅ concluído
│   ├── intermediate/              🔄 em construção
│   └── marts/                     🔄 em construção
├── tests/                         🔄 em construção
├── macros/                        🔄 em construção
├── dbt_project.yml
└── README.md
```

---

## 🧪 Qualidade dos Dados

Validações aplicadas via dbt test:

- `not_null` — campos obrigatórios
- `unique` — IDs únicos de clientes
- `accepted_values` — inadimplência apenas 0 ou 1
- `SAFE_CAST` — monthly_income convertido com
  tratamento de valores inválidos
- Testes customizados de regras de negócio

---

## 🔄 Modelos dbt

### Staging
**`stg_credit.sql`**
- Renomeação e padronização das colunas do raw
- Conversão de tipos — `monthly_income` de STRING
  para FLOAT com `SAFE_CAST`
- Geração de `customer_id` sequencial via
  `ROW_NUMBER()`
- Flag `is_suspicious` para registros inconsistentes
  (idade fora do intervalo 18-100 ou renda negativa)

### Intermediate *(em construção)*
- Classificação de perfil de risco (ALTO/MEDIO/BAIXO)
- Score comportamental baseado em histórico de atrasos
- Segmentação por faixa de renda

### Marts *(em construção)*
- Taxa de inadimplência por perfil de risco
- Segmentação de clientes para consumo analítico
- KPIs prontos para Power BI

---

## 🚀 Como Executar

**1. Clone o repositório**
```bash
git clone https://github.com/vitorlubschinski/credit-risk-analytics-dbt.git
cd credit-risk-analytics-dbt
```

**2. Ative o ambiente virtual**
```bash
# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate
```

**3. Instale as dependências**
```bash
pip install dbt-bigquery
```

**4. Configure o profiles.yml**
> ⚠️ O arquivo `profiles.yml` não está versionado
> por conter credenciais. Crie localmente:

```yaml
credit_risk:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: [seu_projeto_bigquery]
      dataset: dbt_dev
      threads: 4
```

**5. Execute o projeto**
```bash
dbt run
dbt test
```

---

## 📈 Próximos Passos

- [ ] Modelos intermediate com classificação de risco
- [ ] Modelos marts para consumo analítico
- [ ] Testes customizados de Data Quality
- [ ] Macros reutilizáveis para regras de negócio
- [ ] Dashboard Power BI conectado ao BigQuery
- [ ] Automação via GitHub Actions
- [ ] Lineage graph documentado

---

## 👤 Autor

**Vitor Gabriel Zanini**
Aspiring Analytics Engineer | SQL · dbt · BigQuery · Python

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Vitor%20Zanini-blue)](https://linkedin.com/in/vitorgabrielzanini)
[![GitHub](https://img.shields.io/badge/GitHub-vitorlubschinski-black)](https://github.com/vitorlubschinski)