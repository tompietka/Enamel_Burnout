using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Windows;

namespace Enamel_Burnout
{

    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Result.Text = "";
            var path = Assembly.GetExecutingAssembly().Location;
            path = path.Remove(path.LastIndexOf(@"\", StringComparison.Ordinal));
            
            Directory.SetCurrentDirectory(path + @"\bin");
                  
            File.Delete("fakty.clp");

            var streamWriter = new StreamWriter("fakty.clp");

            streamWriter.WriteLine("(defglobal ?*zmTemperatura* = " + TxtBoxTemperatura.Text + " )");
            streamWriter.WriteLine("(defglobal ?*zmCzas* = " + TxtBoxCzas.Text + " )");

            streamWriter.Close();

            Process.Start("jessfuzzy.bat", "fuz.clp");

        }


        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Result.Text = File.ReadAllText("wyniki.txt");

        }
    }
}
