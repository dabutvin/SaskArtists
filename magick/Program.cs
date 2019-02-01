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
            var imageOptimizer = new ImageOptimizer
            {
                OptimalCompression = true,
                IgnoreUnsupportedFormats = true,
            };

            var files = Directory.EnumerateFiles(Path.GetFullPath("../www/"), "*.png", SearchOption.AllDirectories);
            Console.WriteLine($"start: {files.Count()}");
            var count = 0;
            Parallel.ForEach(files, file =>
            {
                count++;
                Console.WriteLine($"${count}: {file}");
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
    }
}
