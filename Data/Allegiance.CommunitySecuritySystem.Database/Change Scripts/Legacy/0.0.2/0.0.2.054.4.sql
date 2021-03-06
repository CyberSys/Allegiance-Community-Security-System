USE CSSStats
GO 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye
-- Create date: August 31, 2008
-- Description:	This file is transcribed by Tigereye from the AllegSkill implementation written by Sgt_Baker. 
--              This function is transcribed from CNormalDist.cs, line 201 "public double PDF(double x)
-- =============================================
CREATE FUNCTION [dbo].AS_GetPDF (@mean FLOAT, @variance FLOAT, @x FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Y FLOAT;
		SET @Y = @x - @mean;

	DECLARE @Sigma FLOAT;
		SET @Sigma = SQRT(@variance);

	DECLARE @OneOverSigma FLOAT;
		SET @OneOverSigma = (1.0 / @Sigma);
	
	DECLARE @OneOverRoot2Pi FLOAT;
		SET @OneOverRoot2Pi = 1.0 / SQRT(2.0 * PI());

	DECLARE @C FLOAT;
		SET @C = @OneOverSigma * @OneOverRoot2Pi;

	DECLARE @XMinusMuSqr FLOAT;
		SET @XMinusMuSqr = @Y * @Y;

	DECLARE @PDF FLOAT;
		SET @PDF = @C * EXP(-0.5 * @XMinusMuSqr * (@OneOverSigma * @OneOverSigma));
	
	RETURN @PDF
END
