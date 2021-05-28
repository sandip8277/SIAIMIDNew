using MIDDerivationLibrary.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.MIDCodeDeconstruction
{
    public class MIDCodeDeconstructionRepository : IMIDCodeDeconstructionRepository
    {
        private readonly ISQLRepository sqlRepository;

        public MIDCodeDeconstructionRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }

        public MachineComponentsForMIDgeneration MIDCodeDeconstruction(string xml)
        {
            Models.MachineComponentsForMIDgeneration details = new Models.MachineComponentsForMIDgeneration();
            try
            {
                string spName = Constants.spMIDCodeDeconstruction;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{Constants.xmlInput}", xml) };
                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);

                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    var driverData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driver").FirstOrDefault();
                    var coupling1Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling1").FirstOrDefault();
                    var coupling2Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling2").FirstOrDefault();
                    var intermediateData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Intermediate").FirstOrDefault();
                    var drivenData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driven").FirstOrDefault();

                    if (driverData != null)
                    { 
                        details.driver = new Models.Driver()
                        {
                            componentType =  driverData[0].ToString(),
                            locations = driverData[2] is DBNull ? null : Convert.ToInt32(driverData[2]),
                            rpm = driverData[3] is DBNull ? null :  Convert.ToInt32(driverData[3]),
                            driverLocationDE = driverData[4] is DBNull ? null :  Convert.ToBoolean(driverData[4]),
                            driverLocationNDE = driverData[5] is DBNull ? null : Convert.ToBoolean(driverData[5]),
                            driverType = driverData[6].ToString()
                        };
                        
                        if (!string.IsNullOrEmpty(driverData[12].ToString()))
                            details.driver.drivers = JsonConvert.DeserializeObject<Drivers>(driverData[12].ToString());
                    }
                    if (coupling1Data != null)
                    { 
                        details.coupling1 = new Models.Coupling1()
                        {
                            componentType = coupling1Data[0].ToString(),
                            couplingPosition = coupling1Data[8] is DBNull ? null :  Convert.ToInt32(coupling1Data[8]),
                            couplingType = coupling1Data[9].ToString(),
                            locations = coupling1Data[2] is DBNull ? null :  Convert.ToInt32(coupling1Data[2]),
                            speedratio = coupling1Data[7] is DBNull ? null :  Convert.ToDecimal(coupling1Data[7])
                        };
                    }
                    if (coupling2Data != null)
                    { 
                        details.coupling2 = new Models.Coupling2()
                        {
                            componentType = coupling2Data[0].ToString(),
                            couplingPosition = coupling2Data[8] is DBNull ? null : Convert.ToInt32(coupling2Data[8]),
                            couplingType = coupling2Data[9].ToString(),
                            locations = coupling2Data[2] is DBNull ? null :  Convert.ToInt32(coupling2Data[2]),
                            speedratio = coupling2Data[7] is DBNull ? null :  Convert.ToDecimal(coupling2Data[7])
                        };
                    }

                    if (intermediateData != null)
                    { 
                        details.intermediate = new Models.Intermediate()
                        {
                            componentType = intermediateData[0].ToString(),
                            intermediateType = intermediateData[10].ToString(),
                            locations = intermediateData[2] is DBNull ? null : Convert.ToInt32(intermediateData[2]),
                            speedratio = intermediateData[7] is DBNull ? null :  Convert.ToDecimal(intermediateData[7])
                        };
                    }

                    if (drivenData != null)
                    { 
                        details.driven = new Models.Driven()
                        {
                            componentType = drivenData[0].ToString(),
                            drivenLocationDE = drivenData[4] is DBNull ? null :  Convert.ToBoolean(drivenData[4]),
                            drivenLocationNDE = drivenData[5] is DBNull ? null :  Convert.ToBoolean(drivenData[5]),
                            locations = drivenData[2] is DBNull ? null :  Convert.ToInt32(drivenData[2]),
                            drivenType = drivenData[6].ToString()
                        };
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
