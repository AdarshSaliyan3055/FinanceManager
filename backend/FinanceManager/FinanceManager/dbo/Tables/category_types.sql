CREATE TABLE [dbo].[category_types] (
    [id]                 INT              IDENTITY (1, 1) NOT NULL,
    [guid]               UNIQUEIDENTIFIER CONSTRAINT [df_category_types_guid] DEFAULT (newsequentialid()) NOT NULL,
    [category_type_name] NVARCHAR (100)   NOT NULL,
    [category_type_code] NVARCHAR (50)    NOT NULL,
    [description]        NVARCHAR (500)   NULL,
    [is_income]          BIT              CONSTRAINT [df_category_types_is_income] DEFAULT ((0)) NOT NULL,
    [is_expense]         BIT              CONSTRAINT [df_category_types_is_expense] DEFAULT ((0)) NOT NULL,
    [is_transfer]        BIT              CONSTRAINT [df_category_types_is_transfer] DEFAULT ((0)) NOT NULL,
    [is_active]          BIT              CONSTRAINT [df_category_types_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]         BIT              CONSTRAINT [df_category_types_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]       DATETIME2 (7)    CONSTRAINT [df_category_types_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]         INT              NULL,
    [updated_date]       DATETIME2 (7)    NULL,
    [updated_by]         INT              NULL,
    [row_version]        ROWVERSION       NOT NULL,
    CONSTRAINT [pk_category_types] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [uq_category_types_code] UNIQUE NONCLUSTERED ([category_type_code] ASC),
    CONSTRAINT [uq_category_types_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_category_types_active]
    ON [dbo].[category_types]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_category_types_name]
    ON [dbo].[category_types]([category_type_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_category_types_code]
    ON [dbo].[category_types]([category_type_code] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_category_types_guid]
    ON [dbo].[category_types]([guid] ASC);

