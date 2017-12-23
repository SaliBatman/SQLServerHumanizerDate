
/****** Object:  UserDefinedFunction [dbo].[Humanizer]    Script Date: 12/23/2017 9:16:58 AM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
--=============================================
--Author:		SaliBatman
--Create date: 1396/10/02
--Description:	مثل آدم نشون دادن تاریخ
--=============================================
CREATE FUNCTION [dbo].[Humanizer]
(
    --Add the parameters for the function here
    @dt DATETIME,
    @isDetail BIT = 0,
    @culture VARCHAR(10) = 'fa-IR'
)
RETURNS NVARCHAR(256)
AS
BEGIN
    --Declare the return variable here
    DECLARE @Result NVARCHAR(256);
    SET @Result = '';


    DECLARE @getmm INT;
    DECLARE @getdd INT;
    DECLARE @gethh INT;
    DECLARE @getmin INT;
    DECLARE @dtstart DATETIME = @dt;
    DECLARE @dtEndDate DATETIME = GETDATE();
    DECLARE @yy INT;
    DECLARE @mm INT;
    DECLARE @dd INT;
    DECLARE @hh INT;
    IF (@culture = 'fa-IR')
    BEGIN
        IF (@dtstart < @dtEndDate)
        BEGIN
            SET @yy = DATEDIFF(yy, @dtstart, @dtEndDate);
            SET @mm = DATEDIFF(mm, @dtstart, @dtEndDate);
            SET @dd = DATEDIFF(dd, @dtstart, @dtEndDate);
            SET @hh = DATEDIFF(HH, @dtstart, @dtEndDate);
            SET @getmm = ABS(DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate));
            SET @getdd
                = ABS(DATEDIFF(
                                  dd,
                                  DATEADD(
                                             mm,
                                             DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate),
                                             DATEADD(yy, @yy, @dtstart)
                                         ),
                                  @dtEndDate
                              )
                     );
            SET @gethh = ABS(DATEPART(HOUR, @dtEndDate) - DATEPART(HOUR, @dtstart));
            SET @getmin = ABS(DATEPART(MINUTE, @dtEndDate) - DATEPART(MINUTE, @dtstart));
            IF (@isDetail = 1)
            BEGIN
                IF (@yy <> 0)
                    SET @Result = CONVERT(VARCHAR(10), @yy) + ' ' + N'سال';

                IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';
            END;

            ELSE
            BEGIN
                IF (@yy <> 0)
                    SET @Result = N'سال' + ' ' + CONVERT(VARCHAR(10), @yy);


                ELSE IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                ELSE IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                ELSE IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                ELSE IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';

            END;




            --set @Result = (select Convert(varchar(10),@yy) + N'سال' + Convert(varchar(10),@getmm) + N'ماه'  + Convert(varchar(10),@getdd) + N'روز'  + Convert(varchar(10),@gethh) + N'ساعت'  + Convert(varchar(10),@getmm) + N'دقیقه')

            RETURN @Result + ' ' + N'پیش' COLLATE Persian_100_CI_AS;
        END;
        ELSE
        BEGIN
            SET @yy = ABS(DATEDIFF(yy, @dtstart, @dtEndDate));
            SET @mm = ABS(DATEDIFF(mm, @dtstart, @dtEndDate));
            SET @dd = ABS(DATEDIFF(dd, @dtstart, @dtEndDate));
            SET @hh = ABS(DATEDIFF(HH, @dtstart, @dtEndDate));

            SET @getmm = ABS(DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate));
            SET @getdd
                = ABS(DATEDIFF(
                                  dd,
                                  DATEADD(
                                             mm,
                                             DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate),
                                             DATEADD(yy, @yy, @dtstart)
                                         ),
                                  @dtEndDate
                              )
                     );
            SET @gethh = ABS(DATEPART(HOUR, @dtEndDate) - DATEPART(HOUR, @dtstart));
            SET @getmin = ABS(DATEPART(MINUTE, @dtEndDate) - DATEPART(MINUTE, @dtstart));
            IF (@isDetail = 1)
            BEGIN
                IF (@yy <> 0)
                    SET @Result = CONVERT(VARCHAR(10), @yy) + ' ' + N'سال';

                IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';
            END;

            ELSE
            BEGIN
                IF (@yy <> 0)
                    SET @Result = N'سال' + ' ' + CONVERT(VARCHAR(10), @yy);


                ELSE IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                ELSE IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                ELSE IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                ELSE IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';

            END;




            --set @Result = (select Convert(varchar(10),@yy) + N'سال' + Convert(varchar(10),@getmm) + N'ماه'  + Convert(varchar(10),@getdd) + N'روز'  + Convert(varchar(10),@gethh) + N'ساعت'  + Convert(varchar(10),@getmm) + N'دقیقه')

            RETURN @Result + ' ' + N'بعد' COLLATE Persian_100_CI_AS;
        END;

    END;
    ELSE IF (@culture = 'en')
    BEGIN
        IF (@dtstart < @dtEndDate)
        BEGIN
            SET @yy = DATEDIFF(yy, @dtstart, @dtEndDate);
            SET @mm = DATEDIFF(mm, @dtstart, @dtEndDate);
            SET @dd = DATEDIFF(dd, @dtstart, @dtEndDate);
            SET @hh = DATEDIFF(HH, @dtstart, @dtEndDate);
            SET @getmm = ABS(DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate));
            SET @getdd
                = ABS(DATEDIFF(
                                  dd,
                                  DATEADD(
                                             mm,
                                             DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate),
                                             DATEADD(yy, @yy, @dtstart)
                                         ),
                                  @dtEndDate
                              )
                     );
            SET @gethh = ABS(DATEPART(HOUR, @dtEndDate) - DATEPART(HOUR, @dtstart));
            SET @getmin = ABS(DATEPART(MINUTE, @dtEndDate) - DATEPART(MINUTE, @dtstart));
            IF (@isDetail = 1)
            BEGIN
                IF (@yy <> 0)
                    SET @Result = CONVERT(VARCHAR(10), @yy) + ' ' + N'سال';

                IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';
            END;

            ELSE
            BEGIN
                IF (@yy <> 0)
                    SET @Result = N'سال' + ' ' + CONVERT(VARCHAR(10), @yy);


                ELSE IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'ماه' + ' ';
                ELSE IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'روز' + ' ';

                ELSE IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'ساعت' + ' ';
                ELSE IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'دقیقه' + ' ';

            END;




            --set @Result = (select Convert(varchar(10),@yy) + N'سال' + Convert(varchar(10),@getmm) + N'ماه'  + Convert(varchar(10),@getdd) + N'روز'  + Convert(varchar(10),@gethh) + N'ساعت'  + Convert(varchar(10),@getmm) + N'دقیقه')

            RETURN @Result + ' ' + N'ago' COLLATE Persian_100_CI_AS;
        END;
        ELSE
        BEGIN
            SET @yy = ABS(DATEDIFF(yy, @dtstart, @dtEndDate));
            SET @mm = ABS(DATEDIFF(mm, @dtstart, @dtEndDate));
            SET @dd = ABS(DATEDIFF(dd, @dtstart, @dtEndDate));
            SET @hh = ABS(DATEDIFF(HH, @dtstart, @dtEndDate));

            SET @getmm = ABS(DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate));
            SET @getdd
                = ABS(DATEDIFF(
                                  dd,
                                  DATEADD(
                                             mm,
                                             DATEDIFF(mm, DATEADD(yy, @yy, @dtstart), @dtEndDate),
                                             DATEADD(yy, @yy, @dtstart)
                                         ),
                                  @dtEndDate
                              )
                     );
            SET @gethh = ABS(DATEPART(HOUR, @dtEndDate) - DATEPART(HOUR, @dtstart));
            SET @getmin = ABS(DATEPART(MINUTE, @dtEndDate) - DATEPART(MINUTE, @dtstart));
            IF (@isDetail = 1)
            BEGIN
                IF (@yy <> 0)
                    SET @Result = CONVERT(VARCHAR(10), @yy) + ' ' + N'year';

                IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'month' + ' ';
                IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'day' + ' ';

                IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'hour' + ' ';
                IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'min' + ' ';
            END;

            ELSE
            BEGIN
                IF (@yy <> 0)
                    SET @Result = N'year' + ' ' + CONVERT(VARCHAR(10), @yy);


                ELSE IF (@mm <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmm) + ' ' + N'month' + ' ';
                ELSE IF (@dd <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getdd) + ' ' + N'day' + ' ';

                ELSE IF (@hh <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @gethh) + ' ' + N'hour' + ' ';
                ELSE IF (@getmin <> 0)
                    SET @Result = @Result + CONVERT(VARCHAR(10), @getmin) + ' ' + N'min' + ' ';

            END;




            --set @Result = (select Convert(varchar(10),@yy) + N'سال' + Convert(varchar(10),@getmm) + N'ماه'  + Convert(varchar(10),@getdd) + N'روز'  + Convert(varchar(10),@gethh) + N'ساعت'  + Convert(varchar(10),@getmm) + N'دقیقه')

            RETURN @Result + ' ' + N'later';
        END;

    END;



    RETURN '';


END;
