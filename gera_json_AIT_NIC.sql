/*
Script que gera as AITs tipo NIC (Ait tipo NIC sao sempre geradas a partir uma Ait previamente existente)
*/
use [Transito]
go

SELECT
ait.TX_AIT_RENAINF as 'ait', 
convert(varchar(4), ait.CD_ENQUADRAMENTO) AS 'tipoInfracao', 
convert(varchar(1), ait.CD_DESDOBRAMENTO) AS 'desdobramento', 
dbo.strzero(cast(cast(ait.CD_RENAINF as bigint) as nvarchar(18)),11) as 'codigoRenainf',
replace(convert(varchar, ait.DT_INFRACAO, 102),'.','') + replace(convert(varchar, ait.DT_INFRACAO, 108),':','') as 'dataCometimento', 
ISNULL(ait.OBS_INFRACAO,'') as 'observacoes',

-- nic
(select aitx.TX_AIT_RENAINF from [2465_02_AIT_txt] aitx where aitx.ID_AIT = nic.ID_AIT_ORIGEM) AS 'nic.ait',
(select convert(varchar(4), aitx.CD_ENQUADRAMENTO) from [2465_02_AIT_txt] aitx where aitx.ID_AIT = nic.ID_AIT_ORIGEM) AS 'nic.tipoInfracao',
(select convert(varchar(1), aitx.CD_DESDOBRAMENTO) from [2465_02_AIT_txt] aitx where aitx.ID_AIT = nic.ID_AIT_ORIGEM) AS 'nic.desdobramento',
(select dbo.strzero(cast(cast(aitx.CD_RENAINF as bigint) as nvarchar(18)),11) from [2465_02_AIT_txt] aitx where aitx.ID_AIT = nic.ID_AIT_ORIGEM) AS 'nic.codigoRenainf',

null as 'equipamento',
null as 'afericao',
-- agente
CASE 
	WHEN ait.ID_AGENTE_AUTUADOR is not null then iif(convert(varchar(20), aa.MatriculaRadar) is null, convert(varchar(20),'29499'), convert(varchar(20), aa.MatriculaRadar))
	ELSE ISNULL((select convert(varchar(20), aax.MatriculaRadar) from [2465_02_AIT_txt] aitx 
	JOIN [2465_01_AGENTE_AUTUADOR_txt] aax on aax.id_agente_autuador = aitx.id_agente_autuador where aitx.ID_AIT = nic.ID_AIT_ORIGEM),'29499')
END AS 'agente.matricula',

null as 'transporte', -- transporte
null as 'imagens' -- imagens

FROM [2465_02_AIT_txt] ait
INNER JOIN [2465_AIT_NIC_txt] nic ON nic.ID_AIT = ait.ID_AIT
LEFT JOIN [2465_01_AGENTE_AUTUADOR_txt] aa on aa.id_agente_autuador = ait.id_agente_autuador
WHERE SUBSTRING(ait.AIT, 1, 1)='N'
and ait.TX_AIT_RENAINF in ('N000024071') -- filtro
and ait.CD_RENAINF is not null 
GROUP BY ait.TX_AIT_RENAINF, ait.CD_ENQUADRAMENTO, ait.CD_DESDOBRAMENTO, ait.CD_RENAINF, ait.DT_INFRACAO, ait.OBS_INFRACAO, nic.ID_AIT_ORIGEM , nic.ID_AIT, aa.MatriculaRadar, ait.ID_AGENTE_AUTUADOR
ORDER BY ait.DT_INFRACAO

 FOR JSON path, root('autos'), INCLUDE_NULL_VALUES -- Para gerar o resultado da query em formato JSON. 
