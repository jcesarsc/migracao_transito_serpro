/*
Script que gera as AITs que NAO SAO tipo NIC.
*/
use [Transito]
go

SELECT 
ait.TX_AIT_RENAINF as 'ait', 
convert(varchar(4), ait.CD_ENQUADRAMENTO) AS 'tipoInfracao', 
convert(varchar(1), ait.CD_DESDOBRAMENTO) AS 'desdobramento', 
dbo.strzero(cast(cast(ait.CD_RENAINF as bigint) as nvarchar(18)),11) AS 'codigoRenainf',
replace(convert(varchar, ait.DT_INFRACAO, 102),'.','') + replace(convert(varchar, ait.DT_INFRACAO, 108),':','') as 'dataCometimento', 
ISNULL(ait.OBS_INFRACAO,'') as 'observacoes',
null as 'equipamento',
null as 'afericao',
iif(convert(varchar(20), aa.MatriculaRadar) is null, convert(varchar(20), 29499), convert(varchar(20), aa.MatriculaRadar)) AS 'agente.matricula',
null as 'transporte',
null as 'imagens'
FROM [2465_02_AIT_txt] ait
LEFT JOIN [2465_01_AGENTE_AUTUADOR_txt] aa on aa.id_agente_autuador = ait.id_agente_autuador
WHERE SUBSTRING(ait.AIT, 1, 1)<>'N' 
AND ait.CD_ENQUADRAMENTO IS NOT NULL -- para nao trazer os registros que estao como "Rejeitado" no arquivo.
and ait.CD_RENAINF is not null 
and ait.TX_AIT_RENAINF in ('B001381481') -- filtro
GROUP BY ait.TX_AIT_RENAINF, ait.CD_ENQUADRAMENTO, ait.CD_DESDOBRAMENTO, ait.CD_RENAINF, ait.DT_INFRACAO, ait.OBS_INFRACAO, aa.MatriculaRadar
ORDER BY ait.TX_AIT_RENAINF 

FOR JSON path, root('autos'), INCLUDE_NULL_VALUES -- Para gerar o resultado da query em formato JSON. 
