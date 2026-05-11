using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public static class DbHelper
{
    private static readonly string ConnStr = GetConnectionString();

    private static string GetConnectionString()
    {
        var cs = ConfigurationManager.ConnectionStrings["RestaurantCentral"];
        if (cs != null) return cs.ConnectionString;
        var fallback = ConfigurationManager.AppSettings["RestaurantCentral"];
        if (!string.IsNullOrEmpty(fallback)) return fallback;
        throw new InvalidOperationException("Connection string 'RestaurantCentral' not found in configuration.");
    }

    public static int ExecuteNonQuery(string procName, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            using (SqlCommand cmd = new SqlCommand(procName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }

    public static DataTable ExecuteDataTable(string procName, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            using (SqlCommand cmd = new SqlCommand(procName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }
    }

    public static object ExecuteScalar(string procName, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            using (SqlCommand cmd = new SqlCommand(procName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }

    public static object ExecuteScalarText(string sql, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.CommandType = CommandType.Text;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }

    public static DataTable ExecuteRawQuery(string sql, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.CommandType = CommandType.Text;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
