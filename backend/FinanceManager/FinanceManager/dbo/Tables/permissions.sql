CREATE TABLE [dbo].[permissions] (
    [id]                   INT              IDENTITY (1, 1) NOT NULL,
    [guid]                 UNIQUEIDENTIFIER CONSTRAINT [df_permissions_guid] DEFAULT (newsequentialid()) NOT NULL,
    [permission_key]       NVARCHAR (150)   NOT NULL,
    [permission_name]      NVARCHAR (150)   NOT NULL,
    [module_name]          NVARCHAR (100)   NOT NULL,
    [description]          NVARCHAR (500)   NULL,
    [display_order]        INT              CONSTRAINT [df_permissions_display_order] DEFAULT ((0)) NOT NULL,
    [is_system_permission] BIT              CONSTRAINT [df_permissions_system] DEFAULT ((1)) NOT NULL,
    [is_active]            BIT              CONSTRAINT [df_permissions_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]           BIT              CONSTRAINT [df_permissions_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]         DATETIME2 (7)    CONSTRAINT [df_permissions_created] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]           INT              NULL,
    [updated_date]         DATETIME2 (7)    NULL,
    [updated_by]           INT              NULL,
    [row_version]          ROWVERSION       NOT NULL,
    CONSTRAINT [pk_permissions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_permissions_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_permissions_key] UNIQUE NONCLUSTERED ([permission_key] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_permissions_deleted]
    ON [dbo].[permissions]([is_deleted] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_permissions_active]
    ON [dbo].[permissions]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_permissions_module]
    ON [dbo].[permissions]([module_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_permissions_key]
    ON [dbo].[permissions]([permission_key] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_permissions_guid]
    ON [dbo].[permissions]([guid] ASC);

