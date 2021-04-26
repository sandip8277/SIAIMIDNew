using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository
{
    //public sealed class SQLRepository : ISQLRepository
    public class SQLRepository : ISQLRepository
    {
        private IConfiguration Configuration;

        public  SQLRepository(IConfiguration _configuration)
        {
            Configuration = _configuration;
        }
       


        /// <summary>
        /// Get sql connection
        /// </summary>
        /// <returns>SqlConnection</returns>
        private SqlConnection GetConnection()
        {
            string connectionString = this.Configuration.GetConnectionString("DefaultConnection");
            SqlConnection sqlConnection = new SqlConnection(connectionString);
            sqlConnection.Open();
            return sqlConnection;
        }

        /// <summary>
        /// Execute stored procedure with parameters
        /// </summary>
        /// <param name="storedProcName">Procedure Name</param>
        /// <param name="parameters">Parameters</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteQuery(string storedProcName, List<SqlParameter> parameters)
        {
            DataSet dataSet = new DataSet();

            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = storedProcName;
                        //assign parameters passed in to the command
                        foreach (object parameter in parameters)
                        {
                            command.Parameters.Add(parameter);
                        }
                        using (SqlDataAdapter da = new SqlDataAdapter(command))
                        {
                            da.Fill(dataSet);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return dataSet;
        }

        /// <summary>
        /// Execute Non query for Add, Edit, Delete operations
        /// </summary>
        /// <param name="storedProcName">storedProcName</param>
        /// <param name="parameters">parameters</param>
        /// <returns>No of rows affected</returns>
        public long ExecuteNonQuery(string storedProcName, List<SqlParameter> parameters)
        {
            long rowCount;
            using (SqlConnection connection = GetConnection())
            {
                // create a SQL command to execute the stored procedure
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = storedProcName;
                    // assign parameters passed in to the command
                    foreach (object parameter in parameters)
                    {
                        command.Parameters.Add(parameter);
                    }
                   // rowCount = command.ExecuteNonQuery();
                    rowCount = Convert.ToInt64(command.ExecuteScalar());
                }
            }
            return rowCount;
        }

    }
}
