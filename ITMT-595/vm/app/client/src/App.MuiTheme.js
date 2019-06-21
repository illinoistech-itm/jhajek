import { createMuiTheme } from '@material-ui/core/styles';

const theme = createMuiTheme({
  palette: {
    primary: {
      // light: will be calculated from palette.primary.main,
      main: '#0091ea'
      // dark: will be calculated from palette.primary.main,
      // contrastText: will be calculated to contrast with palette.primary.main
    },
    secondary: {
      main: '#d81b60'
      // dark: will be calculated from palette.secondary.main,
    }
    // error: will use the default color,
  },
  typography: {
    useNextVariants: true,
    htmlFontSize: 10,
    fontSize: 10
  }
});

export default theme;
