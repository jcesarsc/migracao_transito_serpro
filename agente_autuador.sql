/*
Script usado para criar o campo MatriculaRadar que sera usado no relacionamento com a tabela de AITs e para pegar o codigo do agente.
*/
use [Transito]
go

ALTER TABLE [2465_01_AGENTE_AUTUADOR_txt] ADD MatriculaRadar VARCHAR(12) NULL
go

UPDATE [2465_01_AGENTE_AUTUADOR_txt] SET MatriculaRadar = '12345' WHERE CPF = '123456789-99'
