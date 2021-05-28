using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Repository;
using Newtonsoft.Json;
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
        private readonly ISQLRepository sqlRepository;

        public MIDCodeGeneratorRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        
        public MIDCodeDetails GenerareMIDCodes(string xml)
        {
            MIDCodeDetails details = new MIDCodeDetails();
            try
            {
                string spName = Constants.spGenerareMIDCodesSPName;
                List<SqlParameter> allParams = new List<SqlParameter>(){new SqlParameter($"@{Constants.xmlInput}", xml)};
                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);

                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    var driverData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driver").FirstOrDefault();
                    var coupling1Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling1").FirstOrDefault();
                    var coupling2Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling2").FirstOrDefault();
                    var intermediateData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Intermediate").FirstOrDefault();
                    var drivenData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driven").FirstOrDefault();

                    var faultCodeData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "FaultCodeMatrix").FirstOrDefault();

                    if (driverData != null)
                        details.driver = new DriverCodes() { ComponentCode = driverData[1].ToString(), PickupCode = driverData[2].ToString()};

                    if (coupling1Data != null)
                        details.coupling1 = new Codes() { ComponentCode = coupling1Data[1].ToString(), PickupCode = coupling1Data[2].ToString(), SpeedRatio = Convert.ToDecimal(coupling1Data[4]) };

                    if (coupling2Data != null)
                        details.coupling2 = new Codes() { ComponentCode = coupling2Data[1].ToString(), PickupCode = coupling2Data[2].ToString(), SpeedRatio = Convert.ToDecimal(coupling2Data[4]) };

                    if (intermediateData != null)
                        details.intermediate = new Codes() { ComponentCode = intermediateData[1].ToString(), PickupCode = intermediateData[2].ToString(), SpeedRatio = Convert.ToDecimal(intermediateData[4]) };

                    if (drivenData != null)
                        details.driven = new DrivenCodes() { ComponentCode = drivenData[1].ToString(), PickupCode = drivenData[2].ToString()};

                    if (faultCodeData != null)
                    {
                        var faultCodeMatrixJsonString = faultCodeData[3].ToString();
                        if (!string.IsNullOrEmpty(faultCodeMatrixJsonString))
                        {
                            details.faultCodeMatrix = JsonConvert.DeserializeObject<FaultCodeMatrix>(faultCodeMatrixJsonString);
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return details;
        }
    }
}
