CREATE TABLE [dbo].[cities] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [guid]         UNIQUEIDENTIFIER CONSTRAINT [df_cities_guid] DEFAULT (newsequentialid()) NOT NULL,
    [state_id]     INT              NOT NULL,
    [city_name]    NVARCHAR (150)   NOT NULL,
    [city_code]    NVARCHAR (20)    NULL,
    [postal_code]  NVARCHAR (20)    NULL,
    [latitude]     DECIMAL (10, 7)  NULL,
    [longitude]    DECIMAL (10, 7)  NULL,
    [is_active]    BIT              CONSTRAINT [df_cities_is_active] DEFAULT ((1)) NOT NULL,
    [is_deleted]   BIT              CONSTRAINT [df_cities_is_deleted] DEFAULT ((0)) NOT NULL,
    [created_date] DATETIME2 (7)    CONSTRAINT [df_cities_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]   INT              NULL,
    [updated_date] DATETIME2 (7)    NULL,
    [updated_by]   INT              NULL,
    [row_version]  ROWVERSION       NOT NULL,
    CONSTRAINT [pk_cities] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_cities_state] FOREIGN KEY ([state_id]) REFERENCES [dbo].[states] ([id]),
    CONSTRAINT [uq_cities_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_cities_state_city] UNIQUE NONCLUSTERED ([state_id] ASC, [city_name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_cities_active]
    ON [dbo].[cities]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_cities_name]
    ON [dbo].[cities]([city_name] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_cities_state]
    ON [dbo].[cities]([state_id] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_cities_guid]
    ON [dbo].[cities]([guid] ASC);

