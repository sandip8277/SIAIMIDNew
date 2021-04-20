using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace MIDDerivationLibrary.Repository
{
    interface ISQLRepository
    {
        /// <summary>
        /// Execute stored procedure with parameters
        /// </summary>
        /// <param name="storedProcName">Procedure Name</param>
        /// <param name="parameters">Parameters</param>
        /// <returns>DataSet</returns>
        DataSet ExecuteQuery(string storedProcName, List<SqlParameter> parameters);

        /// <summary>
        /// Execute Non query for Add, Edit, Delete operations
        /// </summary>
        /// <param name="storedProcName">storedProcName</param>
        /// <param name="parameters">parameters</param>
        /// <returns>No of rows affected</returns>
        int ExecuteNonQuery(string storedProcName, List<SqlParameter> parameters);
    }
}
