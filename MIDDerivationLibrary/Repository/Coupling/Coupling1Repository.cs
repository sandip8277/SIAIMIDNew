using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Coupling
{
    public class Coupling1Repository : ICoupling1Repository
    {
        private readonly ISQLRepository sqlRepository;
        public Coupling1Repository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateCoupling1Details(string xml)
        {
            long id = 0;
            string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateCoupling1Details;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public List<Coupling1Details> GetAllCoupling1Details(string componentType = null, string couplingType = null)
        {
            List<Coupling1Details> detailsLst = new List<Coupling1Details>();
            string spName = MIDDerivationLibrary.Models.Constants.spGetAllCoupling1Details;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType == null ? DBNull.Value : componentType ),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.couplingType}", couplingType == null ? DBNull.Value : couplingType  )};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling1Details
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
        public Coupling1Details GetCoupling1DetailsById(long id)
        {
            Coupling1Details details = new Coupling1Details();
            string spName = MIDDerivationLibrary.Models.Constants.spGetCoupling1DetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling1Details
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
        public long DeleteCoupling1DetailsById(long id)
        {
            string spName = MIDDerivationLibrary.Models.Constants.spDeleteCoupling1DetailsById;
            List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
            id = sqlRepository.ExecuteNonQuery(spName, allParams);
            return id;
        }
        public Coupling1Details GetCoupling1Details(string xml)
        {
            Coupling1Details details = new Coupling1Details();
            string spName = MIDDerivationLibrary.Models.Constants.spCheckIsCoupling1DetailsExist;
            List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

            DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                details = result.Tables[0].AsEnumerable().Select(dataRow => new Coupling1Details
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
