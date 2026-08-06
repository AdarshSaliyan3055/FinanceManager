CREATE TABLE [dbo].[transaction_tags] (
    [id]             INT              IDENTITY (1, 1) NOT NULL,
    [guid]           UNIQUEIDENTIFIER CONSTRAINT [df_transaction_tags_guid] DEFAULT (newsequentialid()) NOT NULL,
    [transaction_id] INT              NOT NULL,
    [tag_id]         INT              NOT NULL,
    [created_date]   DATETIME2 (7)    CONSTRAINT [df_transaction_tags_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]     INT              NULL,
    [updated_date]   DATETIME2 (7)    NULL,
    [updated_by]     INT              NULL,
    [row_version]    ROWVERSION       NOT NULL,
    CONSTRAINT [pk_transaction_tags] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_transaction_tags_tag] FOREIGN KEY ([tag_id]) REFERENCES [dbo].[tags] ([id]),
    CONSTRAINT [fk_transaction_tags_transaction] FOREIGN KEY ([transaction_id]) REFERENCES [dbo].[transactions] ([id]),
    CONSTRAINT [uq_transaction_tags_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_transaction_tags_mapping] UNIQUE NONCLUSTERED ([transaction_id] ASC, [tag_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_tags_guid]
    ON [dbo].[transaction_tags]([guid] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_tags_tag_id]
    ON [dbo].[transaction_tags]([tag_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_tags_transaction_id]
    ON [dbo].[transaction_tags]([transaction_id] ASC);

