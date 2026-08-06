CREATE TABLE [dbo].[notifications] (
    [id]                   INT              IDENTITY (1, 1) NOT NULL,
    [guid]                 UNIQUEIDENTIFIER CONSTRAINT [df_notifications_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]              INT              NOT NULL,
    [notification_type_id] INT              NOT NULL,
    [title]                NVARCHAR (250)   NOT NULL,
    [message]              NVARCHAR (1000)  NOT NULL,
    [reference_type]       NVARCHAR (100)   NULL,
    [reference_id]         INT              NULL,
    [priority]             NVARCHAR (50)    CONSTRAINT [df_notifications_priority] DEFAULT ('NORMAL') NOT NULL,
    [is_read]              BIT              CONSTRAINT [df_notifications_is_read] DEFAULT ((0)) NOT NULL,
    [read_date]            DATETIME2 (7)    NULL,
    [sent_date]            DATETIME2 (7)    NULL,
    [expiry_date]          DATETIME2 (7)    NULL,
    [created_date]         DATETIME2 (7)    CONSTRAINT [df_notifications_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]           INT              NULL,
    [updated_date]         DATETIME2 (7)    NULL,
    [updated_by]           INT              NULL,
    [is_deleted]           BIT              CONSTRAINT [df_notifications_deleted] DEFAULT ((0)) NOT NULL,
    [row_version]          ROWVERSION       NOT NULL,
    CONSTRAINT [pk_notifications] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_notifications_type] FOREIGN KEY ([notification_type_id]) REFERENCES [dbo].[notification_types] ([id]),
    CONSTRAINT [fk_notifications_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_notifications_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_notifications_type_id]
    ON [dbo].[notifications]([notification_type_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notifications_created_date]
    ON [dbo].[notifications]([created_date] DESC);


GO
CREATE NONCLUSTERED INDEX [ix_notifications_is_read]
    ON [dbo].[notifications]([is_read] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notifications_user_id]
    ON [dbo].[notifications]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notifications_guid]
    ON [dbo].[notifications]([guid] ASC);

