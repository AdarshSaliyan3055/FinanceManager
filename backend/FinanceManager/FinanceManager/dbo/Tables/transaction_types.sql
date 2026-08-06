CREATE TABLE [dbo].[transaction_types] (
    [id]                    INT              IDENTITY (1, 1) NOT NULL,
    [guid]                  UNIQUEIDENTIFIER CONSTRAINT [df_transaction_types_guid] DEFAULT (newsequentialid()) NOT NULL,
    [transaction_type_name] NVARCHAR (100)   NOT NULL,
    [transaction_type_code] NVARCHAR (50)    NOT NULL,
    [description]           NVARCHAR (500)   NULL,
    [affects_balance]       BIT              CONSTRAINT [df_transaction_types_affects_balance] DEFAULT ((1)) NOT NULL,
    [is_credit]             BIT              CONSTRAINT [df_transaction_types_is_credit] DEFAULT ((0)) NOT NULL,
    [is_debit]              BIT              CONSTRAINT [df_transaction_types_is_debit] DEFAULT ((0)) NOT NULL,
    [is_active]             BIT              CONSTRAINT [df_transaction_types_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]            BIT              CONSTRAINT [df_transaction_types_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]          DATETIME2 (7)    CONSTRAINT [df_transaction_types_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]            INT              NULL,
    [updated_date]          DATETIME2 (7)    NULL,
    [updated_by]            INT              NULL,
    [row_version]           ROWVERSION       NOT NULL,
    CONSTRAINT [pk_transaction_types] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_transaction_types_code] UNIQUE NONCLUSTERED ([transaction_type_code] ASC),
    CONSTRAINT [uq_transaction_types_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_types_active]
    ON [dbo].[transaction_types]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_types_name]
    ON [dbo].[transaction_types]([transaction_type_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_types_code]
    ON [dbo].[transaction_types]([transaction_type_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_types_guid]
    ON [dbo].[transaction_types]([guid] ASC);

