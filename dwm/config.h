	/* See LICENSE file for copyright and license details. */

	/* appearance */
	static const unsigned int borderpx  = 1;        /* border pixel of windows */
	static const unsigned int gappx     = 10;        /* gaps between windows */
	static const unsigned int snap      = 32;       /* snap pixel */
	static const int showbar            = 1;        /* 0 means no bar */
	static const int topbar             = 1;        /* 0 means bottom bar */
	static const char *fonts[]          = { "Fira Code:size=9", "Font Awesome"};
	static const char dmenufont[]       = "Fira Code:size=9";
	static const char col_gray1[]       = "#000000";
	static const char col_gray2[]       = "#1e1e1e";
	static const char col_gray3[]       = "#ffffff";
	static const char col_gray4[]       = "#ffffff";
	static const char col_cyan[]        = "#f95006";
	static const char *colors[][3]      = {
		/*               fg         bg         border   */
		[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
		[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	};

	/* tagging */
	#define MAX_TAGLEN 16
	static char tags[][MAX_TAGLEN] = { "", "", "", "", "", "", "", "", "", };

	static const Rule rules[] = {
		/* xprop(1):
		 *	WM_CLASS(STRING) = instance, class
		 *	WM_NAME(STRING) = title
		 */
		/* class         instance    title                                     tags mask     switch to tag,  isfloating   monitor */
		{ "Gimp",        NULL,       NULL,                                     1<<6,              1,	      0,           -1 },
		{ "qutebrowser", NULL,	     NULL,	                               1<<2,		  1,          0,	   -1 },
		{ "Abrowser",    NULL,	     NULL,	                               1<<2,	 	  1,	      0,	   -1 },
		{ "Tor Browser", NULL,       NULL,                                     1<<2,              1,          0,           -1 },
		{ NULL,	         NULL,       "/home/mario/.local/bin/scripts/play.sh", 1<<4,              1,          0,           -1 },
		{ NULL,	         NULL,       "vifm",                                   1<<1,		  1,          0,	   -1 },

	};

	/* layout(s) */
	static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
	static const int nmaster     = 1;    /* number of clients in master area */
	static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster }, /*centered master layout*/

};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      comboview,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      combotag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run","-i", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd []  = { "st", NULL };
//My bindings
//System
static const char *shutcmd []  = { "/home/mario/.local/bin/scripts/shtdwn.sh", NULL };
static const char *lockcmd []  = { "/home/mario/.local/bin/scripts/lock", NULL };
//Shortcuts
static const char *webcmd  []  = { "/home/mario/.local/bin/scripts/bookmarks.sh", NULL };
static const char *vifmcmd []  = { "st", "vifm", "/home/mario/Documents/University", "/home/mario", NULL };
static const char *confcmd []  = { "/home/mario/.local/bin/scripts/config_files.sh", NULL};
static const char *emacscmd[]  = { "emacs", NULL};
static const char *otticmd []  = { "/home/mario/.local/bin/scripts/Lab_ottica.sh", NULL};
static const char *brwscmd []  = { "torbrowser-launcher" , NULL };
//Music
static const char *musicmd []  = { "st", "/home/mario/.local/bin/scripts/play.sh" , NULL };
static const char *pausecmd[]  = { "mocp", "-P", NULL};
static const char *playcmd []  = { "mocp", "-U", NULL };
static const char *stopcmd []  = { "mocp", "-s", NULL };
static const char *nextcmd []  = { "mocp", "-f", NULL };
static const char *prevcmd []  = { "mocp", "-r", NULL };
//Volume
static const char *volcmd  []  = { "st", "alsamixer", NULL};
static const char *pluscmd []  = { "amixer", "sset", "Master", "5%+", NULL };
static const char *minuscmd[]  = { "amixer", "sset", "Master", "5%-", NULL };
static const char *mutecmd []  = { "amixer", "sset", "Master", "0%" , NULL };

#include "movestack.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	//My own bindings:
	//System
	{ MODKEY,		  	XK_BackSpace, spawn,	   {.v = shutcmd } },
	{ MODKEY|ShiftMask,		XK_BackSpace, spawn,	   {.v = lockcmd } },
	//Shortcuts
	{ MODKEY,			XK_s,      spawn,	   {.v = webcmd  } },
	{ MODKEY|ShiftMask,		XK_x,      spawn,	   {.v = vifmcmd } },
	{ MODKEY,			XK_c,	   spawn,	   {.v = confcmd } },
	{ MODKEY,			XK_e,	   spawn,	   {.v = emacscmd} },
	{ MODKEY,			XK_o,	   spawn,	   {.v = otticmd } },
	{ MODKEY,			XK_z,	   spawn,	   {.v = brwscmd } },
	//Music and volume
	{ MODKEY|ControlMask,	 	XK_space,  spawn,	   {.v = musicmd } },
	{ MODKEY,			XK_p,	   spawn, 	   {.v = pausecmd} },
	{ MODKEY|ShiftMask,		XK_p,	   spawn,	   {.v = playcmd } },
	{ MODKEY,			XK_q,	   spawn,	   {.v = stopcmd } },
	{ MODKEY,			XK_n,	   spawn, 	   {.v = nextcmd } },
	{ MODKEY,			XK_b,	   spawn,	   {.v = prevcmd } },
	//Volume
	{ MODKEY,			XK_v,	   spawn,	   {.v = volcmd  } },
	{ MODKEY|ShiftMask,		XK_equal,  spawn,	   {.v = pluscmd } },
	{ MODKEY,			XK_minus,  spawn,	   {.v = minuscmd} },
	{ MODKEY|ShiftMask,		XK_m,	   spawn,	   {.v = mutecmd } },
	//
	{ MODKEY,        		XK_semicolon, spawn,       {.v = dmenucmd} },
	{ MODKEY, 		        XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,		XK_l,	   movestack,	   {.i = +1} },
	{ MODKEY|ShiftMask,		XK_h,	   movestack,	   {.i = -1} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, transfer,       {0} },
	{ MODKEY,			XK_x,	   zoom,	   {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,			XK_u,	   setlayout,	   {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,		XK_s,	   togglesticky,   {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,		XK_n,	   nametag,	   {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} }, 
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

