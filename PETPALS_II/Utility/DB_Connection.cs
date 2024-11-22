﻿
using Microsoft.Extensions.Configuration;
using System.IO;

namespace PETPALS_II.Utility
    {
        public class DBPropertyUtil
        {
            private static IConfiguration _configuration;

            static DBPropertyUtil()
            {
                LoadAppSettings();
            }

            private static void LoadAppSettings()
            {
                var builder = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())  // Set base path to current directory
                    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);  // Load settings from appsettings.json

                _configuration = builder.Build();  // Build configuration
            }

            public static string GetConnectionString(string name)
            {
                return _configuration.GetConnectionString(name);  // Fetch the connection string by name
            }

        internal static string? GetConnectionString()
        {
            throw new NotImplementedException();
        }
    }
    }



