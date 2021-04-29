using Microsoft.VisualBasic;
using MIDDerivationLibrary.Models.DriverModels;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driver
{
    public class DriverRepository : IDriverRepository
    {
        private readonly ISQLRepository sqlRepository;

        public DriverRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateDriverDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateDriverDetails;
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

        public List<DriverDetails> GetAllDriverDetails(string componentType = null, string driverType = null)
        {
            List<DriverDetails> detailsLst = new List<DriverDetails>();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetAllDriverDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.driverType}", driverType == null ? DBNull.Value : driverType  )};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new DriverDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        driverType = dataRow.Field<string>("driverType"),
                        cylinders = dataRow.Field<int?>("cylinders"),
                        motorDrive = dataRow.Field<string>("motorDrive"),
                        motorFan = dataRow.Field<bool?>("motorFan"),
                        motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        mortorPoles = dataRow.Field<int?>("mortorPoles"),
                        turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        componentCode = dataRow.Field<decimal?>("componentCode")
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

        public DriverDetails GetDriverDetailsById(long id)
        {
            DriverDetails details = new DriverDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetDriverDetailsById;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new DriverDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        driverType = dataRow.Field<string>("driverType"),
                        cylinders = dataRow.Field<int?>("cylinders"),
                        motorDrive = dataRow.Field<string>("motorDrive"),
                        motorFan = dataRow.Field<bool?>("motorFan"),
                        motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        mortorPoles = dataRow.Field<int?>("mortorPoles"),
                        turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        componentCode = dataRow.Field<decimal?>("componentCode")
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

        public long DeleteDriverDetailsById(long id)
        {
            long Id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spDeleteDriverDetailsById;
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

        public DriverDetails GetDriverDetails(string xml)
        {
            DriverDetails details = new DriverDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spCheckIsDriverDetailsExist;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new DriverDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        driverType = dataRow.Field<string>("driverType"),
                        cylinders = dataRow.Field<int?>("cylinders"),
                        motorDrive = dataRow.Field<string>("motorDrive"),
                        motorFan = dataRow.Field<bool?>("motorFan"),
                        motorBallBearings = dataRow.Field<bool?>("motorBallBearings"),
                        drivenBallBearings = dataRow.Field<bool?>("drivenBallBearings"),
                        drivenBalanceable = dataRow.Field<bool?>("drivenBalanceable"),
                        mortorPoles = dataRow.Field<int?>("mortorPoles"),
                        turbineReductionGear = dataRow.Field<bool?>("turbineReductionGear"),
                        turbineRotorSupported = dataRow.Field<bool?>("turbineRotorSupported"),
                        turbineBallBearing = dataRow.Field<bool?>("turbineBallBearing"),
                        turbineThrustBearing = dataRow.Field<bool?>("turbineThrustBearing"),
                        turbineThrustBearingIsBall = dataRow.Field<bool?>("turbineThrustBearingIsBall"),
                        componentCode = dataRow.Field<decimal?>("componentCode")
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
