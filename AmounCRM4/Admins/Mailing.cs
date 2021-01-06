using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace AmounCRM4.Admins
{
    public class Mailing
    {
        public void ECMS_Mailing(string fromMail, string toMail, string subjectText, string bodyText)
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toMail);
            mail.From = new MailAddress(fromMail);
            mail.Subject = subjectText;
            mail.Body = bodyText;
            mail.Priority = MailPriority.High;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.amoun.com"; //Or Your SMTP Server Address
            smtp.Port = 25;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("username", "password");
            smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            smtp.EnableSsl = true;
            smtp.Send(mail);
        }
    }
}