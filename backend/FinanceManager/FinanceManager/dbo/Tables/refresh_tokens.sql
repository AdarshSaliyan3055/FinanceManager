CREATE TABLE [dbo].[refresh_tokens] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_refresh_tokens_guid] DEFAULT (newsequentialid()) NOT NULL,
    [user_id]      INT              NOT NULL,
    [token]        NVARCHAR (500)   NOT NULL,
    [expires_date] DATETIME2 (7)    NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_refresh_tokens_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [revoked_date] DATETIME2 (7)    NULL,
    [device_name]  NVARCHAR (100)   NULL,
    [ip_address]   NVARCHAR (50)    NULL,
    [user_agent]   NVARCHAR (500)   NULL,
    [is_active]    AS               (case when [revoked_date] IS NULL AND [expires_date]>sysutcdatetime() then CONVERT([bit],(1)) else CONVERT([bit],(0)) end),
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_refresh_tokens] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_refresh_tokens_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([id]),
    CONSTRAINT [uq_refresh_tokens_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_refresh_tokens_guid]
    ON [dbo].[refresh_tokens]([guid] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ux_refresh_tokens_token]
    ON [dbo].[refresh_tokens]([token] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_refresh_tokens_user_id]
    ON [dbo].[refresh_tokens]([user_id] ASC);

