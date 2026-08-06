CREATE TABLE [dbo].[transaction_attachments] (
    [id]                 INT              IDENTITY (1, 1) NOT NULL,
    [guid]               UNIQUEIDENTIFIER CONSTRAINT [df_transaction_attachments_guid] DEFAULT (newsequentialid()) NOT NULL,
    [transaction_id]     INT              NOT NULL,
    [file_name]          NVARCHAR (250)   NOT NULL,
    [original_file_name] NVARCHAR (250)   NOT NULL,
    [file_extension]     NVARCHAR (20)    NULL,
    [file_type]          NVARCHAR (100)   NULL,
    [file_size]          BIGINT           NULL,
    [file_path]          NVARCHAR (1000)  NOT NULL,
    [storage_type]       NVARCHAR (50)    CONSTRAINT [df_transaction_attachments_storage_type] DEFAULT ('LOCAL') NOT NULL,
    [description]        NVARCHAR (500)   NULL,
    [is_deleted]         BIT              CONSTRAINT [df_transaction_attachments_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]       DATETIME2 (7)    CONSTRAINT [df_transaction_attachments_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]         INT              NULL,
    [updated_date]       DATETIME2 (7)    NULL,
    [updated_by]         INT              NULL,
    [row_version]        ROWVERSION       NOT NULL,
    CONSTRAINT [pk_transaction_attachments] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_transaction_attachments_transaction] FOREIGN KEY ([transaction_id]) REFERENCES [dbo].[transactions] ([id]),
    CONSTRAINT [uq_transaction_attachments_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_attachments_file_type]
    ON [dbo].[transaction_attachments]([file_type] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_attachments_transaction_id]
    ON [dbo].[transaction_attachments]([transaction_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_transaction_attachments_guid]
    ON [dbo].[transaction_attachments]([guid] ASC);

