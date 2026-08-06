CREATE TABLE [dbo].[user_roles] (
    [id]             INT              IDENTITY (1, 1) NOT NULL,
    [guid]           UNIQUEIDENTIFIER CONSTRAINT [df_user_roles_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]        INT              NOT NULL,
    [role_id]        INT              NOT NULL,
    [is_primary]     BIT              CONSTRAINT [df_user_roles_is_primary] DEFAULT ((0)) NOT NULL,
    [effective_from] DATETIME2 (7)    CONSTRAINT [df_user_roles_effective_from] DEFAULT (sysutcdatetime()) NOT NULL,
    [effective_to]   DATETIME2 (7)    NULL,
    [is_active]      BIT              CONSTRAINT [df_user_roles_active] DEFAULT ((1)) NOT NULL,
    [created_date]   DATETIME2 (7)    CONSTRAINT [df_user_roles_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]     INT              NULL,
    [updated_date]   DATETIME2 (7)    NULL,
    [updated_by]     INT              NULL,
    [row_version]    ROWVERSION       NOT NULL,
    CONSTRAINT [pk_user_roles] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_user_roles_roles] FOREIGN KEY ([role_id]) REFERENCES [dbo].[roles] ([id]),
    CONSTRAINT [fk_user_roles_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_user_roles] UNIQUE NONCLUSTERED ([user_id] ASC, [role_id] ASC),
    CONSTRAINT [uq_user_roles_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_user_roles_guid]
    ON [dbo].[user_roles]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_roles_active]
    ON [dbo].[user_roles]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_roles_role]
    ON [dbo].[user_roles]([role_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_roles_user]
    ON [dbo].[user_roles]([user_id] ASC);

