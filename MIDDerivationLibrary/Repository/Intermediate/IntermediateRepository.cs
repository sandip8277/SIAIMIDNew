using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Intermediate
{
    public class IntermediateRepository : IIntermediateRepository
    {
        private readonly ISQLRepository sqlRepository;
        public IntermediateRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateIntermediateDetails(string xml)
        {
            long id = 0;
            string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateIntermediateDetails;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public List<IntermediateDetails> GetAllIntermediateDetails(string componentType = null, string intermediateType = null)
        {
            List<IntermediateDetails> detailsLst = new List<IntermediateDetails>();
            string spName = MIDDerivationLibrary.Models.Constants.spGetAllIntermediateDetails;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.intermediateType}", intermediateType == null ? DBNull.Value : intermediateType  )};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new IntermediateDetails
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    intermediateType = dataRow.Field<string>("intermediateType"),
                    locations = dataRow.Field<int?>("locations"),
                    drivenBy = dataRow.Field<string>("drivenBy"),
                    speedChangesMax = dataRow.Field<int?>("speedChangesMax"),
                    componentCode = dataRow.Field<decimal?>("componentCode")

                }).ToList();
            }
            return detailsLst;
        }
        public IntermediateDetails GetIntermediateDetailsById(long id)
        {
            IntermediateDetails details = new IntermediateDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spGetIntermediateDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new IntermediateDetails
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    intermediateType = dataRow.Field<string>("intermediateType"),
                    locations = dataRow.Field<int?>("locations"),
                    drivenBy = dataRow.Field<string>("drivenBy"),
                    speedChangesMax = dataRow.Field<int?>("speedChangesMax"),
                    componentCode = dataRow.Field<decimal?>("componentCode")

                }).FirstOrDefault();
            }
            return details;
        }
        public long DeleteIntermediateDetailsById(long id)
        {
            string spName = MIDDerivationLibrary.Models.Constants.spDeleteIntermediateDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public IntermediateDetails GetIntermediateDetails(string xml)
        {
            IntermediateDetails details = new IntermediateDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spCheckIsIntermediateDetailsExist;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new IntermediateDetails
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    intermediateType = dataRow.Field<string>("intermediateType"),
                    locations = dataRow.Field<int?>("locations"),
                    drivenBy = dataRow.Field<string>("drivenBy"),
                    speedChangesMax = dataRow.Field<int?>("speedChangesMax"),
                    componentCode = dataRow.Field<decimal?>("componentCode")

                }).FirstOrDefault();
            }
            return details;
        }
    }
}
