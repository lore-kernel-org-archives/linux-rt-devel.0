Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D654A7FD
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924477; cv=fail; b=esanbWX2Oa2fXgn/RpSXhruxwJVgi2iiRCwwkS3k4IGtyUVOXLN1uN9o9tyzxlgDNpOCSIv/YVNleul2pSegbEY9mDvMY/wptpBdMBdKdskGJDTDWj17cLSlLcTm/b2B5lWbvASZ7K3SuET0RRBy/Y84nZpAAkCbCKtAl6dHfUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924477; c=relaxed/simple;
	bh=rDn0bdIY0p43QAz9/4wt/wZLUN5iHmEL1/nfTUBBM40=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbBUDWkSR07bqYyHXlG9vGr37Vxzu3j18oXLogYWsrJvwCGprFlWQkI+tcMJ2cPPyCLhdTzcpZu/e4+0dcwfSXPBhURm97ss9c++54+18gjaYq6Y+r0g7BiBqzCniHCUmyp0chBdhpf5HPO4zoB9VtFNhZpgeipPRZXF7PxINlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzLKHrSW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzLKHrSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791924476; x=1823460476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rDn0bdIY0p43QAz9/4wt/wZLUN5iHmEL1/nfTUBBM40=;
  b=OzLKHrSWyLNF9fSCMHH/ECKSiz64oGOi4iXQwhaivccEw1+USCvZkm+A
   +dxceBIfoXWMwCtAyHB9t8AzSeg21xhjfdxZgTnxhRdlx1L1B2W56YaT4
   DNbNJuopHPE95s839s2PA2Po0hEkCtWBGX2LPzNRVBHaIi2c65wBnMlA4
   fRuLOU+BBlHn7Ftkt2WpNGSjx34jYDUXQXQrMpyrR/3NO9PV4xL9zMmFB
   7Pdl3PQT1+1+7ISKMUcFxLmgVQMhvE0phagnpJ30E51uCk+WmP9PLBVRB
   1WDHv6VVKGE/G9PDeqhS8nBEWlR1585eyYzVaT7NZQtxLX3NI9FA76Ja9
   Q==;
X-CSE-ConnectionGUID: ZpRYF7h/Q9+2o2UjnU3Mxg==
X-CSE-MsgGUID: 2lPiif83RTWYZ2ZK2GFdLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="539339"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="539339"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:47:54 -0700
X-CSE-ConnectionGUID: SzNfySdJSjCmDHbBazRkjQ==
X-CSE-MsgGUID: gz6QnOMlRHqWt3p7iaqPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1143996"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:47:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:47:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 13:47:52 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1LjkTpmwPEKiiA9m1scdO1QVP1b5Y8QO0kXNxHDh2rs5jHfkKDPUZoXFci5ruO+RwHVKHdSWGvbti3WyYMPaEmhRsGviqUEw1PVKLy0FuqNbG8pzpoet69WlumrHg8CT3tBXzLzH+Z1fc4gPpJ7vzL7czvxXnrqAH4GX4spR6f7XnAKmggqSKk2KrkN7ahq3iYox9d+tCOnZVAfyPrN8y3g6uCSpr1oM2O8zNvzzNTvD+3stJ92rMnWiksytUL999C17zkPFdSENz5ER2IJsyDXPfNIUnGiVtR/xI7CfhnII519Ov3iuOf1RLx7uW1W0mxrNreezY76SCB0wSXbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mMQc9a6nC/RwV3fsSQvZEd1rIdYwuVaoJiJJrHYTbw=;
 b=v6wmtIXx4BtbpCHl7bUwMDJj2lvt54H1/eB7jekL8S6EMOge7fMYsA/ljVT1dkh/x9lALISzCqiceNJVP5ZS3vgsU4h1ja5x2kbTC3jGN0BOz3aGVGj+8Ktr4UU/Ea4Vi4FItORYqABiNH+quAGXDqQ0CteRtgf/bpiQvseCBWPSoXbchBu1IWk/IJacGcEG0/q5fG1ECSoPpgOThtbSDUBxGTtV1uX2fx5ULFaaZrkPRCoLy4KhFUddYsKmsVPy/7zBbQnYUpKzlxvrPF41L9MTWiVlTLQSDiO2DLVVuLy43o+6LMOClbDEnZeMRoSrnvyKmydwll+dedtYXdix6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 20:47:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 20:47:45 +0000
