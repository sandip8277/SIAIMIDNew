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
        private static readonly object objlock = new object();
        private static SQLRepository sqlRepository;
        private IConfiguration Configuration;
        // private string _connectionString;


        public SQLRepository(IConfiguration _configuration)
        {
            Configuration = _configuration;
        }
        /// <summary>
        /// Singleton instance
        /// </summary>
        public static SQLRepository Instance
        {
            get
            {
                if (null == sqlRepository)
                {
                    lock (objlock)
                    {
                        if (null == sqlRepository)
                        {
                            sqlRepository = new SQLRepository();
                        }
                    }
                }
                return sqlRepository;
            }
        }

        //Add singleton method to get only one instance
        private SQLRepository() { }


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
        public int ExecuteNonQuery(string storedProcName, List<SqlParameter> parameters)
        {
            int rowCount;
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
                    rowCount = command.ExecuteNonQuery();
                }
            }
            return rowCount;
        }

    }
}
