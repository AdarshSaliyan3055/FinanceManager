CREATE TABLE [dbo].[budget_history] (
    [id]              INT              IDENTITY (1, 1) NOT NULL,
    [guid]            UNIQUEIDENTIFIER CONSTRAINT [df_budget_history_guid] DEFAULT (newsequentialid()) NOT NULL,
    [budget_id]       INT              NOT NULL,
    [old_amount]      DECIMAL (18, 2)  NULL,
    [new_amount]      DECIMAL (18, 2)  NOT NULL,
    [old_category_id] INT              NULL,
    [new_category_id] INT              NULL,
    [old_start_date]  DATE             NULL,
    [new_start_date]  DATE             NULL,
    [old_end_date]    DATE             NULL,
    [new_end_date]    DATE             NULL,
    [change_type]     NVARCHAR (50)    NOT NULL,
    [change_reason]   NVARCHAR (500)   NULL,
    [changed_by]      INT              NULL,
    [changed_date]    DATETIME2 (7)    CONSTRAINT [df_budget_history_changed_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [is_deleted]      BIT              CONSTRAINT [df_budget_history_deleted] DEFAULT ((0)) NOT NULL,
    [row_version]     ROWVERSION       NOT NULL,
    CONSTRAINT [pk_budget_history] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_budget_history_budget] FOREIGN KEY ([budget_id]) REFERENCES [dbo].[budgets] ([id]),
    CONSTRAINT [fk_budget_history_new_category] FOREIGN KEY ([new_category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [fk_budget_history_old_category] FOREIGN KEY ([old_category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [uq_budget_history_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_budget_history_changed_by]
    ON [dbo].[budget_history]([changed_by] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budget_history_changed_date]
    ON [dbo].[budget_history]([changed_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budget_history_budget_id]
    ON [dbo].[budget_history]([budget_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_budget_history_guid]
    ON [dbo].[budget_history]([guid] ASC);

