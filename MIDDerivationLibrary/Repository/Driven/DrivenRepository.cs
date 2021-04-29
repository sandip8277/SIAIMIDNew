using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driven
{
    public class DrivenRepository : IDrivenRepository
    {
        private readonly ISQLRepository sqlRepository;

        public DrivenRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }

        public long AddOrUpdateDrivenDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateDrivenDetails;
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

        public List<DrivenDetails> GetAllDrivenDetails(string componentType = null, string drivenType = null)
        {
            List<DrivenDetails> detailsLst = new List<DrivenDetails>();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetAllDrivenDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.drivenType}", drivenType == null ? DBNull.Value : drivenType  )};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new DrivenDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        drivenType = dataRow.Field<string>("drivenType"),
                        pumpType = dataRow.Field<string>("pumpType"),
                        compressorType = dataRow.Field<string>("compressorType"),
                        fan_or_blowerType = dataRow.Field<string>("fan_or_blowerType"),
                        purifierDrivenBy = dataRow.Field<string>("purifierDrivenBy"),
                        bearingType = dataRow.Field<string>("bearingType"),
                        col_cType = dataRow.Field<string>("col_cType"),
                        rotorOverhung = dataRow.Field<bool?>("rotorOverhung"),
                        attachedOilPump = dataRow.Field<bool?>("attachedOilPump"),
                        impellerOnMainShaft = dataRow.Field<bool?>("impellerOnMainShaft"),
                        crankHasIntermediateBearing = dataRow.Field<bool?>("crankHasIntermediateBearing"),
                        fanStages = dataRow.Field<bool?>("fanStages"),
                        exciter = dataRow.Field<bool?>("exciter"),
                        centrifugalPumpHasBallBearings = dataRow.Field<bool?>("centrifugalPumpHasBallBearings"),
                        propellerpumpHasBallBearings = dataRow.Field<bool?>("propellerpumpHasBallBearings"),
                        rotaryThreadPumpHasBallBearings = dataRow.Field<bool?>("rotaryThreadPumpHasBallBearings"),
                        gearPumpHasBallBearings = dataRow.Field<bool?>("gearPumpHasBallBearings"),
                        screwPumpHasBallBearings = dataRow.Field<bool?>("screwPumpHasBallBearings"),
                        slidingVanePumpHasBallBearings = dataRow.Field<bool?>("slidingVanePumpHasBallBearings"),
                        axialRecipPumpHasBallBearings = dataRow.Field<bool?>("axialRecipPumpHasBallBearings"),
                        centrifugalCompressorHasBallBearings = dataRow.Field<bool?>("centrifugalCompressorHasBallBearings"),
                        reciprocatingCompressorHasBallBearings = dataRow.Field<bool?>("reciprocatingCompressorHasBallBearings"),
                        screwCompressorHasBallBearings = dataRow.Field<bool?>("screwCompressorHasBallBearings"),
                        screwTwinCompressorHasBallBearingsOnHPSide = dataRow.Field<bool?>("screwTwinCompressorHasBallBearingsOnHPSide"),
                        lobedFanOrBlowerHasBallBearings = dataRow.Field<bool?>("lobedFanOrBlowerHasBallBearings"),
                        overhungRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("overhungRotorFanOrBlowerHasBearings"),
                        supportedRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("supportedRotorFanOrBlowerHasBearings"),
                        exciterOverhungOrSupported = dataRow.Field<string>("exciterOverhungOrSupported"),
                        bearingsType = dataRow.Field<string>("bearingsType"),
                        thrustBearing = dataRow.Field<string>("thrustBearing"),
                        drivenBy = dataRow.Field<string>("drivenBy"),
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

        public DrivenDetails GetDrivenDetailsById(long id)
        {
            DrivenDetails details = new DrivenDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetDrivenDetailsById;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new DrivenDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        drivenType = dataRow.Field<string>("drivenType"),
                        pumpType = dataRow.Field<string>("pumpType"),
                        compressorType = dataRow.Field<string>("compressorType"),
                        fan_or_blowerType = dataRow.Field<string>("fan_or_blowerType"),
                        purifierDrivenBy = dataRow.Field<string>("purifierDrivenBy"),
                        bearingType = dataRow.Field<string>("bearingType"),
                        col_cType = dataRow.Field<string>("col_cType"),
                        rotorOverhung = dataRow.Field<bool?>("rotorOverhung"),
                        attachedOilPump = dataRow.Field<bool?>("attachedOilPump"),
                        impellerOnMainShaft = dataRow.Field<bool?>("impellerOnMainShaft"),
                        crankHasIntermediateBearing = dataRow.Field<bool?>("crankHasIntermediateBearing"),
                        fanStages = dataRow.Field<bool?>("fanStages"),
                        exciter = dataRow.Field<bool?>("exciter"),
                        centrifugalPumpHasBallBearings = dataRow.Field<bool?>("centrifugalPumpHasBallBearings"),
                        propellerpumpHasBallBearings = dataRow.Field<bool?>("propellerpumpHasBallBearings"),
                        rotaryThreadPumpHasBallBearings = dataRow.Field<bool?>("rotaryThreadPumpHasBallBearings"),
                        gearPumpHasBallBearings = dataRow.Field<bool?>("gearPumpHasBallBearings"),
                        screwPumpHasBallBearings = dataRow.Field<bool?>("screwPumpHasBallBearings"),
                        slidingVanePumpHasBallBearings = dataRow.Field<bool?>("slidingVanePumpHasBallBearings"),
                        axialRecipPumpHasBallBearings = dataRow.Field<bool?>("axialRecipPumpHasBallBearings"),
                        centrifugalCompressorHasBallBearings = dataRow.Field<bool?>("centrifugalCompressorHasBallBearings"),
                        reciprocatingCompressorHasBallBearings = dataRow.Field<bool?>("reciprocatingCompressorHasBallBearings"),
                        screwCompressorHasBallBearings = dataRow.Field<bool?>("screwCompressorHasBallBearings"),
                        screwTwinCompressorHasBallBearingsOnHPSide = dataRow.Field<bool?>("screwTwinCompressorHasBallBearingsOnHPSide"),
                        lobedFanOrBlowerHasBallBearings = dataRow.Field<bool?>("lobedFanOrBlowerHasBallBearings"),
                        overhungRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("overhungRotorFanOrBlowerHasBearings"),
                        supportedRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("supportedRotorFanOrBlowerHasBearings"),
                        exciterOverhungOrSupported = dataRow.Field<string>("exciterOverhungOrSupported"),
                        bearingsType = dataRow.Field<string>("bearingsType"),
                        thrustBearing = dataRow.Field<string>("thrustBearing"),
                        drivenBy = dataRow.Field<string>("drivenBy"),
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

        public long DeleteDrivenDetailsById(long id)
        {
            long Id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spDeleteDrivenDetailsById;
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

        public DrivenDetails GetDrivenDetails(string xml)
        {
            DrivenDetails details = new DrivenDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spCheckIsDrivenDetailsExist;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new DrivenDetails
                    {
                        id = dataRow.Field<long>("id"),
                        componentType = dataRow.Field<string>("componentType"),
                        locations = dataRow.Field<int?>("locations"),
                        drivenType = dataRow.Field<string>("drivenType"),
                        pumpType = dataRow.Field<string>("pumpType"),
                        compressorType = dataRow.Field<string>("compressorType"),
                        fan_or_blowerType = dataRow.Field<string>("fan_or_blowerType"),
                        purifierDrivenBy = dataRow.Field<string>("purifierDrivenBy"),
                        bearingType = dataRow.Field<string>("bearingType"),
                        col_cType = dataRow.Field<string>("col_cType"),
                        rotorOverhung = dataRow.Field<bool?>("rotorOverhung"),
                        attachedOilPump = dataRow.Field<bool?>("attachedOilPump"),
                        impellerOnMainShaft = dataRow.Field<bool?>("impellerOnMainShaft"),
                        crankHasIntermediateBearing = dataRow.Field<bool?>("crankHasIntermediateBearing"),
                        fanStages = dataRow.Field<bool?>("fanStages"),
                        exciter = dataRow.Field<bool?>("exciter"),
                        centrifugalPumpHasBallBearings = dataRow.Field<bool?>("centrifugalPumpHasBallBearings"),
                        propellerpumpHasBallBearings = dataRow.Field<bool?>("propellerpumpHasBallBearings"),
                        rotaryThreadPumpHasBallBearings = dataRow.Field<bool?>("rotaryThreadPumpHasBallBearings"),
                        gearPumpHasBallBearings = dataRow.Field<bool?>("gearPumpHasBallBearings"),
                        screwPumpHasBallBearings = dataRow.Field<bool?>("screwPumpHasBallBearings"),
                        slidingVanePumpHasBallBearings = dataRow.Field<bool?>("slidingVanePumpHasBallBearings"),
                        axialRecipPumpHasBallBearings = dataRow.Field<bool?>("axialRecipPumpHasBallBearings"),
                        centrifugalCompressorHasBallBearings = dataRow.Field<bool?>("centrifugalCompressorHasBallBearings"),
                        reciprocatingCompressorHasBallBearings = dataRow.Field<bool?>("reciprocatingCompressorHasBallBearings"),
                        screwCompressorHasBallBearings = dataRow.Field<bool?>("screwCompressorHasBallBearings"),
                        screwTwinCompressorHasBallBearingsOnHPSide = dataRow.Field<bool?>("screwTwinCompressorHasBallBearingsOnHPSide"),
                        lobedFanOrBlowerHasBallBearings = dataRow.Field<bool?>("lobedFanOrBlowerHasBallBearings"),
                        overhungRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("overhungRotorFanOrBlowerHasBearings"),
                        supportedRotorFanOrBlowerHasBearings = dataRow.Field<bool?>("supportedRotorFanOrBlowerHasBearings"),
                        exciterOverhungOrSupported = dataRow.Field<string>("exciterOverhungOrSupported"),
                        bearingsType = dataRow.Field<string>("bearingsType"),
                        thrustBearing = dataRow.Field<string>("thrustBearing"),
                        drivenBy = dataRow.Field<string>("drivenBy"),
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
