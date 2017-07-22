import java.io._
import java.nio.file._
import scala.collection.immutable.HashMap

object Main {
  /*
  implicit class ConsoleColorise(val str: String) extends AnyVal {
    import Console._

    def black     = s"$BLACK$str"
    def red       = s"$RED$str"
    def green     = s"$GREEN$str"
    def yellow    = s"$YELLOW$str"
    def blue      = s"$BLUE$str"
    def magenta   = s"$MAGENTA$str"
    def cyan      = s"$CYAN$str"
    def white     = s"$WHITE$str"

    def blackBg   = s"$BLACK_B$str"
    def redBg     = s"$RED_B$str"
    def greenBg   = s"$GREEN_B$str"
    def yellowBg  = s"$YELLOW_B$str"
    def blueBg    = s"$BLUE_B$str"
    def magentaBg = s"$MAGENTA_B$str"
    def cyanBg    = s"$CYAN_B$str"
    def whiteBg   = s"$WHITE_B$str"
  }
  */

  def main(args: Array[String]): Unit = {
    print("""
      |@bellator's              ███████╗██╗██╗     ███████╗███████╗
      |██████╗  █████╗ ████████╗██╔════╝██║██║     ██╔════╝██╔════╝
      |██╔══██╗██╔══██╗╚══██╔══╝█████╗  ██║██║     █████╗  ███████╗
      |██║  ██║██║  ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
      |██████╔╝╚█████╔╝   ██║   ██║     ██║███████╗███████╗███████║
      |╚═════╝  ╚═════╝   ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
      |
      |https://github.com/bellatoris/dotfiles
      |""".stripMargin)

    install()
  }

  def install(): Unit = {
    val filesHere = (new File(".")).listFiles 
    val tasks = HashMap[String, String](
      // shell
      // "/.bashrc" -> "bashrc",

      // vim
      "/.vimrc" -> "vim/vimrc",
      "/.vim" -> "vim",
      // "/.vim/autoload/plug.vim" -> "vim/bundle/vim-plug/plug.vim",

      // tmux
      "/.tmux" -> "tmux",
      "/.tmux.conf" -> "tmux/tmux.conf"
    )

    val postActions = (
      // run vim-plug installation
      "vim +PlugInstall +qall"
    )

    doTask(tasks)
  }

  def doTask(tasks: HashMap[String, String]): Unit = {
    for ((target, source) <- tasks) {
      // normalize file path
      val currentPath = new File(".").getCanonicalPath()
      val sourcePath = Paths.get(currentPath, source)
      val targetPath = Paths.get(System.getProperty("user.home"), target)
      
      if (Files.exists(targetPath)) {
        if (Files.isSymbolicLink(targetPath)) {
          Files.delete(targetPath)
          Files.createSymbolicLink(targetPath, sourcePath)
          println(target + " symlink created from " + sourcePath.toString())
        } else {
          println(target + " already exists but not a symbolic link")
        }
      } else {
        Files.createSymbolicLink(targetPath, sourcePath)
        println(target + " symlink created from " + sourcePath.toString())
      }
    }
  }

  def update(): Unit = {
  }
}
