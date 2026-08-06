CREATE TABLE [dbo].[languages] (
    [id]            INT              IDENTITY (1, 1) NOT NULL,
    [guid]          UNIQUEIDENTIFIER CONSTRAINT [df_languages_guid] DEFAULT (newsequentialid()) NOT NULL,
    [language_name] NVARCHAR (100)   NOT NULL,
    [culture_code]  NVARCHAR (20)    NOT NULL,
    [language_code] NVARCHAR (10)    NOT NULL,
    [native_name]   NVARCHAR (100)   NULL,
    [direction]     NVARCHAR (10)    CONSTRAINT [df_languages_direction] DEFAULT ('LTR') NOT NULL,
    [is_default]    BIT              CONSTRAINT [df_languages_default] DEFAULT ((0)) NOT NULL,
    [is_active]     BIT              CONSTRAINT [df_languages_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]    BIT              CONSTRAINT [df_languages_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]  DATETIME2 (7)    CONSTRAINT [df_languages_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]    INT              NULL,
    [updated_date]  DATETIME2 (7)    NULL,
    [updated_by]    INT              NULL,
    [row_version]   ROWVERSION       NOT NULL,
    CONSTRAINT [pk_languages] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [ck_languages_direction] CHECK ([direction]='RTL' OR [direction]='LTR'),
    CONSTRAINT [uq_languages_culture_code] UNIQUE NONCLUSTERED ([culture_code] ASC),
    CONSTRAINT [uq_languages_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_languages_language_code] UNIQUE NONCLUSTERED ([language_code] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_languages_default]
    ON [dbo].[languages]([is_default] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_languages_active]
    ON [dbo].[languages]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_languages_language_code]
    ON [dbo].[languages]([language_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_languages_culture_code]
    ON [dbo].[languages]([culture_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_languages_guid]
    ON [dbo].[languages]([guid] ASC);

