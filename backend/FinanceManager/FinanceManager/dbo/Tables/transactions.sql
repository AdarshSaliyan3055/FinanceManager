CREATE TABLE [dbo].[transactions] (
    [id]                       INT              IDENTITY (1, 1) NOT NULL,
    [guid]                     UNIQUEIDENTIFIER CONSTRAINT [df_transactions_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]                  INT              NOT NULL,
    [account_id]               INT              NOT NULL,
    [category_id]              INT              NULL,
    [transaction_type_id]      INT              NOT NULL,
    [reference_transaction_id] INT              NULL,
    [transaction_number]       NVARCHAR (50)    NOT NULL,
    [transaction_title]        NVARCHAR (200)   NOT NULL,
    [description]              NVARCHAR (1000)  NULL,
    [amount]                   DECIMAL (18, 2)  NOT NULL,
    [transaction_date]         DATETIME2 (7)    NOT NULL,
    [notes]                    NVARCHAR (1000)  NULL,
    [location]                 NVARCHAR (250)   NULL,
    [merchant_name]            NVARCHAR (200)   NULL,
    [is_recurring]             BIT              CONSTRAINT [df_transactions_recurring] DEFAULT ((0)) NOT NULL,
    [is_transfer]              BIT              CONSTRAINT [df_transactions_transfer] DEFAULT ((0)) NOT NULL,
    [is_deleted]               BIT              CONSTRAINT [df_transactions_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]             DATETIME2 (7)    CONSTRAINT [df_transactions_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]               INT              NULL,
    [updated_date]             DATETIME2 (7)    NULL,
    [updated_by]               INT              NULL,
    [row_version]              ROWVERSION       NOT NULL,
    CONSTRAINT [pk_transactions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_transactions_accounts] FOREIGN KEY ([account_id]) REFERENCES [dbo].[accounts] ([id]),
    CONSTRAINT [fk_transactions_categories] FOREIGN KEY ([category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [fk_transactions_reference] FOREIGN KEY ([reference_transaction_id]) REFERENCES [dbo].[transactions] ([id]),
    CONSTRAINT [fk_transactions_transaction_types] FOREIGN KEY ([transaction_type_id]) REFERENCES [dbo].[transaction_types] ([id]),
    CONSTRAINT [fk_transactions_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_transactions_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_transactions_number] UNIQUE NONCLUSTERED ([transaction_number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_merchant]
    ON [dbo].[transactions]([merchant_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_date]
    ON [dbo].[transactions]([transaction_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_transaction_type_id]
    ON [dbo].[transactions]([transaction_type_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_category_id]
    ON [dbo].[transactions]([category_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_account_id]
    ON [dbo].[transactions]([account_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_user_id]
    ON [dbo].[transactions]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transactions_guid]
    ON [dbo].[transactions]([guid] ASC);

