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
      "/.bashrc" -> "bashrc",
      // "/.bash_profile" -> "bash_profile",

      // vim
      "/.vimrc" -> "vim/vimrc",
      "/.vim" -> "vim",
      "/.vim/autoload/plug.vim" -> "vim/bundle/vim-plug/plug.vim",

      // NeoVIM
      "/.config/nvim" -> "nvim",

      // tmux
      "/.tmux" -> "tmux",
      "/.tmux.conf" -> "tmux/tmux.conf",
      "/.tmux-macOS.conf" -> "tmux/tmux-macOS.conf"
    )

    val postActions = List[String](
      // run vim-plug installation
      "vim +PlugInstall +qall",

      // run Powerlin fonts installation
      "bash .dotfiles/vim/fonts/install.sh"
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

      if (Files.isSymbolicLink(targetPath)) {
        // unlink the target
        Files.delete(targetPath)
      } else if (Files.exists(targetPath)) {
        println(target.blue + " already exists but not a symbolic link".magenta)
      }

      if (!Files.exists(targetPath)) {
        try {
          val targetDir = targetPath.getParent()
          Files.createDirectory(targetDir)
          println("Created directory: ".green + targetDir.toString().green)
        } catch {
          case _ => ""
        }

        Files.createSymbolicLink(targetPath, sourcePath)
        println(target.blue + " symlink created from ".green +
          sourcePath.toString().green)
      }
    }
  }

  def doAction(actions: List[String]): Unit = {
    for (action <- actions) {
      println("Execution: ".cyan + action.stripMargin.split("\n")(0))
      val homeDir = new java.io.File(System.getProperty("user.home"))
      val result = Process(action, homeDir).!!
      println(result)
    }
  }

  def update(): Unit = {
  }
}
