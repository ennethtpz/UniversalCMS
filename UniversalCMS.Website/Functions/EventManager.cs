using ReinST.Central.DataManagement;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UniversalCMS.Website.Objects;

namespace UniversalCMS.Website.Functions
{
    public class EventManager
    {
        string _connStringKey;

        public EventManager()
        {

            _connStringKey = "conn";
        }

        public Event GetEventByTitle(string title)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@title", title)
                                       };

                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Events WHERE [title]=@title", param))
                    {
                        return GetEventFromDataRow(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Event GetEvent(int eventId)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@eventId", eventId)
                                       };

                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Events WHERE [eventId]=@eventId", param))
                    {
                        return GetEventFromDataRow(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static Event GetEventFromDataRow(DataRow row)
        {
            try
            {
                var eventObj = new Event()
                {
                    EventId = Convert.ToInt32(row["eventId"]),
                    Title = Convert.ToString(row["title"]),
                    ImgBanner = Convert.ToString(row["imgBanner"]),
                    RegistrationStartDate = Convert.ToDateTime(row["registrationStartDate"]),
                    RegistrationEndDate = Convert.ToDateTime(row["registrationEndDate"]),
                    EventStartDate = Convert.ToDateTime(row["eventStartDate"]),
                    EventEndDate = Convert.ToDateTime(row["eventEndDate"]),
                    DownloadLink = Convert.ToString(row["downloadLink"]),
                    RegistrationLink = Convert.ToString(row["registrationLink"]),
                    Venue = Convert.ToString(row["venue"]),
                    Location = Convert.ToString(row["location"]),
                    Week = Convert.ToString(row["week"]),
                    DateAdded = Convert.ToDateTime(row["dateAdded"])
                };

                return eventObj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
