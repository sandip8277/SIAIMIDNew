using MIDDerivationLibrary.Models.PickupModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.PickupCode
{
    public class PickupCodeRepository : IPickupCodeRepository
    {
        private readonly ISQLRepository sqlRepository;

        public PickupCodeRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdatePickupCodeDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdatePickupCodeDetails;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
                id = sqlRepository.ExecuteNonQuery(spName, allParams);
            }
            catch (Exception ex)
            {
                ex.ToString();
                return 0;
            }
            return id;
        }

        public List<PickupCodeDetails> GetAllPickupCodeDetails(string componentType = null, string PickupCodeType = null)
        {
            List<PickupCodeDetails> detailsLst = new List<PickupCodeDetails>();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetAllPickupCodeDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  //new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.PickupCodeType}", PickupCodeType == null ? DBNull.Value : PickupCodeType  )
                };

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                    {
                        //id = dataRow.Field<long>("id"),
                        //componentType = dataRow.Field<string>("componentType"),
                        //locations = dataRow.Field<int?>("locations"),
                        //PickupCodeType = dataRow.Field<string>("PickupCodeType"),
                        //cylinders = dataRow.Field<int?>("cylinders"),
                        //motorDrive = dataRow.Field<string>("motorDrive"),
                        //motorFan = dataRow.Field<bool?>("motorFan"),
                        //motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        //drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        //drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        //motorPoles = dataRow.Field<int?>("motorPoles"),
                        //turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        //turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        //turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        //turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        //turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        //componentCode = dataRow.Field<decimal?>("componentCode")
                    }).ToList();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return detailsLst;
        }

        public PickupCodeDetails GetPickupCodeDetailsById(long id)
        {
            PickupCodeDetails details = new PickupCodeDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetPickupCodeDetailsById;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                    {
                        //id = dataRow.Field<long>("id"),
                        //componentType = dataRow.Field<string>("componentType"),
                        //locations = dataRow.Field<int?>("locations"),
                        //PickupCodeType = dataRow.Field<string>("PickupCodeType"),
                        //cylinders = dataRow.Field<int?>("cylinders"),
                        //motorDrive = dataRow.Field<string>("motorDrive"),
                        //motorFan = dataRow.Field<bool?>("motorFan"),
                        //motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        //drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        //drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        //motorPoles = dataRow.Field<int?>("motorPoles"),
                        //turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        //turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        //turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        //turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        //turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        //componentCode = dataRow.Field<decimal?>("componentCode")
                    }).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return details;
        }

        public long DeletePickupCodeDetailsById(long id)
        {
            long Id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spDeletePickupCodeDetailsById;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
                id = sqlRepository.ExecuteNonQuery(spName, allParams);
            }
            catch (Exception ex)
            {
                ex.ToString();
                return 0;
            }
            return Id;
        }

        public PickupCodeDetails GetPickupCodeDetails(string xml)
        {
            PickupCodeDetails details = new PickupCodeDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spCheckIsPickupCodeDetailsExist;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                    {
                        //id = dataRow.Field<long>("id"),
                        //componentType = dataRow.Field<string>("componentType"),
                        //locations = dataRow.Field<int?>("locations"),
                        //PickupCodeType = dataRow.Field<string>("PickupCodeType"),
                        //cylinders = dataRow.Field<int?>("cylinders"),
                        //motorDrive = dataRow.Field<string>("motorDrive"),
                        //motorFan = dataRow.Field<bool?>("motorFan"),
                        //motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        //drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        //drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        //motorPoles = dataRow.Field<int?>("motorPoles"),
                        //turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        //turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        //turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        //turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        //turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        //componentCode = dataRow.Field<decimal?>("componentCode")
                    }).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return details;
        }
    }
}
