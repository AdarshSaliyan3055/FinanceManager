CREATE TABLE [dbo].[users] (
    [id]                    INT              IDENTITY (1, 1) NOT NULL,
    [guid]                  UNIQUEIDENTIFIER CONSTRAINT [df_users_guid] DEFAULT (newsequentialid()) NOT NULL,
    [first_name]            NVARCHAR (100)   NOT NULL,
    [last_name]             NVARCHAR (100)   NULL,
    [email]                 NVARCHAR (255)   NOT NULL,
    [phone_number]          NVARCHAR (20)    NULL,
    [password_hash]         NVARCHAR (MAX)   NOT NULL,
    [password_salt]         NVARCHAR (MAX)   NOT NULL,
    [profile_image_url]     NVARCHAR (500)   NULL,
    [date_of_birth]         DATE             NULL,
    [gender]                NVARCHAR (20)    NULL,
    [country_id]            INT              NULL,
    [state_id]              INT              NULL,
    [city_id]               INT              NULL,
    [preferred_currency_id] INT              NULL,
    [email_verified]        BIT              CONSTRAINT [df_users_email_verified] DEFAULT ((0)) NOT NULL,
    [phone_verified]        BIT              CONSTRAINT [df_users_phone_verified] DEFAULT ((0)) NOT NULL,
    [failed_login_count]    INT              CONSTRAINT [df_users_failed_login] DEFAULT ((0)) NOT NULL,
    [lockout_end_date]      DATETIME2 (7)    NULL,
    [last_login_date]       DATETIME2 (7)    NULL,
    [refresh_token_version] INT              CONSTRAINT [df_users_refresh_token_version] DEFAULT ((1)) NOT NULL,
    [is_active]             BIT              CONSTRAINT [df_users_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]            BIT              CONSTRAINT [df_users_deleted] DEFAULT ((0)) NOT NULL,
    [created_date]          DATETIME2 (7)    CONSTRAINT [df_users_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]            INT              NULL,
    [updated_date]          DATETIME2 (7)    NULL,
    [updated_by]            INT              NULL,
    [row_version]           ROWVERSION       NOT NULL,
    CONSTRAINT [pk_users] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_users_city] FOREIGN KEY ([city_id]) REFERENCES [dbo].[cities] ([id]),
    CONSTRAINT [fk_users_country] FOREIGN KEY ([country_id]) REFERENCES [dbo].[countries] ([id]),
    CONSTRAINT [fk_users_currency] FOREIGN KEY ([preferred_currency_id]) REFERENCES [dbo].[currencies] ([id]),
    CONSTRAINT [fk_users_state] FOREIGN KEY ([state_id]) REFERENCES [dbo].[states] ([id]),
    CONSTRAINT [uq_users_email] UNIQUE NONCLUSTERED ([email] ASC),
    CONSTRAINT [uq_users_guid] UNIQUE NONCLUSTERED ([guid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_users_deleted]
    ON [dbo].[users]([is_deleted] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_active]
    ON [dbo].[users]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_currency]
    ON [dbo].[users]([preferred_currency_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_country]
    ON [dbo].[users]([country_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_phone]
    ON [dbo].[users]([phone_number] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_email]
    ON [dbo].[users]([email] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_users_guid]
    ON [dbo].[users]([guid] ASC);

