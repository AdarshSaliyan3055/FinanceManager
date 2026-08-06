CREATE TABLE [dbo].[notification_types] (
    [id]                     INT              IDENTITY (1, 1) NOT NULL,
    [guid]                   UNIQUEIDENTIFIER CONSTRAINT [df_notification_types_guid] DEFAULT (newsequentialid()) NOT NULL,
    [notification_type_name] NVARCHAR (100)   NOT NULL,
    [notification_type_code] NVARCHAR (50)    NOT NULL,
    [description]            NVARCHAR (500)   NULL,
    [priority]               INT              CONSTRAINT [df_notification_types_priority] DEFAULT ((1)) NOT NULL,
    [is_email_enabled]       BIT              CONSTRAINT [df_notification_types_email_enabled] DEFAULT ((0)) NOT NULL,
    [is_push_enabled]        BIT              CONSTRAINT [df_notification_types_push_enabled] DEFAULT ((1)) NOT NULL,
    [is_active]              BIT              CONSTRAINT [df_notification_types_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]             BIT              CONSTRAINT [df_notification_types_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]           DATETIME2 (7)    CONSTRAINT [df_notification_types_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]             INT              NULL,
    [updated_date]           DATETIME2 (7)    NULL,
    [updated_by]             INT              NULL,
    [row_version]            ROWVERSION       NOT NULL,
    CONSTRAINT [pk_notification_types] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_notification_types_code] UNIQUE NONCLUSTERED ([notification_type_code] ASC),
    CONSTRAINT [uq_notification_types_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_notification_types_active]
    ON [dbo].[notification_types]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notification_types_name]
    ON [dbo].[notification_types]([notification_type_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notification_types_code]
    ON [dbo].[notification_types]([notification_type_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_notification_types_guid]
    ON [dbo].[notification_types]([guid] ASC);

