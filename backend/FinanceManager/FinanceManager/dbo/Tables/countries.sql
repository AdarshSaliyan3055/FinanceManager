CREATE TABLE [dbo].[countries] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_countries_guid] DEFAULT (newsequentialid()) NOT NULL,
    [country_name] NVARCHAR (150)   NOT NULL,
    [country_code] NVARCHAR (10)    NOT NULL,
    [iso_code_2]   NVARCHAR (2)     NOT NULL,
    [iso_code_3]   NVARCHAR (3)     NULL,
    [phone_code]   NVARCHAR (20)    NULL,
    [currency_id]  INT              NULL,
    [is_active]    BIT              CONSTRAINT [df_countries_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]   BIT              CONSTRAINT [df_countries_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_countries_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_countries] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_countries_currency] FOREIGN KEY ([currency_id]) REFERENCES [dbo].[currencies] ([id]),
    CONSTRAINT [uq_countries_code] UNIQUE NONCLUSTERED ([country_code] ASC),
    CONSTRAINT [uq_countries_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_countries_iso2] UNIQUE NONCLUSTERED ([iso_code_2] ASC),
    CONSTRAINT [uq_countries_iso3] UNIQUE NONCLUSTERED ([iso_code_3] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_countries_active]
    ON [dbo].[countries]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_countries_iso2]
    ON [dbo].[countries]([iso_code_2] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_countries_name]
    ON [dbo].[countries]([country_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_countries_guid]
    ON [dbo].[countries]([guid] ASC);

