USE [IFF]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Freitas, Aline
-- Create date: 2017-04-04
-- Description:	
-- =============================================

ALTER function [dbo].[return_role](@id_subcampo int)
    RETURNS varchar(4000) AS BEGIN
    declare @role varchar(4000)
    declare @tag varchar(200)
    declare @subcampo varchar(10)
    declare @slug_role varchar(4000)

    set @role = (select rs.VALOR from biblioteca.REGISTRO_SUBCAMPO rs where rs.ID_REGISTRO_SUBCAMPO= @id_subcampo+1)
    
    select @role=dbo.slugify(@role)
    set @tag= (select rt.tag from biblioteca.REGISTRO_TAG rt inner join
               biblioteca.REGISTRO_SUBCAMPO rs on rt.ID_REGISTRO_TAG = rs.IDFK_REGISTRO_TAG_DADO
               where (rs.ID_REGISTRO_SUBCAMPO=@id_subcampo))
    set @subcampo= (select rs.SUBCAMPO from biblioteca.REGISTRO_SUBCAMPO rs where rs.ID_REGISTRO_SUBCAMPO=@id_subcampo)
	return 
		CASE
			WHEN @tag = 100 and @subcampo='a' THEN 'autor'
			WHEN (@tag=700 or @tag=710) AND @subcampo='a' THEN @role
		END
END