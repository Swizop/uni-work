using Microsoft.EntityFrameworkCore.Migrations;

namespace DAW_Lab2_Sgr15.Migrations
{
    public partial class AddedResearchPapersAndManyToManyRelationship : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ResearchPapers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ResearchPapers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AuthorResearchPapers",
                columns: table => new
                {
                    AuthorId = table.Column<int>(type: "int", nullable: false),
                    ResearchPaperId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AuthorResearchPapers", x => new { x.AuthorId, x.ResearchPaperId });
                    table.ForeignKey(
                        name: "FK_AuthorResearchPapers_Authors_AuthorId",
                        column: x => x.AuthorId,
                        principalTable: "Authors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AuthorResearchPapers_ResearchPapers_ResearchPaperId",
                        column: x => x.ResearchPaperId,
                        principalTable: "ResearchPapers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AuthorResearchPapers_ResearchPaperId",
                table: "AuthorResearchPapers",
                column: "ResearchPaperId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AuthorResearchPapers");

            migrationBuilder.DropTable(
                name: "ResearchPapers");
        }
    }
}
