using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
    public class Application
    {
        [STAThread]
        static void Main()
        {
            string path = Application.ExecutablePath;
            path = path.Remove(path.LastIndexOf(@"\"));

            Directory.SetCurrentDirectory(path + @"\sepek\bin");

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
}
