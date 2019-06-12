

https://docs.microsoft.com/ja-jp/dotnet/framework/wpf/getting-started/walkthrough-my-first-wpf-desktop-application

Windows Presentation Foundation (WPF)
Extensible Application Markup Language (XAML)


# Components
- DataGrid
  Show data in table
- 


textBox.Text = “Hello”;

WPFでの例：

MainWindow.xaml：
<TextBox Text=”{Binding Path=Txt}”>
1
	
<TextBox Text=”{Binding Path=Txt}”>

ViewModel.cs:
public class ViewModel {
    public string Txt { get; set; } = "Hello";
}
1
2
3
	
public class ViewModel {
    public string Txt { get; set; } = "Hello";
}

