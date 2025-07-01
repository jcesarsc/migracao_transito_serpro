/*
Cria a funçao STRZERO no SqlServer (Script de criação encontrado facilmente na internet).
*/
use [Transito]
go

DROP FUNCTION [dbo].[STRZERO]


CREATE FUNCTION [dbo].[STRZERO]
(
 -- Add the parameters for the function here
 @NUMERO bigint, @DIGITOS tinyint
)
RETURNS varchar(100)
AS
BEGIN
   RETURN REPLICATE('0',@DIGITOS-LEN(@NUMERO))+cast(@NUMERO as varchar(100));
END

-- select dbo.STRZERO(123,10) -- Teste