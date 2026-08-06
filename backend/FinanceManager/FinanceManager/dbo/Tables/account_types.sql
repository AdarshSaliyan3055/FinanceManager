CREATE TABLE [dbo].[account_types] (
    [id]                INT              IDENTITY (1, 1) NOT NULL,
    [guid]              UNIQUEIDENTIFIER CONSTRAINT [df_account_types_guid] DEFAULT (newsequentialid()) NOT NULL,
    [account_type_name] NVARCHAR (100)   NOT NULL,
    [account_type_code] NVARCHAR (50)    NOT NULL,
    [description]       NVARCHAR (500)   NULL,
    [is_asset]          BIT              CONSTRAINT [df_account_types_is_asset] DEFAULT ((1)) NOT NULL,
    [is_liability]      BIT              CONSTRAINT [df_account_types_is_liability] DEFAULT ((0)) NOT NULL,
    [is_active]         BIT              CONSTRAINT [df_account_types_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]        BIT              CONSTRAINT [df_account_types_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]      DATETIME2 (7)    CONSTRAINT [df_account_types_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]        INT              NULL,
    [updated_date]      DATETIME2 (7)    NULL,
    [updated_by]        INT              NULL,
    [row_version]       ROWVERSION       NOT NULL,
    CONSTRAINT [pk_account_types] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_account_types_code] UNIQUE NONCLUSTERED ([account_type_code] ASC),
    CONSTRAINT [uq_account_types_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_account_types_active]
    ON [dbo].[account_types]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_account_types_name]
    ON [dbo].[account_types]([account_type_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_account_types_code]
    ON [dbo].[account_types]([account_type_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_account_types_guid]
    ON [dbo].[account_types]([guid] ASC);

