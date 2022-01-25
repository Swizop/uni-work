﻿// <auto-generated />
using DAW_Lab2_Sgr15.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DAW_Lab2_Sgr15.Migrations
{
    [DbContext(typeof(Lab2Context))]
    partial class Lab2ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.11")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Address", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("AuthorId")
                        .HasColumnType("int");

                    b.Property<string>("City")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Country")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Street")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("AuthorId")
                        .IsUnique();

                    b.ToTable("Address");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Author", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Authors");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.AuthorResearchPaper", b =>
                {
                    b.Property<int>("AuthorId")
                        .HasColumnType("int");

                    b.Property<int>("ResearchPaperId")
                        .HasColumnType("int");

                    b.HasKey("AuthorId", "ResearchPaperId");

                    b.HasIndex("ResearchPaperId");

                    b.ToTable("AuthorResearchPapers");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Book", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("AuthorId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("NumberOfPages")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("AuthorId");

                    b.ToTable("Books");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.ResearchPaper", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("ResearchPapers");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Address", b =>
                {
                    b.HasOne("DAW_Lab2_Sgr15.Entities.Author", "Author")
                        .WithOne("Address")
                        .HasForeignKey("DAW_Lab2_Sgr15.Entities.Address", "AuthorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Author");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.AuthorResearchPaper", b =>
                {
                    b.HasOne("DAW_Lab2_Sgr15.Entities.Author", "Author")
                        .WithMany("AuthorResearchPapers")
                        .HasForeignKey("AuthorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("DAW_Lab2_Sgr15.Entities.ResearchPaper", "ResearchPaper")
                        .WithMany("AuthorResearchPapers")
                        .HasForeignKey("ResearchPaperId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Author");

                    b.Navigation("ResearchPaper");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Book", b =>
                {
                    b.HasOne("DAW_Lab2_Sgr15.Entities.Author", "Author")
                        .WithMany("Books")
                        .HasForeignKey("AuthorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Author");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.Author", b =>
                {
                    b.Navigation("Address");

                    b.Navigation("AuthorResearchPapers");

                    b.Navigation("Books");
                });

            modelBuilder.Entity("DAW_Lab2_Sgr15.Entities.ResearchPaper", b =>
                {
                    b.Navigation("AuthorResearchPapers");
                });
#pragma warning restore 612, 618
        }
    }
}
