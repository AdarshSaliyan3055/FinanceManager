CREATE TABLE [dbo].[configurations] (
    [id]                  INT              IDENTITY (1, 1) NOT NULL,
    [guid]                UNIQUEIDENTIFIER CONSTRAINT [df_configurations_guid] DEFAULT (newsequentialid()) NOT NULL,
    [configuration_key]   NVARCHAR (200)   NOT NULL,
    [configuration_value] NVARCHAR (MAX)   NULL,
    [configuration_type]  NVARCHAR (50)    CONSTRAINT [df_configurations_type] DEFAULT ('STRING') NOT NULL,
    [description]         NVARCHAR (500)   NULL,
    [category]            NVARCHAR (100)   NULL,
    [is_editable]         BIT              CONSTRAINT [df_configurations_is_editable] DEFAULT ((1)) NOT NULL,
    [is_active]           BIT              CONSTRAINT [df_configurations_is_active] DEFAULT ((1)) NOT NULL,
    [created_date]        DATETIME2 (7)    CONSTRAINT [df_configurations_created_date] DEFAULT (sysutcdatetime()) NOT NULL,
    [created_by]          INT              NULL,
    [updated_date]        DATETIME2 (7)    NULL,
    [updated_by]          INT              NULL,
    [row_version]         ROWVERSION       NOT NULL,
    CONSTRAINT [pk_configurations] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [ck_configurations_type] CHECK ([configuration_type]='JSON' OR [configuration_type]='DATE' OR [configuration_type]='BOOLEAN' OR [configuration_type]='NUMBER' OR [configuration_type]='STRING'),
    CONSTRAINT [uq_configurations_guid] UNIQUE NONCLUSTERED ([guid] ASC),
    CONSTRAINT [uq_configurations_key] UNIQUE NONCLUSTERED ([configuration_key] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_configurations_active]
    ON [dbo].[configurations]([is_active] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_configurations_category]
    ON [dbo].[configurations]([category] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_configurations_key]
    ON [dbo].[configurations]([configuration_key] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_configurations_guid]
    ON [dbo].[configurations]([guid] ASC);

