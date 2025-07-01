# Migração Trânsito Serpro
## Repositório com as queries usadas para a migração dos autos de infrações (AIT) passados pela Prodesp para serem usados no sistema RADAR da Serpro.
- Primeiro foi feita a migração dos arquivos texto para um banco de dados local, utilizando o software ESF Database Migration Toolkit versão 8.2.07 transformando assim os arquivos em tabelas.
- Após os arquivos devidamente tranportados e conferidos, fica muito mais fácil consultar os dados em formato de banco/tabela, pois para isso podemos usar as queries normalmente.
- Fiz também uma alteração na tabela do agente autuador para que eu tenha o código do agente no relacionamento com a tabela de AITs (Como não eram muitos agentes, fiz o update um a um).

Site para onde os arquivos gerados devem ser enviados (Deve ter o usuário previamente cadastrado no sistema Radar, link abaixo):

https://migra-radar.serpro.gov.br/

Site do sistema Radar:

https://radar.serpro.gov.br/