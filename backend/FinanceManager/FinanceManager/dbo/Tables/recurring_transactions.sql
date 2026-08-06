CREATE TABLE [dbo].[recurring_transactions] (
    [id]                      INT              IDENTITY (1, 1) NOT NULL,
    [guid]                    UNIQUEIDENTIFIER CONSTRAINT [df_recurring_transactions_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]                 INT              NOT NULL,
    [account_id]              INT              NOT NULL,
    [category_id]             INT              NULL,
    [transaction_type_id]     INT              NOT NULL,
    [transaction_name]        NVARCHAR (200)   NOT NULL,
    [description]             NVARCHAR (500)   NULL,
    [amount]                  DECIMAL (18, 2)  NOT NULL,
    [frequency]               NVARCHAR (50)    NOT NULL,
    [start_date]              DATE             NOT NULL,
    [end_date]                DATE             NULL,
    [next_run_date]           DATE             NOT NULL,
    [last_run_date]           DATE             NULL,
    [occurrence_count]        INT              NULL,
    [max_occurrences]         INT              NULL,
    [auto_create_transaction] BIT              CONSTRAINT [df_recurring_transactions_auto_create] DEFAULT ((1)) NOT NULL,
    [status]                  NVARCHAR (50)    CONSTRAINT [df_recurring_transactions_status] DEFAULT ('ACTIVE') NOT NULL,
    [is_deleted]              BIT              CONSTRAINT [df_recurring_transactions_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]            DATETIME2 (7)    CONSTRAINT [df_recurring_transactions_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]              INT              NULL,
    [updated_date]            DATETIME2 (7)    NULL,
    [updated_by]              INT              NULL,
    [row_version]             ROWVERSION       NOT NULL,
    CONSTRAINT [pk_recurring_transactions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_recurring_transactions_account] FOREIGN KEY ([account_id]) REFERENCES [dbo].[accounts] ([id]),
    CONSTRAINT [fk_recurring_transactions_category] FOREIGN KEY ([category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [fk_recurring_transactions_type] FOREIGN KEY ([transaction_type_id]) REFERENCES [dbo].[transaction_types] ([id]),
    CONSTRAINT [fk_recurring_transactions_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_recurring_transactions_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_recurring_transactions_status]
    ON [dbo].[recurring_transactions]([status] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_recurring_transactions_next_run_date]
    ON [dbo].[recurring_transactions]([next_run_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_recurring_transactions_user_id]
    ON [dbo].[recurring_transactions]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_recurring_transactions_guid]
    ON [dbo].[recurring_transactions]([guid] ASC);

