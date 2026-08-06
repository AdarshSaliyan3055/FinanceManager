CREATE TABLE [dbo].[goals] (
    [id]             INT              IDENTITY (1, 1) NOT NULL,
    [guid]           UNIQUEIDENTIFIER CONSTRAINT [df_goals_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]        INT              NOT NULL,
    [goal_name]      NVARCHAR (150)   NOT NULL,
    [description]    NVARCHAR (500)   NULL,
    [target_amount]  DECIMAL (18, 2)  NOT NULL,
    [current_amount] DECIMAL (18, 2)  CONSTRAINT [df_goals_current_amount] DEFAULT ((0)) NOT NULL,
    [target_date]    DATE             NULL,
    [priority]       NVARCHAR (50)    NULL,
    [status]         NVARCHAR (50)    CONSTRAINT [df_goals_status] DEFAULT ('ACTIVE') NOT NULL,
    [is_completed]   BIT              CONSTRAINT [df_goals_completed] DEFAULT ((0)) NOT NULL,
    [completed_date] DATE             NULL,
    [is_deleted]     BIT              CONSTRAINT [df_goals_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]   DATETIME2 (7)    CONSTRAINT [df_goals_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]     INT              NULL,
    [updated_date]   DATETIME2 (7)    NULL,
    [updated_by]     INT              NULL,
    [row_version]    ROWVERSION       NOT NULL,
    CONSTRAINT [pk_goals] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_goals_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_goals_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_goals_target_date]
    ON [dbo].[goals]([target_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goals_status]
    ON [dbo].[goals]([status] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goals_user_id]
    ON [dbo].[goals]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_goals_guid]
    ON [dbo].[goals]([guid] ASC);

