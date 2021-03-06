USE [master]
GO
/****** Object:  Database [PublishedGrades]    Script Date: 12/13/2013 11:26:43 PM ******/
CREATE DATABASE [PublishedGrades]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PublishedGrades', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLDEV2012\MSSQL\DATA\PublishedGrades.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PublishedGrades_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLDEV2012\MSSQL\DATA\PublishedGrades_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PublishedGrades] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PublishedGrades].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PublishedGrades] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PublishedGrades] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PublishedGrades] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PublishedGrades] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PublishedGrades] SET ARITHABORT OFF 
GO
ALTER DATABASE [PublishedGrades] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PublishedGrades] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PublishedGrades] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PublishedGrades] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PublishedGrades] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PublishedGrades] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PublishedGrades] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PublishedGrades] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PublishedGrades] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PublishedGrades] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PublishedGrades] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PublishedGrades] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PublishedGrades] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PublishedGrades] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PublishedGrades] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PublishedGrades] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PublishedGrades] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PublishedGrades] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PublishedGrades] SET RECOVERY FULL 
GO
ALTER DATABASE [PublishedGrades] SET  MULTI_USER 
GO
ALTER DATABASE [PublishedGrades] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PublishedGrades] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PublishedGrades] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PublishedGrades] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PublishedGrades', N'ON'
GO
USE [PublishedGrades]
GO
/****** Object:  User [SAURON\edugradespublish_svc]    Script Date: 12/13/2013 11:26:44 PM ******/
CREATE USER [SAURON\edugradespublish_svc] FOR LOGIN [SAURON\edugradespublish_svc] WITH DEFAULT_SCHEMA=[db_owner]
GO
ALTER ROLE [db_owner] ADD MEMBER [SAURON\edugradespublish_svc]
GO
/****** Object:  Table [dbo].[Professor]    Script Date: 12/13/2013 11:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professor](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Professor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publication]    Script Date: 12/13/2013 11:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProfessorID] [int] NOT NULL,
	[Campus] [nvarchar](50) NOT NULL,
	[Course] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](50) NOT NULL,
	[EvaluationType] [nvarchar](50) NOT NULL,
	[Signature] [nvarchar](1024) NOT NULL,
 CONSTRAINT [PK_Publication] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 12/13/2013 11:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentScore]    Script Date: 12/13/2013 11:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentScore](
	[PublicationID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Score] [float] NOT NULL,
 CONSTRAINT [PK_StudentScores] PRIMARY KEY CLUSTERED 
(
	[PublicationID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Publication] ON 

INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (1, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (2, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (3, 0, N'TagusPark', N'LEE', N'BD', N'Teste 2', N'lgeXLaVFJvs2nV9BoGrOU9GDbnFxP2A9rmz5ancK6cVWi8n+/tRv4fpeoZMWEF7lQk3T/bEQ+X7bENRrCpXVEMMTdVD5Q2/afzZZlcFXBlzIjIhgkP6nfxYBJXemgN5NnBSZvp9IRbhSoNjLyQ04ZgFmYb4A3eDDIn6dwYZuya+AB3Jz59TBLmU+eofn0wqUcqhLHaiLhCxolakYa2EMhWX+38VJ2CXCZpUyYecNWycottQ3Sdjib64l9DqqHIiCnLLmhM46Eks5lhRu9Rf+ZJcu8OXgR/kxEMHtlA6ZO57XbWhUAaWMvbL28dkoep7qkN/Et536hryi8BbbErnbJA==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (1002, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (1003, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (2002, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
INSERT [dbo].[Publication] ([ID], [ProfessorID], [Campus], [Course], [Class], [EvaluationType], [Signature]) VALUES (2003, 0, N'TagusPark', N'LEE', N'BD', N'Teste 1', N'i2yYck5fbwkf2EB7raT5+/Ct9F5Q/44DNQB2XxJoENrwvO8+JE69ytUYJuepBC89p8X+TJ7d2OUF2A54eWk2izWv6Ha9m0gYa3SDDG/oyvWcOEN0yAx6QWcRqf0aj9K0mc20T6/9gOcEfUIicAI095QlRF7jNxGnoFIoywFWN8QOPRqvubw0jYyeqfWVoklCmRuu8v/wwxxaartIFC6VLVFVqPJzSdrBjcNtwcX3kYlcZdGuR5iIEfdxD6wuqXE4yonmprCMjoufzTX90uLIIh3rzVrmOuxKqURjJApRYZZMAJVOc/Ye6ARvuEke4TES/FzxBN6Noa9mmgszl2Gncw==')
SET IDENTITY_INSERT [dbo].[Publication] OFF
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (3, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (3, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (3, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (3, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (3, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1002, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1002, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1002, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1002, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1002, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1003, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1003, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1003, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1003, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (1003, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2002, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2002, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2002, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2002, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2002, 68135, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2003, 66047, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2003, 66998, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2003, 67073, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2003, 68121, 0)
INSERT [dbo].[StudentScore] ([PublicationID], [StudentID], [Score]) VALUES (2003, 68135, 0)
ALTER TABLE [dbo].[StudentScore]  WITH CHECK ADD  CONSTRAINT [FK_StudentScores_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[StudentScore] CHECK CONSTRAINT [FK_StudentScores_Publication]
GO
USE [master]
GO
ALTER DATABASE [PublishedGrades] SET  READ_WRITE 
GO
