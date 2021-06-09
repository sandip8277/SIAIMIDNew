using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Coupling
{
    public class Coupling2Repository : ICoupling2Repository
    {
        private readonly ISQLRepository sqlRepository;
        public Coupling2Repository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateCoupling2Details(string xml)
        {
            long id = 0;
            string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateCoupling2Details;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public List<Coupling2Details> GetAllCoupling2Details(string componentType = null, string couplingType = null)
        {
            List<Coupling2Details> detailsLst = new List<Coupling2Details>();
            string spName = MIDDerivationLibrary.Models.Constants.spGetAllCoupling2Details;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.couplingType}", couplingType == null ? DBNull.Value : couplingType  )};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling2Details
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    couplingPosition = dataRow.Field<int?>("couplingPosition"),
                    couplingType = dataRow.Field<string>("couplingType"),
                    locations = dataRow.Field<int?>("locations"),
                    coupledComponentType1 = dataRow.Field<string>("coupledComponentType1"),
                    coupledComponentType2 = dataRow.Field<string>("coupledComponentType2"),
                    componentCode = dataRow.Field<decimal?>("componentCode")
                }).ToList();
            }
            return detailsLst;
        }
        public Coupling2Details GetCoupling2DetailsById(long id)
        {
            Coupling2Details details = new Coupling2Details();
            string spName = MIDDerivationLibrary.Models.Constants.spGetCoupling2DetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling2Details
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    couplingPosition = dataRow.Field<int?>("couplingPosition"),
                    couplingType = dataRow.Field<string>("couplingType"),
                    locations = dataRow.Field<int?>("locations"),
                    coupledComponentType1 = dataRow.Field<string>("coupledComponentType1"),
                    coupledComponentType2 = dataRow.Field<string>("coupledComponentType2"),
                    componentCode = dataRow.Field<decimal?>("componentCode")
                }).FirstOrDefault();
            }
            return details;
        }
        public long DeleteCoupling2DetailsById(long id)
        {
            string spName = MIDDerivationLibrary.Models.Constants.spDeleteCoupling2DetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public Coupling2Details GetCoupling2Details(string xml)
        {
            Coupling2Details details = new Coupling2Details();
            string spName = MIDDerivationLibrary.Models.Constants.spCheckIsCoupling2DetailsExist;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling2Details
                {
                    id = dataRow.Field<long>("id"),
                    componentType = dataRow.Field<string>("componentType"),
                    couplingPosition = dataRow.Field<int?>("couplingPosition"),
                    couplingType = dataRow.Field<string>("couplingType"),
                    locations = dataRow.Field<int?>("locations"),
                    coupledComponentType1 = dataRow.Field<string>("coupledComponentType1"),
                    coupledComponentType2 = dataRow.Field<string>("coupledComponentType2"),
                    componentCode = dataRow.Field<decimal?>("componentCode")
                }).FirstOrDefault();
            }
            return details;
        }
    }
}
