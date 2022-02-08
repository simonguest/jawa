import javax.tools.Diagnostic;
import javax.tools.DiagnosticCollector;
import javax.tools.JavaCompiler;
import javax.tools.JavaCompiler.CompilationTask;
import javax.tools.JavaFileObject;
import javax.tools.SimpleJavaFileObject;
import javax.tools.ToolProvider;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Arrays;

public class RuntimeCompiler {
  public static void main(String[] args) throws IOException {
    String file = args[0];
    System.out.print("Compiling " + file + "\n");
    JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
    int res = compiler.run(null, null, null, file);

    if (res == 0) {
      System.out.println("Compilation successful.");
      // try {

      //     URLClassLoader classLoader = URLClassLoader.newInstance(new URL[] { new File("").toURI().toURL() });
      //     Class.forName(package_uuid+".HelloWorld", true, classLoader).getDeclaredMethod("main", new Class[] { String[].class }).invoke(null, new Object[] { null });

      // } catch (ClassNotFoundException e) {
      //   System.err.println("Class not found: " + e);
      // } catch (NoSuchMethodException e) {
      //   System.err.println("No such method: " + e);
      // } catch (IllegalAccessException e) {
      //   System.err.println("Illegal access: " + e);
      // } catch (InvocationTargetException e) {
      //   System.err.println("Invocation target: " + e);
      // }
    } else {
      System.out.println("Compilation failed.");
    }
  }
}