using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.SpecialFaultCodes
{
    public class SpecialFaultCodesRepository : ISpecialFaultCodesRepository
    {
        private readonly ISQLRepository sqlRepository;
        public SpecialFaultCodesRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateSpecialFaultCodesDetails(string xml)
        {
            long id = 0;
            string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateSpecialFaultCodesDetails;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public List<SpecialFaultCodesDetails> GetAllSpecialFaultCodesDetails(string specialCode = null, string specialFaultCodesType = null)
        {
            List<SpecialFaultCodesDetails> detailsLst = new List<SpecialFaultCodesDetails>();
            string spName = MIDDerivationLibrary.Models.Constants.spGetAllSpecialFaultCodesDetails;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.specialFaultCodesType}", specialFaultCodesType == null ? DBNull.Value : specialFaultCodesType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.specialCode}", specialCode == null ? DBNull.Value : specialCode  )};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new SpecialFaultCodesDetails
                {
                    id = dataRow.Field<long>("id"),
                    specialfaultcodetype = dataRow.Field<string>("specialfaultcodetype"),
                    specialcode = dataRow.Field<string>("specialcode"),
                    specialmultiple = dataRow.Field<int?>("specialmultiple"),
                    componentType = dataRow.Field<string>("componentType"),
                    componentTypeSub1 = dataRow.Field<string>("componentTypeSub1"),
                    componentTypeSub2 = dataRow.Field<string>("componentTypeSub2")
                }).ToList();
            }
            return detailsLst;
        }
        public SpecialFaultCodesDetails GetSpecialFaultCodesDetailsById(long id)
        {
            SpecialFaultCodesDetails details = new SpecialFaultCodesDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spGetSpecialFaultCodesDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new SpecialFaultCodesDetails
                {
                    id = dataRow.Field<long>("id"),
                    specialfaultcodetype = dataRow.Field<string>("specialfaultcodetype"),
                    specialcode = dataRow.Field<string>("specialcode"),
                    specialmultiple = dataRow.Field<int?>("specialmultiple"),
                    componentType = dataRow.Field<string>("componentType"),
                    componentTypeSub1 = dataRow.Field<string>("componentTypeSub1"),
                    componentTypeSub2 = dataRow.Field<string>("componentTypeSub2")
                }).FirstOrDefault();
            }
            return details;
        }
        public long DeleteSpecialFaultCodesDetailsById(long id)
        {
            string spName = MIDDerivationLibrary.Models.Constants.spDeleteSpecialFaultCodesDetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }

        public SpecialFaultCodesDetails GetSpecialFaultCodesDetails(string xml)
        {
            SpecialFaultCodesDetails details = new SpecialFaultCodesDetails();
            string spName = MIDDerivationLibrary.Models.Constants.spCheckIsSpecialFaultCodesDetailsExist;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new SpecialFaultCodesDetails
                {
                    id = dataRow.Field<long>("id"),
                    specialfaultcodetype = dataRow.Field<string>("specialfaultcodetype"),
                    specialcode = dataRow.Field<string>("specialcode"),
                    specialmultiple = dataRow.Field<int?>("specialmultiple")
                }).FirstOrDefault();
            }
            return details;
        }
    }
}
