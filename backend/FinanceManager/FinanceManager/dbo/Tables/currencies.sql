CREATE TABLE [dbo].[currencies] (
    [id]              INT              IDENTITY (1, 1) NOT NULL,
    [guid]            UNIQUEIDENTIFIER CONSTRAINT [df_currencies_guid] DEFAULT (newsequentialid()) NOT NULL,
    [currency_name]   NVARCHAR (100)   NOT NULL,
    [currency_code]   NVARCHAR (10)    NOT NULL,
    [currency_symbol] NVARCHAR (10)    NULL,
    [decimal_places]  INT              CONSTRAINT [df_currencies_decimal_places] DEFAULT ((2)) NOT NULL,
    [country_id]      INT              NULL,
    [is_default]      BIT              CONSTRAINT [df_currencies_is_default] DEFAULT ((0)) NOT NULL,
    [is_active]       BIT              CONSTRAINT [df_currencies_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]      BIT              CONSTRAINT [df_currencies_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]    DATETIME2 (7)    CONSTRAINT [df_currencies_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]      INT              NULL,
    [updated_date]    DATETIME2 (7)    NULL,
    [updated_by]      INT              NULL,
    [row_version]     ROWVERSION       NOT NULL,
    CONSTRAINT [pk_currencies] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_currencies_country] FOREIGN KEY ([country_id]) REFERENCES [dbo].[countries] ([id]),
    CONSTRAINT [uq_currencies_code] UNIQUE NONCLUSTERED ([currency_code] ASC),
    CONSTRAINT [uq_currencies_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_currencies_country]
    ON [dbo].[currencies]([country_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_currencies_active]
    ON [dbo].[currencies]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_currencies_name]
    ON [dbo].[currencies]([currency_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_currencies_code]
    ON [dbo].[currencies]([currency_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_currencies_guid]
    ON [dbo].[currencies]([guid] ASC);