Date: Tue, 13 Oct 2026 13:47:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
	James Morse <james.morse@arm.com>, Kornel =?utf-8?Q?Dul=C4=99ba?=
	<mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Paul
 Walmsley" <pjw@kernel.org>, Peter Newman <peternewman@google.com>, Radim
 =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <as6Y72SbiXcJh6Ei@agluck-desk3>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3>
 <as0Zeoyjiy5CW1DT@agluck-desk3>
 <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
 <SJ1PR11MB6083F4281EDD036A4E73A532FC9E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a85a5aef-5468-47ba-afba-8bdd666dadd4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a85a5aef-5468-47ba-afba-8bdd666dadd4@intel.com>
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c974ffd-e0e2-447a-a437-08df296b3c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|56012099006|5023799004|4143699003|261009223027099003|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: iOnccxk89STI7Is5u2V2Y2ZZnOYkoZZp0Kbe36WgsAuGcqw14dR+CGvCGWIYycLt9Tl7arenFPpNhf3MlPwyb7ni1yDlqDOa+a+umYqEvDeSUizmuuUzz/klin1bbczo78udEy0yvCbxK6+nAAUbLXiddOrx1D97YBNEUPgAyKUThYVRKkIp+QOJTD9j8p3qMZRBppdUliEbURK9WDAho9JhGAe2CgyO9A0dfb3NW/tRLl/hRm09M9K+7mtdx6ur5QafhJ/ceAVgRO826jSNRhCQXYYfBZYQu/+hWl6NFQSWtIggn3E9DXxntn4zIPbcXUVGPplxztGkcKdQJ6rNHTiFeTHYN/ZEBK/GRp/W7Il3hOcfQX99sElyeJ9VpnmQJfmsNiZ9GXmZkRHdbcghlFbqxhZB5m5I84TpJ6kfPi/IzAIFuIGH1Dhvr0to27nmjQmd6Ik6rlp4P3oo8eICAAuuwZmanEa0/vv8T+9TjSA5S9MkAh9f2EYrMarb4fPRB1w1rd8kTEvr8rwLX9D3r4MP/kmScpOJOvCH7qn7CrtTsuhB3IQApgnFgvso2i7mTy69B+YMjRTFsgp/Wr6yLRKUR7TxutbIN4raI7ARX5cjizlplvLhGz5LBA2VMNJ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(56012099006)(5023799004)(4143699003)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX4pCOkVBlTGhgXycV9o+MHPgUvXXM6LeGDcJqCe9ReSnVmuKFbHoOaJakfZ?=
 =?us-ascii?Q?X5kuTRe7ZzdumemDeW9DTdPgEZdbxkY5qMGQeYkHXqyiTXgzhYa8tTnXUvkt?=
 =?us-ascii?Q?riNM9Lj8fXRg0rZc6ureWeQXPIkqiTwrVCQ95ZL8fdCYXNK/OytcvGZF0Dy3?=
 =?us-ascii?Q?ut05ajLmFnBH6UpLBXGmePAFXZ/QfvYOh+kGFP1XgS8KFcLNv1LJk/hHBhm5?=
 =?us-ascii?Q?6UfClKat0CE7I5iQLjKyfmOEWOo351wx6L6OBfV9RuHyHOfqg1X14+bpnbYx?=
 =?us-ascii?Q?8fHPar2+v1MONxL4s7qgkyqZWEzgwJUdTccp2loTqbK1CqGrZq12tayw252V?=
 =?us-ascii?Q?/u/fyUL4zyc7T1BojcXmr0R/X79WxkmO0+h6FUnWGMXvfVhBylzyfLKlM1Ag?=
 =?us-ascii?Q?4vjRzPv5TcPgFItOBPeLUwm7mlikQKFqbaz9JBc0Xcpa5r6aYfhVTl649IFw?=
 =?us-ascii?Q?wSApilyplcDO9mWRn+KcbufR+fz7+jU5eDsjiEtfEWNQBGWJikNT/xNvySOP?=
 =?us-ascii?Q?K2MUmxSJKm9qDaV01nHHBK5Gh/OslZA2jidwy2g3BiFQdCksplPZ4HNxL48m?=
 =?us-ascii?Q?0G2aSRojf66UK88MQH4HpdmfZMJuMSvqTY4ffWlC5Pa81QwgFVPQsvvj29mf?=
 =?us-ascii?Q?qy6QGzDs8VWb00fGL3WHyjezCbidK/02ZHLshpfoydHdcr1MDB2QWszVe0be?=
 =?us-ascii?Q?g0YZbxzKxmmpQwSifzXPYjQOCODTiE+ZOk6bPK8YoQRGQEgA4l5GdIqEiFCu?=
 =?us-ascii?Q?2ltkPse8aJGK/A2Fga/yxI3ZHYBD9aUnJYGUNNvuYhC0/HIzXddALE/Z1YJp?=
 =?us-ascii?Q?rR3QccZPk12Ldjkd3ls5yjp417UUWzYcR8p1rQfNDQkAfj4SW1e1nwVVC9PH?=
 =?us-ascii?Q?p5+m72mnG9YdVp7BnACka+6zDnUfDxos1Y7nKadh8CwWDtiT6nxTI68yMblL?=
 =?us-ascii?Q?VZUEJYORg54H9M6XqzwgVYXMYtvXLpAv8C0PPaLjsaozqZisd+nUKk86bpda?=
 =?us-ascii?Q?gp32v4i6OgvCwIFFTIrRPzJvwwoEgdB9DDKHAG3EvfiDqfsSD7MHhkjS1HKD?=
 =?us-ascii?Q?1Axoldz6MyCw4SgTiHVDfBYPELrLw1g0FKo4No++Tq658+gBy4kx80gALiTR?=
 =?us-ascii?Q?Dm3KfgvRo9XSY1Ox/Tr8cZ7rZjVLdh38nwfQQxX3PDQZeww0/Ah4qsLYRqN8?=
 =?us-ascii?Q?dfuouBMR3OoO3YEI4Av7fisbhTH8UnnkEaadP9crNvssQygCrdKqvsYVZ2UQ?=
 =?us-ascii?Q?bIWhSsRMDU1Fp3pIuGTiS1qBfc2ytu5yqBHrh0YL49cqrIejiQ/kop77Iu2P?=
 =?us-ascii?Q?eZxCIx49h8oun3FosPZtyNtjjtfH+X+YW3PSKmZ6+d+abAsky+6eJDYdVjsY?=
 =?us-ascii?Q?ENz0WZGE+AQMgGoI2WHHIbHU/dPX5gkwbzQJ18AHHdQH6pWs0HRJ1rAV8ecr?=
 =?us-ascii?Q?nqwFUq3Wv6nCLfrF8jeB8Rft74Ktg5iX3uPa5H+zj7qh7fobsyc2LCvGpCiM?=
 =?us-ascii?Q?YLug01W71iyDJaDpmEQQDc3sLRaZ/5RYkz6fWLY73+O4pU3gg/6eTEBsqduP?=
 =?us-ascii?Q?ub4968Krrw6k1jw2FCbtrpKdm8il8rQ6oTXA6cwY8NtiEEMqz2mXDUBofCbw?=
 =?us-ascii?Q?rdnih1htVX9EHiO9VfveMYWGM816U9T06wsKgVJCy0DzYdNXphOliLg5kaQO?=
 =?us-ascii?Q?gYCicxi4JeQamLC280kJhqnidA1FwYy9Z3E2U36m2V5FLkHjuUAIRqH8xRxD?=
 =?us-ascii?Q?wWFDKbfvug=3D=3D?=
