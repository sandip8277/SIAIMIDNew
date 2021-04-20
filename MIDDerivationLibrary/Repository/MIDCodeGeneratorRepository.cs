using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Repository;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDCodeGenerator.Repository
{
    public class MIDCodeGeneratorRepository : IMIDCodeGeneratorRepository
    {
        private IConfiguration Configuration;
        private string _connectionString;
        ISQLRepository sqlRepository;
        public MIDCodeGeneratorRepository(IConfiguration _configuration)
        {
            Configuration = _configuration;
            sqlRepository = SQLRepository.Instance;
        }

        public MIDCodeDetails GenerareMIDCodes(string xml)
        {
            string sprocName = "spGenerateMIDDerivation";
            MIDCodeDetails details = new MIDCodeDetails();
            List<SqlParameter> allParams = new List<SqlParameter>(){
              new SqlParameter($"@{Constants.xmlInput}", xml)
            };
            DataSet result = sqlRepository.ExecuteQuery(sprocName, allParams);
            //Construct response here
            return details;
        }
    }
}
