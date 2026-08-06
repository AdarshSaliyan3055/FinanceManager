CREATE TABLE [dbo].[categories] (
    [id]                 INT              IDENTITY (1, 1) NOT NULL,
    [guid]               UNIQUEIDENTIFIER CONSTRAINT [df_categories_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]            INT              NULL,
    [category_type_id]   INT              NOT NULL,
    [parent_category_id] INT              NULL,
    [category_name]      NVARCHAR (100)   NOT NULL,
    [category_code]      NVARCHAR (50)    NOT NULL,
    [icon]               NVARCHAR (100)   NULL,
    [color_code]         NVARCHAR (20)    NULL,
    [description]        NVARCHAR (500)   NULL,
    [is_system_category] BIT              CONSTRAINT [df_categories_system] DEFAULT ((0)) NOT NULL,
    [is_active]          BIT              CONSTRAINT [df_categories_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]         BIT              CONSTRAINT [df_categories_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]       DATETIME2 (7)    CONSTRAINT [df_categories_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]         INT              NULL,
    [updated_date]       DATETIME2 (7)    NULL,
    [updated_by]         INT              NULL,
    [row_version]        ROWVERSION       NOT NULL,
    CONSTRAINT [pk_categories] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_categories_category_types] FOREIGN KEY ([category_type_id]) REFERENCES [dbo].[category_types] ([id]),
    CONSTRAINT [fk_categories_parent] FOREIGN KEY ([parent_category_id]) REFERENCES [dbo].[categories] ([id]),
    CONSTRAINT [fk_categories_users] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_categories_code] UNIQUE NONCLUSTERED ([category_code] ASC),
    CONSTRAINT [uq_categories_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_categories_active]
    ON [dbo].[categories]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_categories_parent_category_id]
    ON [dbo].[categories]([parent_category_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_categories_category_type_id]
    ON [dbo].[categories]([category_type_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_categories_user_id]
    ON [dbo].[categories]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_categories_guid]
    ON [dbo].[categories]([guid] ASC);

