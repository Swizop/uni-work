using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Entities
{
    public class AuthorResearchPaper
    {
        public int AuthorId { get; set; }
        public Author Author { get; set; }  
        public int ResearchPaperId { get; set; }
        public ResearchPaper ResearchPaper { get; set; }
    }
}
