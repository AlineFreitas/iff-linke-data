USE [IFF]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
			-- slugify
-- Author:		Foller, Antonin; http://www.motobit.com/ 
-- Modifier:    Freitas, Aline
-- Modifictaion date: 2017-04-04
-- Description:
--		- converts diacritics (Ěščřžýáíé) to ascii lower (escrzyaie)
--		- removes anything else than [a-z0-9 _]
--		- sets the output separator '_'
-- =============================================


ALTER function [dbo].[slugify](@string varchar(4000))
    RETURNS varchar(4000) AS BEGIN
    declare @slug varchar(4000)

    --convert to ASCII
    set @slug = lower(@string COLLATE SQL_Latin1_General_CP1251_CS_AS)

    declare @pi int
    --Since T-SQL have no regex, use patindex, MS .. :-)
    set @pi = patindex('%[^a-z0-9 -]%',@slug)
    while @pi>0 begin
        set @slug = replace(@slug, substring(@slug,@pi,1), '')
        --set @slug = left(@slug,@pi-1) + substring(@slug,@pi+1,8000)
        set @pi = patindex('%[^a-z0-9 -]%',@slug)
    end

    set @slug = ltrim(rtrim(@slug))

    -- replace space to underscore
    set @slug = replace(@slug, ' ', '_')

    -- remove hyphen
    set @slug = replace(@slug, '-', '')

    -- transform coautor into autor
    set @slug = REPLACE(@slug, 'coautor', 'autor')

    return (@slug)
END