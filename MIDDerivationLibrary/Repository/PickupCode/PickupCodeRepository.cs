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
            string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdatePickupCodeDetails;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public List<PickupCodeDetails> GetAllPickupCodeDetails()
        {
            List<PickupCodeDetails> detailsLst = new List<PickupCodeDetails>();
            string spName = MIDDerivationLibrary.Models.Constants.spGetAllPickupCodeDetails;
            List<SqlParameter> allParams = new List<SqlParameter>();
            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                {
                    id = dataRow.Field<int>("id"),
                    driverLocations = dataRow.Field<int>("driverLocations"),
                    driverLocationNDE = dataRow.Field<bool>("driverLocationNDE"),
                    driverLocationDE = dataRow.Field<bool>("driverLocationDE"),
                    intermediateLocations = dataRow.Field<int>("intermediateLocations"),
                    intermediatepresent = dataRow.Field<bool>("intermediatepresent"),
                    drivenLocations = dataRow.Field<int>("drivenLocations"),
                    drivenLocationDE = dataRow.Field<bool>("drivenLocationDE"),
                    drivenLocationNDE = dataRow.Field<bool>("drivenLocationNDE"),
                    driverPickupCode = dataRow.Field<string>("driverPickupCode"),
                    coupling1PickupCode = dataRow.Field<string>("coupling1PickupCode"),
                    intermediatePickupCode = dataRow.Field<string>("intermediatePickupCode"),
                    coupling2PickupCode = dataRow.Field<string>("coupling2PickupCode"),
                    drivenPickupCode = dataRow.Field<string>("drivenPickupCode")

                }).ToList();
            }
            return detailsLst;
        }
        public PickupCodeDetails GetPickupCodeDetailsById(long id)
        {
            PickupCodeDetails details = new PickupCodeDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spGetPickupCodeDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                {
                    id = dataRow.Field<int>("id"),
                    driverLocations = dataRow.Field<int>("driverLocations"),
                    driverLocationNDE = dataRow.Field<bool>("driverLocationNDE"),
                    driverLocationDE = dataRow.Field<bool>("driverLocationDE"),
                    intermediateLocations = dataRow.Field<int>("intermediateLocations"),
                    intermediatepresent = dataRow.Field<bool>("intermediatepresent"),
                    drivenLocations = dataRow.Field<int>("drivenLocations"),
                    drivenLocationDE = dataRow.Field<bool>("drivenLocationDE"),
                    drivenLocationNDE = dataRow.Field<bool>("drivenLocationNDE"),
                    driverPickupCode = dataRow.Field<string>("driverPickupCode"),
                    coupling1PickupCode = dataRow.Field<string>("coupling1PickupCode"),
                    intermediatePickupCode = dataRow.Field<string>("intermediatePickupCode"),
                    coupling2PickupCode = dataRow.Field<string>("coupling2PickupCode"),
                    drivenPickupCode = dataRow.Field<string>("drivenPickupCode")

                }).FirstOrDefault();
            }
            return details;
        }
        public long DeletePickupCodeDetailsById(long id)
        {
            string spName = MIDDerivationLibrary.Models.Constants.spDeletePickupCodeDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public PickupCodeDetails GetPickupCodeDetails(string xml)
        {
            PickupCodeDetails details = new PickupCodeDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spCheckIsPickupCodeDetailsExist;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new PickupCodeDetails
                {
                    id = dataRow.Field<int>("id"),
                    driverLocations = dataRow.Field<int>("driverLocations"),
                    driverLocationNDE = dataRow.Field<bool>("driverLocationNDE"),
                    driverLocationDE = dataRow.Field<bool>("driverLocationDE"),
                    intermediateLocations = dataRow.Field<int>("intermediateLocations"),
                    intermediatepresent = dataRow.Field<bool>("intermediatepresent"),
                    drivenLocations = dataRow.Field<int>("drivenLocations"),
                    drivenLocationDE = dataRow.Field<bool>("drivenLocationDE"),
                    drivenLocationNDE = dataRow.Field<bool>("drivenLocationNDE"),
                    driverPickupCode = dataRow.Field<string>("driverPickupCode"),
                    coupling1PickupCode = dataRow.Field<string>("coupling1PickupCode"),
                    intermediatePickupCode = dataRow.Field<string>("intermediatePickupCode"),
                    coupling2PickupCode = dataRow.Field<string>("coupling2PickupCode"),
                    drivenPickupCode = dataRow.Field<string>("drivenPickupCode")

                }).FirstOrDefault();
            }
            return details;
        }
    }
}
