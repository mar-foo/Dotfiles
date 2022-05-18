/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int startwithgaps	    = 1;	 /* 1 means gaps are used by default */
static const unsigned int gappx     = 10;       /* default gap between windows in pixels */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "IBM Plex Mono:size=11", "FontAwesome:size=7" };
static const char dmenufont[]       = "IBM Plex Mono:size=11";
static const char col_gray1[]       = "#282828";
static const char col_gray2[]       = "#fb4934"; // "#ff004d";
static const char col_gray3[]       = "#d5c4a1";
static const char col_gray4[]       = "#fb4934"; // "#ff004d";
static const char col_cyan[]        = "#282828";
static const char col_occ[]         = "#98971a"; // "#008751";
static const char *colors[][4]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_occ   },
	[SchemeSel]  = { col_gray4, col_cyan,  col_gray2 },
	[SchemeOcc]  = { col_occ,   col_gray1, col_gray2 },
};

/* tagging
  * I - Terminal
  * II - Browser
  * III - Editor
  * IV - Misc
  */
static const char *tags[] = { "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	*/
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Firefox",  NULL,       NULL,       1 << 1,       0,           -1 },
	{ "mpv",       NULL,      NULL,       1 << 3,       0,           -1 },
	{ "acme",     NULL,       NULL,       1 << 2,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
	{ "|M|",      centeredmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]      = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray2, NULL };
static const char *ytcmd[]         = { "myyt", NULL };
static const char *termcmd[]       = { "st", NULL };
static const char scratchpadname[] = "music";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", "-e", "cmus", NULL };
static const char *lowervol[]      = { "amixer", "sset", "Master", "5%-", NULL };
static const char *raisevol[]      = { "amixer", "sset", "Master", "5%+", NULL };
static const char *webcmd[]        = { "firefox", NULL };
static const char *passcmd[]       = { "passmenu", NULL };

static Key keys[] = {
	/* modifier           key           function        argument */
	{ MODKEY,             XK_Return,    spawn,          {.v = termcmd} },
	{ MODKEY,             XK_minus,     spawn,          {.v = lowervol} },
	{ MODKEY,             XK_p,         spawn,          {.v = passcmd} },
	{ MODKEY,             XK_r,         spawn,          {.v = dmenucmd} },
	{ MODKEY,             XK_w,         spawn,          {.v = webcmd} },
	{ MODKEY,             XK_plus,      spawn,          {.v = raisevol} },
	{ MODKEY,             XK_y,         spawn,          {.v = ytcmd } },
	{ MODKEY,             XK_m,         togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,             XK_b,         togglebar,      {0} },
	{ MODKEY,             XK_j,         focusstack,     {.i = +1} },
	{ MODKEY,             XK_k,         focusstack,     {.i = -1} },
	{ MODKEY,             XK_i,         incnmaster,     {.i = +1} },
	{ MODKEY,             XK_d,         incnmaster,     {.i = -1} },
	{ MODKEY,             XK_h,         setmfact,       {.f = -0.05} },
	{ MODKEY,             XK_l,         setmfact,       {.f = +0.05} },
	{ MODKEY,             XK_space,     zoom,           {0} },
	{ MODKEY,             XK_Tab,       view,           {0} },
	{ MODKEY,             XK_q,         killclient,     {0} },
	{ MODKEY,             XK_t,         setlayout,      {.v = &layouts[0]} },
	{ MODKEY,             XK_f,         setlayout,      {.v = &layouts[2]} },
	{ MODKEY,             XK_x,         setlayout,      {.v = &layouts[3]} },
	{ MODKEY,             XK_c,         setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,   XK_space,     togglefloating, {0} },
	{ MODKEY,             XK_backslash, view,           {.ui = ~0} },
	{ MODKEY|ShiftMask,   XK_backslash, tag,            {.ui = ~0} },
	{ MODKEY,             XK_comma,     focusmon,       {.i = -1} },
	{ MODKEY,             XK_period,    focusmon,       {.i = +1} },
	{ MODKEY|ShiftMask,   XK_comma,     tagmon,         {.i = -1} },
	{ MODKEY|ShiftMask,   XK_period,    tagmon,         {.i = +1} },
	{ MODKEY,             XK_g,         setgaps,        {.i = GAP_TOGGLE} },
	TAGKEYS(              XK_a,                         0)
	TAGKEYS(              XK_o,                         1)
	TAGKEYS(              XK_e,                         2)
	TAGKEYS(              XK_u,                         3)
	{ MODKEY|ShiftMask,   XK_q,         quit,           {0} },
	{MODKEY|ShiftMask,    XK_r,         quit,           {1} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

