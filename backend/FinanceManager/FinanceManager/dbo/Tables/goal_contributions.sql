CREATE TABLE [dbo].[goal_contributions] (
    [id]                INT              IDENTITY (1, 1) NOT NULL,
    [guid]              UNIQUEIDENTIFIER CONSTRAINT [df_goal_contributions_guid] DEFAULT (newsequentialid()) NOT NULL,
    [goal_id]           INT              NOT NULL,
    [account_id]        INT              NULL,
    [amount]            DECIMAL (18, 2)  NOT NULL,
    [contribution_date] DATE             CONSTRAINT [df_goal_contributions_date] DEFAULT (CONVERT([date],getutcdate())) NOT NULL,
    [contribution_type] NVARCHAR (50)    CONSTRAINT [df_goal_contributions_type] DEFAULT ('DEPOSIT') NOT NULL,
    [notes]             NVARCHAR (500)   NULL,
    [transaction_id]    INT              NULL,
    [is_deleted]        BIT              CONSTRAINT [df_goal_contributions_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]      DATETIME2 (7)    CONSTRAINT [df_goal_contributions_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]        INT              NULL,
    [updated_date]      DATETIME2 (7)    NULL,
    [updated_by]        INT              NULL,
    [row_version]       ROWVERSION       NOT NULL,
    CONSTRAINT [pk_goal_contributions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_goal_contributions_account] FOREIGN KEY ([account_id]) REFERENCES [dbo].[accounts] ([id]),
    CONSTRAINT [fk_goal_contributions_goal] FOREIGN KEY ([goal_id]) REFERENCES [dbo].[goals] ([id]),
    CONSTRAINT [fk_goal_contributions_transaction] FOREIGN KEY ([transaction_id]) REFERENCES [dbo].[transactions] ([id]),
    CONSTRAINT [uq_goal_contributions_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_goal_contributions_date]
    ON [dbo].[goal_contributions]([contribution_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goal_contributions_account_id]
    ON [dbo].[goal_contributions]([account_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goal_contributions_goal_id]
    ON [dbo].[goal_contributions]([goal_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goal_contributions_guid]
    ON [dbo].[goal_contributions]([guid] ASC);

