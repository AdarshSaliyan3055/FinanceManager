CREATE TABLE [dbo].[user_languages] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_user_languages_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]      INT              NOT NULL,
    [language_id]  INT              NOT NULL,
    [is_default]   BIT              CONSTRAINT [df_user_languages_is_default] DEFAULT ((1)) NOT NULL,
    [is_active]    BIT              CONSTRAINT [df_user_languages_is_active] DEFAULT ((1)) NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_user_languages_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_user_languages] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_user_languages_language] FOREIGN KEY ([language_id]) REFERENCES [dbo].[languages] ([id]),
    CONSTRAINT [fk_user_languages_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_user_languages_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_user_languages_user_language] UNIQUE NONCLUSTERED ([user_id] ASC, [language_id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ux_user_languages_default]
    ON [dbo].[user_languages]([user_id] ASC) WHERE ([is_default]=(1));


GO
CREATE NONCLUSTERED INDEX [ix_user_languages_active]
    ON [dbo].[user_languages]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_languages_guid]
    ON [dbo].[user_languages]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_languages_language]
    ON [dbo].[user_languages]([language_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_user_languages_user]
    ON [dbo].[user_languages]([user_id] ASC);

