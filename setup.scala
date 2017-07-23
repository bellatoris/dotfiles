import java.nio.file._
import scala.collection.immutable.HashMap
import sys.process._

object Main {

  // helper class for colorise console
  implicit class ConsoleColorise(val str: String) extends AnyVal {
    import Console._

    def black     = s"$BLACK$str$RESET"
    def red       = s"$RED$str$RESET"
    def green     = s"$GREEN$str$RESET"
    def yellow    = s"$YELLOW$str$RESET"
    def blue      = s"$BLUE$str$RESET"
    def magenta   = s"$MAGENTA$str$RESET"
    def cyan      = s"$CYAN$str$RESET"
    def white     = s"$WHITE$str$RESET"

    def blackBg   = s"$BLACK_B$str$RESET"
    def redBg     = s"$RED_B$str$RESET"
    def greenBg   = s"$GREEN_B$str$RESET"
    def yellowBg  = s"$YELLOW_B$str$RESET"
    def blueBg    = s"$BLUE_B$str$RESET"
    def magentaBg = s"$MAGENTA_B$str$RESET"
    def cyanBg    = s"$CYAN_B$str$RESET"
    def whiteBg   = s"$WHITE_B$str$RESET"
  }


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
      |""".red.stripMargin)

    install()
  }

  def install(): Unit = {
    val filesHere = new java.io.File(".").listFiles
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

    val postActions = List[String](
      // run vim-plug installation
      "vim +PlugInstall +qall"
    )

    doTask(tasks)
    doAction(postActions)
  }

  def doTask(tasks: HashMap[String, String]): Unit = {
    for ((target, source) <- tasks) {
      // normalize file path
      val currentPath = new java.io.File(".").getCanonicalPath()
      val sourcePath = Paths.get(currentPath, source)
      val targetPath = Paths.get(System.getProperty("user.home"), target)

      if (Files.exists(targetPath)) {
        if (Files.isSymbolicLink(targetPath)) {
          Files.delete(targetPath)
          Files.createSymbolicLink(targetPath, sourcePath)
          println(target.blue + " symlink created from ".green + sourcePath.toString().green)
        } else {
          println(target.blue + " already exists but not a symbolic link".magenta)
        }
      } else {
        Files.createSymbolicLink(targetPath, sourcePath)
        println(target.blue + " symlink created from ".green + sourcePath.toString().green)
      }
    }
  }

  def doAction(actions: List[String]): Unit = {
    for (action <- actions) {
      println("Execution: ".cyan + action.stripPrefix("").split("\n")(0))
      action.!
    }
  }

  def update(): Unit = {
  }
}