X-Exchange-RoutingPolicyChecked: xdw3M3WPG43JqDD/IvApmJG4OfXLSq+E9zKSVL8COx7Ct/kPJMCculbwJmLdxwI1XkwmQZbk+jxsPanBk25RRUkH/Rwp03gy2ukxMT9Px0laso2oYOC89x3rPSZ6plegdc2gpWrzoy/tkZSW50+WNPsqWuVOUwkmor+xy+Ot8bHYJOC01At0JgI6+zs6V5NWMaUhG8O5LoOnP7QynQtd9PgZ/aSQgk6N+PIYVFcRjTJM3y2qtjln1ZScncdwyX/2fXZ8qoMCzwFfImvY46AzEU7UdW3V3Qumcsye6Zgezx3bCzLsmJeXZ58Da84euG4pBog4UPMfOdh8FcTlO/1Nmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c974ffd-e0e2-447a-a437-08df296b3c07
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:47:45.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFoqwKNqSCE9iE2swJLK8iUW8Z/ASBGTXSxMECR2seR+y8lddgN/CoaSliW9HoUw5uJLqKHeKCX8DppQIkvE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 10:42:05AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 10/13/26 8:55 AM, Luck, Tony wrote:
> >>> 3) What should happen to the legacy /sys/fs/resctrl/info/L2/cbm_mask?
> >>> Just hide it? I also considered renaming the resource to "L2A" to
> >>> avoid surprising legacy code.
> >> The current direction is to have these top level files continue to return
> >> the properties of the default/legacy control while in "legacy" control mode.
> >> When user space switches the control mode then these files return empty.
> >>
> >> This is what is implemented in RFC v2 so you should be able to see it in action.
> >>
> >> It was noted as one of RFC v2's opens:
> >>       - When switching control mode to native the top level control info files
> >>         stop returning information. This could be considered "work as intended"?
> >>
> >> An example of this behavior in action as applied to "min_bandwidth" can be seen
> >> on slide 4 of
> >> https://lpc.events/event/20/contributions/2368/attachments/2066/4625/resctrl_2026_combined.pdf
> >>
> >> Hiding the files could also be an option. I have not heard strong opinions on how this
> >> should be handled after the above mentions of current direction.
> > 
> > My PoC hasn't implemented anything for the control_mode file so I get this:
> > 
> > $ cat L2/control_mode
> > [legacy] native
> > $ sudo sh -c "echo native > L2/control_mode"
> > sh: 1: echo: echo: I/O error
> > $ cat last_cmd_status
> > Changing control mode not supported for this resource.
> 
> The current PoC supports multiple controls for cache resources but does not
> support switching to native control mode. Only MBA resource can switch to native
> control mode.
> 
> resctrl fs built a couple of features on top of cache allocation that are exposed
> to user space (CDP, IO allocation, and pseudo-locking). It still needs to be worked
> out how these behave when there is no legacy cache control so for now these features
> are hardcoded to be associated with the legacy cache control and switching to
> native mode is disabled.
> 
> > 
> > But it isn't clear to me what legacy vs. native should mean for asymmetric L2.
> 
> This would be up to the architecture. One possibility is to have the asymmetric
> L2 control emulate the legacy L2 cache control. I did not really consider this
> and just assumed the legacy control could be expanded to support different sized
> domains. 
> > Potentially: Legacy mode: L2 is disabled to avoid confusion with different bitmasks per domain?
> For "L2 is disabled", are you referring to the resource or the control?

