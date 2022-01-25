using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPI_DAW_Lab1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static List<string> Summaries = new List<string>
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };


        // CRUD Operations

        // C - Create       - POST
        // R - Read         - GET
        // U - Update       - PUT/PATCH
        // D - Delete       - DELETE

        [HttpGet]
        public async Task<IActionResult> GetSummaries()
        {
            return Ok(Summaries);
        }

        [HttpGet]
        [Route("summaries/{type}")]
        public async Task<IActionResult> GetSummaryByType(string type)
        {
            return Ok(Summaries[0]);
        }

        [HttpPost]
        public async Task<IActionResult> CreateSummary()
        {
            string newSummary = "Vara";

            Summaries.Add(newSummary);

            return Ok(Summaries);
        }

        [HttpDelete]
        [Route("{type}")]
        public async Task<IActionResult> DeleteSummary(string type)
        {

            Summaries.Remove(type);

            return Ok(Summaries);
        }

        [HttpPut]
        [Route("{type}")]
        public async Task<IActionResult> UpdateSummary(string type)
        {
            try
            {
                int.Parse("test");

                Summaries[0] = type;

                return Ok(Summaries);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }

        // 200 - OK
        // 204 - NoContent

        // 404 - NotFound
        // 400 - BadRequest

        // 500 - Internal Server Error 

    }
}

