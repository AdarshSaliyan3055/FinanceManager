CREATE TABLE [dbo].[role_permissions] (
    [id]            INT              IDENTITY (1, 1) NOT NULL,
    [guid]          UNIQUEIDENTIFIER CONSTRAINT [df_role_permissions_guid] DEFAULT (newsequentialid()) NOT NULL,
    [role_id]       INT              NOT NULL,
    [permission_id] INT              NOT NULL,
    [is_allowed]    BIT              CONSTRAINT [df_role_permissions_is_allowed] DEFAULT ((1)) NOT NULL,
    [created_date]  DATETIME2 (7)    CONSTRAINT [df_role_permissions_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]    INT              NULL,
    [updated_date]  DATETIME2 (7)    NULL,
    [updated_by]    INT              NULL,
    [row_version]   ROWVERSION       NOT NULL,
    CONSTRAINT [pk_role_permissions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_role_permissions_permission] FOREIGN KEY ([permission_id]) REFERENCES [dbo].[permissions] ([id]),
    CONSTRAINT [fk_role_permissions_role] FOREIGN KEY ([role_id]) REFERENCES [dbo].[roles] ([id]),
    CONSTRAINT [uq_role_permissions] UNIQUE NONCLUSTERED ([role_id] ASC, [permission_id] ASC),
    CONSTRAINT [uq_role_permissions_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_role_permissions_allowed]
    ON [dbo].[role_permissions]([is_allowed] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_role_permissions_guid]
    ON [dbo].[role_permissions]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_role_permissions_permission]
    ON [dbo].[role_permissions]([permission_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_role_permissions_role]
    ON [dbo].[role_permissions]([role_id] ASC);

