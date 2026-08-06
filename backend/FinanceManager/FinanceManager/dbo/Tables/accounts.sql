CREATE TABLE [dbo].[accounts] (
    [id]                 INT              IDENTITY (1, 1) NOT NULL,
    [guid]               UNIQUEIDENTIFIER CONSTRAINT [df_accounts_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]            INT              NOT NULL,
    [account_type_id]    INT              NOT NULL,
    [currency_id]        INT              NOT NULL,
    [account_name]       NVARCHAR (150)   NOT NULL,
    [account_number]     NVARCHAR (100)   NULL,
    [description]        NVARCHAR (500)   NULL,
    [opening_balance]    DECIMAL (18, 2)  CONSTRAINT [df_accounts_opening_balance] DEFAULT ((0)) NOT NULL,
    [current_balance]    DECIMAL (18, 2)  CONSTRAINT [df_accounts_current_balance] DEFAULT ((0)) NOT NULL,
    [credit_limit]       DECIMAL (18, 2)  NULL,
    [is_default_account] BIT              CONSTRAINT [df_accounts_default] DEFAULT ((0)) NOT NULL,
    [is_active]          BIT              CONSTRAINT [df_accounts_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]         BIT              CONSTRAINT [df_accounts_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]       DATETIME2 (7)    CONSTRAINT [df_accounts_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]         INT              NULL,
    [updated_date]       DATETIME2 (7)    NULL,
    [updated_by]         INT              NULL,
    [row_version]        ROWVERSION       NOT NULL,
    CONSTRAINT [pk_accounts] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_accounts_account_types] FOREIGN KEY ([account_type_id]) REFERENCES [dbo].[account_types] ([id]),
    CONSTRAINT [fk_accounts_currency] FOREIGN KEY ([currency_id]) REFERENCES [dbo].[currencies] ([id]),
    CONSTRAINT [fk_accounts_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_accounts_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_accounts_active]
    ON [dbo].[accounts]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_accounts_currency_id]
    ON [dbo].[accounts]([currency_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_accounts_account_type_id]
    ON [dbo].[accounts]([account_type_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_accounts_user_id]
    ON [dbo].[accounts]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_accounts_guid]
    ON [dbo].[accounts]([guid] ASC);

