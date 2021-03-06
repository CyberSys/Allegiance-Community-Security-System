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
--              This function is transcribed from CNormalDist.cs, line 219 "public double CDF(double x)
-- =============================================
--IF OBJECT_ID('dbo.AS_GetCDF', 'U') IS NOT NULL DROP FUNCTION [dbo].[AS_GetCDF];
CREATE FUNCTION [dbo].[AS_GetCDF] (@mean FLOAT, @variance FLOAT, @x FLOAT)
RETURNS FLOAT

AS
BEGIN
	DECLARE @I INT;
	DECLARE @Del FLOAT, @Temp FLOAT, @Z FLOAT, @Y FLOAT, @Min FLOAT;
	DECLARE @Arg DECIMAL(38,20), @Ccum DECIMAL(38,20), @Xden DECIMAL(38,20), @XNum DECIMAL(38,20), @Xsq DECIMAL(38,20), @Result DECIMAL(38,20)
	
	-- Class-level Variable Declarations (at top of CNormalDist.cs)
	DECLARE @MACHINE_EPSILON FLOAT;
		SET @MACHINE_EPSILON = 1.0e-12;

	DECLARE @Thrsh FLOAT;
		SET @Thrsh = 0.66291e0;

	DECLARE @Half FLOAT;
		SET @Half = 0.5e0;
	
	DECLARE @Sixten FLOAT;
		SET @Sixten = 1.60e0;
	
	DECLARE @SqrPi FLOAT;
		SET @SqrPi = 3.9894228040143267794e-1;

	DECLARE @Root32 FLOAT;
		SET @Root32 = 5.656854248e0;

	DECLARE @Sigma FLOAT;
		SET @Sigma = SQRT(@variance);

	-- Function-level Declarations (At top of CDF. Line 228)
	SET @Arg = (@x - @mean) / @Sigma;

	SET @Min = 4.94065645841247E-304;	--4.94065645841247E-324
	SET @Z = @Arg;
	SET @Y = ABS(@Z);
	
	IF (@Y <= @Thrsh)
	BEGIN
		-- Evaluate anorm for |X| <= 0.66291
		SET @Xsq = 0.0;
		IF (@Y > @MACHINE_EPSILON) SET @Xsq = @Z * @Z;
		
		SET @Xnum = @Xsq * (SELECT Value FROM AS_A WHERE EntryIndex = 4);
		SET @Xden = @Xsq;
		
		SET @I = 0;		-- Begin FOR loop in CNormalDist.cs line 242
		WHILE (@I < 3)
		BEGIN
			SET @Xnum = (@Xnum + (SELECT Value FROM AS_A WHERE EntryIndex = @I)) * @Xsq;
			SET @Xden = (@Xden + (SELECT Value FROM AS_B WHERE EntryIndex = @I)) * @Xsq;
			SET @I = @I + 1;
		END
		SET @Result = @Z * (@Xnum + (SELECT Value FROM AS_A WHERE EntryIndex = 3)) / (@Xden + (SELECT Value FROM AS_B WHERE EntryIndex = 3))
		SET @Temp = @Result;
		SET @Result = @Half + @Temp;
		SET @Ccum = @Half - @Temp;
	END
	ELSE	-- Evaluate anorm for 0.66291 <= |X| <= sqrt(32)
	BEGIN
		IF (@Y <= @Root32)		-- CNormalDist.cs Line 256
		BEGIN
			SET @Xnum = (SELECT Value FROM AS_C WHERE EntryIndex = 8) * @Y;
			SET @Xden = @Y;
			
			SET @I = 0;
			WHILE (@I < 7) -- FOR loop at Line 260
			BEGIN
				SET @Xnum = (@XNum + (SELECT Value FROM AS_C WHERE EntryIndex = @I)) * @Y;
				SET @Xden = (@XDen + (SELECT Value FROM AS_D WHERE EntryIndex = @I)) * @Y;
				
				SET @I = @I + 1;
			END
			SET @Result = (@Xnum + (SELECT Value FROM AS_C WHERE EntryIndex = 7)) / (@Xden + (SELECT Value FROM AS_D WHERE EntryIndex = 7))
			SET @Xsq = Floor(@Y * @Sixten) / @Sixten;
			SET @Del = (@Y - @Xsq) * (@Y + @Xsq);
			SET @Result = Exp(-1.0 * @Xsq * @Xsq * @Half) * Exp(-1.0 * @Del * @Half) * @Result;
			SET @Ccum = 1.0 - @Result;
			
			IF (@Z > 0.0)
			BEGIN
				SET @Temp = @Result;
				SET @Result = @Ccum;
				SET @Ccum = @Temp;
			END
		END
		ELSE	-- CNormalDist.cs Line 281
		BEGIN
			-- Evaluate anorm for |X| > sqrt(32)
			SET @Result = 0.0;
			SET @Xsq = 1.0 / (@Z * @Z)
			SET @Xnum = (SELECT Value FROM AS_P WHERE EntryIndex = 5) * @Xsq;
			SET @Xden = @Xsq;
			
			SET @I = 0;
			WHILE (@I < 4)
			BEGIN
				SET @Xnum = (@XNum + (SELECT Value FROM AS_P WHERE EntryIndex = @I)) * @Xsq;
				SET @Xden = (@XDen + (SELECT Value FROM AS_Q WHERE EntryIndex = @I)) * @Xsq;
				
				SET @I = @I + 1;
			END
			SET @Result = @Xsq * (@Xnum + (SELECT Value FROM AS_P WHERE EntryIndex = 4)) / (@Xden + (SELECT Value FROM AS_Q WHERE EntryIndex = 4));
			SET @Result = (@SqrPi - @Result) / @Y;
			SET @Xsq = Floor(@Z * @SixTen) / @SixTen;
			SET @Del = (@Z - @Xsq) * (@Z + @Xsq);
			SET @Result = Exp(-1.0 * @Xsq * @Xsq * @Half) * Exp(-1.0 * @Del * @Half) * @Result;
			SET @Ccum = 1.0 - @Result;
			IF (@Z > 0.0)
			BEGIN
				SET @Temp = @Result;
				SET @Result = @Ccum;
				SET @Ccum = @Temp;
			END
		END
	END
	
	-- Line 306
	IF (@Result < @Min) SET @Result = 0.0;
	IF (@Ccum < @Min) SET @Ccum = 0.0;

	RETURN CAST(@RESULT AS FLOAT);
END
