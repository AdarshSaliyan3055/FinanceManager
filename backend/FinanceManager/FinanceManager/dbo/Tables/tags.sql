CREATE TABLE [dbo].[tags] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_tags_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]      INT              NOT NULL,
    [tag_name]     NVARCHAR (100)   NOT NULL,
    [description]  NVARCHAR (250)   NULL,
    [color_code]   NVARCHAR (20)    NULL,
    [is_default]   BIT              CONSTRAINT [df_tags_is_default] DEFAULT ((0)) NOT NULL,
    [is_active]    BIT              CONSTRAINT [df_tags_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]   BIT              CONSTRAINT [df_tags_deleted] DEFAULT ((0)) NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_tags_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_tags] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_tags_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_tags_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ux_tags_user_tag_name]
    ON [dbo].[tags]([user_id] ASC, [tag_name] ASC) WHERE ([is_deleted]=(0));


GO
CREATE NONCLUSTERED INDEX [ix_tags_tag_name]
    ON [dbo].[tags]([tag_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_tags_user_id]
    ON [dbo].[tags]([user_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_tags_guid]
    ON [dbo].[tags]([guid] ASC);

