CREATE TABLE [dbo].[states] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_states_guid] DEFAULT (newsequentialid()) NOT NULL,
    [country_id]   INT              NOT NULL,
    [state_name]   NVARCHAR (150)   NOT NULL,
    [state_code]   NVARCHAR (20)    NULL,
    [is_active]    BIT              CONSTRAINT [df_states_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]   BIT              CONSTRAINT [df_states_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_states_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_states] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_states_country] FOREIGN KEY ([country_id]) REFERENCES [dbo].[countries] ([id]),
    CONSTRAINT [uq_states_country_name] UNIQUE NONCLUSTERED ([country_id] ASC, [state_name] ASC),
    CONSTRAINT [uq_states_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_states_active]
    ON [dbo].[states]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_states_name]
    ON [dbo].[states]([state_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_states_country]
    ON [dbo].[states]([country_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_states_guid]
    ON [dbo].[states]([guid] ASC);

