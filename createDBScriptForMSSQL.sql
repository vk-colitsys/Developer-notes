USE [master]
GO
/****** Object:  Database [devnotes]    Script Date: 04/23/2009 09:55:59 ******/
CREATE DATABASE [devnotes] ON  PRIMARY 
( NAME = N'devnotes', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\devnotes.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'devnotes_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\devnotes_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'devnotes', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [devnotes].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [devnotes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [devnotes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [devnotes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [devnotes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [devnotes] SET ARITHABORT OFF 
GO
ALTER DATABASE [devnotes] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [devnotes] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [devnotes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [devnotes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [devnotes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [devnotes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [devnotes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [devnotes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [devnotes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [devnotes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [devnotes] SET  ENABLE_BROKER 
GO
ALTER DATABASE [devnotes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [devnotes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [devnotes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [devnotes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [devnotes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [devnotes] SET  READ_WRITE 
GO
ALTER DATABASE [devnotes] SET RECOVERY FULL 
GO
ALTER DATABASE [devnotes] SET  MULTI_USER 
GO
ALTER DATABASE [devnotes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [devnotes] SET DB_CHAINING OFF 

USE [devnotes]
GO
/****** Object:  Table [dbo].[apps]    Script Date: 04/23/2009 09:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[apps](
	[app_name] [varchar](max) NULL,
	[app_id] [int] IDENTITY(1,1) NOT NULL,
	[app_version] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [devnotes]
GO
/****** Object:  Table [dbo].[notes]    Script Date: 04/23/2009 09:56:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notes](
	[note] [text] NULL,
	[note_id] [int] IDENTITY(1,1) NOT NULL,
	[app_id] [int] NULL,
	[entry_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]