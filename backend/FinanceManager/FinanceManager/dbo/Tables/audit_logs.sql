CREATE TABLE [dbo].[audit_logs] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_audit_logs_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]      INT              NULL,
    [action_type]  NVARCHAR (50)    NOT NULL,
    [table_name]   NVARCHAR (100)   NOT NULL,
    [record_id]    INT              NULL,
    [record_guid]  UNIQUEIDENTIFIER NULL,
    [old_values]   NVARCHAR (MAX)   NULL,
    [new_values]   NVARCHAR (MAX)   NULL,
    [description]  NVARCHAR (500)   NULL,
    [ip_address]   NVARCHAR (50)    NULL,
    [user_agent]   NVARCHAR (500)   NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_audit_logs_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_audit_logs] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_audit_logs_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_audit_logs_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_audit_logs_guid]
    ON [dbo].[audit_logs]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_audit_logs_created_date]
    ON [dbo].[audit_logs]([created_date] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_audit_logs_record_id]
    ON [dbo].[audit_logs]([record_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_audit_logs_table_name]
    ON [dbo].[audit_logs]([table_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_audit_logs_user_id]
    ON [dbo].[audit_logs]([user_id] ASC);

