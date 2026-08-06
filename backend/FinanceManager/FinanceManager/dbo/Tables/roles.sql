CREATE TABLE [dbo].[roles] (
    [id]             INT              IDENTITY (1, 1) NOT NULL,
    [guid]           UNIQUEIDENTIFIER CONSTRAINT [df_roles_guid] DEFAULT (newsequentialid()) NOT NULL,
    [name]           NVARCHAR (100)   NOT NULL,
    [code]           NVARCHAR (50)    NOT NULL,
    [description]    NVARCHAR (500)   NULL,
    [display_order]  INT              CONSTRAINT [df_roles_display_order] DEFAULT ((0)) NOT NULL,
    [is_system_role] BIT              CONSTRAINT [df_roles_system_role] DEFAULT ((0)) NOT NULL,
    [is_active]      BIT              CONSTRAINT [df_roles_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]     BIT              CONSTRAINT [df_roles_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]   DATETIME2 (7)    CONSTRAINT [df_roles_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]     INT              NULL,
    [updated_date]   DATETIME2 (7)    NULL,
    [updated_by]     INT              NULL,
    CONSTRAINT [pk_roles] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_roles_code] UNIQUE NONCLUSTERED ([code] ASC),
    CONSTRAINT [uq_roles_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_roles_name] UNIQUE NONCLUSTERED ([name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_roles_deleted]
    ON [dbo].[roles]([is_deleted] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_roles_active]
    ON [dbo].[roles]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_roles_code]
    ON [dbo].[roles]([code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_roles_name]
    ON [dbo].[roles]([name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_roles_guid]
    ON [dbo].[roles]([guid] ASC);

