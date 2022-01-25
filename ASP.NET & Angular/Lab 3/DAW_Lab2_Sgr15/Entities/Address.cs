using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Entities
{
    public class Address
    {
        public int Id { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
        public string Country { get; set; }
        public int AuthorId { get; set; }
        public Author Author { get; set; }

    }
}
