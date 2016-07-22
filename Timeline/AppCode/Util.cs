using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace Timeline
{
    public class Util
    {
        public static string CultureName = "en-US";

        public static bool IsBlank(String str)
        {
            if (str == null) return true;
            return str.Length == 0;
        }

        public static bool IsInputBlank(String str)
        {
            if (IsBlank(str)) return true;
            return str.Replace("\"", "").Length == 0;
        }

        public static DateTime? StringToDateTime(String dateStr)
        {
            if (IsBlank(dateStr)) return null;

            DateTime MyDateTime = DateTime.ParseExact(dateStr, "MM/dd/yyyy HH:mm", CultureInfo.InvariantCulture);
            return MyDateTime;
        }

        public static DateTime? StringToDate(String dateStr)
        {
            if (IsBlank(dateStr)) return null;

            DateTime MyDateTime = DateTime.ParseExact(dateStr, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            return MyDateTime;
        }

        public static DateTime? StringToDateTimeHHmmSS(String dateStr)
        {
            if (IsBlank(dateStr)) return null;

            DateTime MyDateTime = DateTime.ParseExact(dateStr, "MM/dd/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
            return MyDateTime;
        }

        public static bool checkAllBlankInput(string[] inputs)
        {
            foreach (string input in inputs)
            {
                if (input != "") return false;
            }

            return true;
        }

        public static bool checkAllNotBlankInput(string[] inputs)
        {
            foreach (string input in inputs)
            {
                if (input == "") return false;
            }

            return true;
        }


    }
}