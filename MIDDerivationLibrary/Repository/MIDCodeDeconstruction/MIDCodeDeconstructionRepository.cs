using MIDDerivationLibrary.Models;
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
                    var DriverData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driver").FirstOrDefault();
                    var Coupling1Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling1").FirstOrDefault();
                    var Coupling2Data = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Coupling2").FirstOrDefault();
                    var IntermediateData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Intermediate").FirstOrDefault();
                    var DrivenData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "Driven").FirstOrDefault();

                    //var FaultCodeData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "FaultCodeMatrix").FirstOrDefault();
                    
                    //if (DriverData != null)
                    //    details.driver = new Models.Driver() { componentType = DriverData[1].ToString(), PickupCode = DriverData[2].ToString() };

                    //if (Coupling1Data != null)
                    //    details.Coupling1 = new Codes() { ComponentCode = Coupling1Data[1].ToString(), PickupCode = Coupling1Data[2].ToString() };

                    //if (Coupling2Data != null)
                    //    details.Coupling2 = new Codes() { ComponentCode = Coupling2Data[1].ToString(), PickupCode = Coupling2Data[2].ToString() };

                    //if (IntermediateData != null)
                    //    details.Intermediate = new Codes() { ComponentCode = IntermediateData[1].ToString(), PickupCode = IntermediateData[2].ToString() };

                    //if (DrivenData != null)
                    //    details.Driven = new Codes() { ComponentCode = DrivenData[1].ToString(), PickupCode = DrivenData[2].ToString() };

                    //if (FaultCodeData != null)
                    //{
                    //    var FaultCodeMatrixJsonString = FaultCodeData[3].ToString();
                    //    if (!string.IsNullOrEmpty(FaultCodeMatrixJsonString))
                    //    {
                    //        details.FaultCodeMatrix = JsonConvert.DeserializeObject<FaultCodeMatrix>(FaultCodeMatrixJsonString);
                    //    }
                    //}

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