The control (though with only one control in the L2 resource its effectively the resource too).

> If legacy L2 control can be emulated by the asymmetric L2 control then a user space
> can continue to interact with a L2 control that pretends to be symmetric on an
> asymmetric platform. An "enlightened" user space can then switch to native control mode
> on these systems and interact with the asymmetric control directly.
> 
> I am not sure that this is what RISC-V has in mind here though.
> 
> Ideally user space would not need to be exposed to architecture differences when
> interacting with resctrl filesystem. This means that a solution like this would
> force all architectures to do something similar for asymmetrical/symmetrical
> cache allocation.
> 
> Another option is to just support L2 asymmetric systems with the legacy L2 control.
> You state it may cause confusion - I assume you refer here to the schemata file
> showing different CBM for different domains? The legacy info/L2/cbm_mask needs to
> pick one CBM to display, which could be limiting. This is what the new "max"
> aims to fix. 

Reinette,

The system I'm working on has L2 caches that appear like this:

	    L2:0=fff;1=fff;2=fff;3=fff;4=ffff;5=ffff;8=ffff

The P-cores support 12 ways in their L2 caches, the E-cores support 16 ways
in each of the per-module L2 caches.

A legacy implementation would have to present just 12 ways across all
domains to the user. The implementation of that has a couple of choices:

1) Ignore 25% of the caches on the E-cores.
	Unlikely to please anyone.
2) Silently allow access to the "f000" ways of the E-core caches.
	Doesn't waste the hardware, but if the user tries to divide
	available cache exclusively between groups, the "free" extra
	cache would result in surprise sharing.

The drive for L2 controls on hybrid systems comes from embedded systems
where expectations would be for the controls to operate precisely as
written without any fuzziness.

I'm not seeing a market for the legacy behavior, so implementing it
would just add complexity to resctrl without any benefit to users.

Perhaps keep the "L2" resource name. Use "L2" for a control name for
symmetric systems. Use "L2A" as the control name for asymmetric systems.
Legacy software won't be confused because there won't be an "L2:"
line in the schemata file.

Don't bother with a control_mode to switch between legacy and native.
Just auto-select the "L2A" control on asymmetric systems.

But since this thread started from a RISC-V thread, it would be good to
hear what is needed for RISC-V.

-Tony
