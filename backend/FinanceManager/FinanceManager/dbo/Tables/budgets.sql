CREATE TABLE [dbo].[budgets] (
    [id]               INT              IDENTITY (1, 1) NOT NULL,
    [guid]             UNIQUEIDENTIFIER CONSTRAINT [df_budgets_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]          INT              NOT NULL,
    [category_id]      INT              NOT NULL,
    [budget_name]      NVARCHAR (150)   NOT NULL,
    [budget_amount]    DECIMAL (18, 2)  NOT NULL,
    [budget_period]    NVARCHAR (50)    NOT NULL,
    [start_date]       DATE             NOT NULL,
    [end_date]         DATE             NULL,
    [alert_percentage] INT              CONSTRAINT [df_budgets_alert_percentage] DEFAULT ((80)) NOT NULL,
    [is_active]        BIT              CONSTRAINT [df_budgets_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]       BIT              CONSTRAINT [df_budgets_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]     DATETIME2 (7)    CONSTRAINT [df_budgets_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]       INT              NULL,
    [updated_date]     DATETIME2 (7)    NULL,
    [updated_by]       INT              NULL,
    [row_version]      ROWVERSION       NOT NULL,
    CONSTRAINT [pk_budgets] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_budgets_categories] FOREIGN KEY ([category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [fk_budgets_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_budgets_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_budgets_active]
    ON [dbo].[budgets]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budgets_dates]
    ON [dbo].[budgets]([start_date] ASC, [end_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budgets_category_id]
    ON [dbo].[budgets]([category_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budgets_user_id]
    ON [dbo].[budgets]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budgets_guid]
    ON [dbo].[budgets]([guid] ASC);

