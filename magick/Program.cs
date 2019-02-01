using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using ImageMagick;

namespace magick
{
    class Program
    {
        static void Main(string[] args)
        {
            MagickNET.SetLogEvents(LogEvents.All);
            MagickNET.Log += ConsoleLog;
            var imageOptimizer = new ImageOptimizer();
            var files = Directory.EnumerateFiles(Path.GetFullPath("../www/artists/rarnott/images"), "*.jpg", SearchOption.AllDirectories);
            Parallel.ForEach(files, file =>
            {
                Console.WriteLine(file);
                try
                {
                    imageOptimizer.LosslessCompress(new FileInfo(file));
                }
                catch
                {
                    // ignore
                }
            });
            Console.WriteLine("finished!!");
        }

        static void ConsoleLog(object sender, LogEventArgs e)
        {
            Console.WriteLine(e.Message);
        }
    }
}
