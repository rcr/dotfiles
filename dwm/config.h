#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG)\
  { MODKEY,           KEY,  view,  {.ui=1 << TAG} },\
  { MODKEY|ShiftMask, KEY,  tag,   {.ui=1 << TAG} },

/* For status bar color from norm to sel -> dwm.c:~750s/sel/norm */
static const char normbordercolor[] = "#696969";
static const char normbgcolor[]     = "#262626";
static const char normfgcolor[]     = "#696969";
static const char selbordercolor[]  = "#696969";
static const char selbgcolor[]      = "#262626";
static const char selfgcolor[]      = "#e0e0e0";
static const char urgbgcolor[]      = "#c90000";

static const char font[]            = "-*-clean-medium-r-*-*-12-*-*-*-*-*-*-*";

static const unsigned int borderpx  = 1;
static const unsigned int snap      = 25;
static const Bool showbar           = True;
static const Bool topbar            = True; 

static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False;

static const char *tags[] = { "term", "net", "irc", "etc", "mutt"};
static const Layout layouts[] = {
  /* symbol  arrange function */
  { "~",     tile },    /* first entry is default */
  { "><",    NULL },    /* no layout function means floating behavior */
};

static const Rule rules[] = {
  /* class            instance    title       tags mask    isfloating   monitor */
  { NULL,             NULL,       "Floating", 0,           True,        -1 }, 
  { NULL,             NULL,       "Irc",      1 << 2,      False,       -1 }, 
  { NULL,             NULL,       "Mutt",     1 << 4,      False,       -1 }, 
};

/* commands */
static const char *browsercmd[]   = { "dwb" };
static const char *termcmd[]      = { "urxvtc", NULL };
static const char *floattermcmd[] = { "urxvtc", "-title", "Floating", "-geometry","90x24+300+200", NULL };
static const char *musiccmd[]     = { "urxvtc", "-title", "Floating", "-geometry","80x60+400+200","-e", "ncmpcpp", NULL };
static const char *prtscrcmd[]    = { "/home/robbinsr/scripts/printscreen", NULL };
static const char *togglemute[]   = { "/home/robbinsr/scripts/volctrl", "M", NULL };
static const char *voldown[]      = { "/home/robbinsr/scripts/volctrl", "D", NULL };
static const char *volup[]        = { "/home/robbinsr/scripts/volctrl", "U", NULL };

static Key keys[] = {
  /* modifier                     key        function        argument */
  { 0,                            XK_F2,     spawn,          {.v = floattermcmd } },
  { 0,                            XK_F3,     spawn,          {.v = termcmd } },
  { 0,                            XK_F4,     spawn,          {.v = musiccmd } },
  { 0,                            XK_F10,    spawn,          {.v = togglemute } }, 
  { 0,                            XK_F11,    spawn,          {.v = voldown } }, 
  { 0,                            XK_F12,    spawn,          {.v = volup } }, 
  { 0,                            XK_Print,  spawn,          {.v = prtscrcmd } },
  { MODKEY,                       XK_F2,     spawn,          {.v = browsercmd } },
  { MODKEY,                       XK_b,      togglebar,      {0} },
  { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY,                       XK_Return, zoom,           {0} },
  { MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~(1 << 1) } },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
/*
  { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_space,  setlayout,      {0} },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
*/
};

/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
