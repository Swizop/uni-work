using DAW_Lab2_Sgr15.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Data
{
    public class Lab2Context : DbContext
    {
        public Lab2Context(DbContextOptions<Lab2Context> options) : base(options) { }

        public DbSet<Author> Authors { get; set; }
        public DbSet<Book> Books { get; set; }
        public DbSet<ResearchPaper> ResearchPapers { get; set; }
        public DbSet<AuthorResearchPaper> AuthorResearchPapers { get; set; }    

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // One to Many

            modelBuilder.Entity<Author>()
                .HasMany(a => a.Books)
                .WithOne(b => b.Author);

            // One to One

            modelBuilder.Entity<Author>()
                .HasOne(a => a.Address)
                .WithOne(adr => adr.Author);

            // Many to Many

            modelBuilder.Entity<AuthorResearchPaper>().HasKey(arp => new { arp.AuthorId, arp.ResearchPaperId });

            modelBuilder.Entity<AuthorResearchPaper>()
                .HasOne(arp => arp.Author)
                .WithMany(a => a.AuthorResearchPapers)
                .HasForeignKey(arp => arp.AuthorId);

            modelBuilder.Entity<AuthorResearchPaper>()
                .HasOne(arp => arp.ResearchPaper)
                .WithMany(a => a.AuthorResearchPapers)
                .HasForeignKey(arp => arp.ResearchPaperId);


            base.OnModelCreating(modelBuilder);
        }
    }
}

    // DDL - Data Definition language 

    // DML - Data Manipulation Language 