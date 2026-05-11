using System;
using System.Data;
using System.Data.SqlClient;

class Program {
    static void Main() {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;Initial Catalog=RestaurantCentral;Integrated Security=True";
        using (SqlConnection conn = new SqlConnection(connStr)) {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('vw_Chef_Queue')", conn);
            object def = cmd.ExecuteScalar();
            Console.WriteLine("vw_Chef_Queue Definition:");
            Console.WriteLine(def ?? "Not found");

            cmd.CommandText = "SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('vw_Waiter_Board')";
            def = cmd.ExecuteScalar();
            Console.WriteLine("\nvw_Waiter_Board Definition:");
            Console.WriteLine(def ?? "Not found");
        }
    }
}
