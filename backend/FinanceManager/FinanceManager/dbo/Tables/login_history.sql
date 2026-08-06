CREATE TABLE [dbo].[login_history] (
    [id]              INT              IDENTITY (1, 1) NOT NULL,
    [guid]            UNIQUEIDENTIFIER CONSTRAINT [df_login_history_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]         INT              NULL,
    [email]           NVARCHAR (256)   NULL,
    [login_date]      DATETIME2 (7)    CONSTRAINT [df_login_history_login_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [logout_date]     DATETIME2 (7)    NULL,
    [login_status_id] INT              NOT NULL,
    [failure_reason]  NVARCHAR (500)   NULL,
    [ip_address]      NVARCHAR (50)    NULL,
    [device_name]     NVARCHAR (100)   NULL,
    [user_agent]      NVARCHAR (500)   NULL,
    [location]        NVARCHAR (200)   NULL,
    [created_date]    DATETIME2 (7)    CONSTRAINT [df_login_history_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]      INT              NULL,
    [updated_date]    DATETIME2 (7)    NULL,
    [updated_by]      INT              NULL,
    [row_version]     ROWVERSION       NOT NULL,
    CONSTRAINT [pk_login_history] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_login_history_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_login_history_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_login_history_guid]
    ON [dbo].[login_history]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_login_history_status]
    ON [dbo].[login_history]([login_status_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_login_history_login_date]
    ON [dbo].[login_history]([login_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_login_history_user_id]
    ON [dbo].[login_history]([user_id] ASC);

