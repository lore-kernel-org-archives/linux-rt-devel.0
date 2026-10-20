Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792521481;
	b=HQpJnaOFMqlV28T0+oeaRkmOXjYVQi86jDSm0Dh92mLa7oRq3GFBV2OrAs/D3vYtMPuH
	 Be8opnOPyhs9tQmfhDe+ozghuBjI5QmP8FOlGQTVynPzP33axxoGsFp3YQFjD626RD2hP
	 PfZEZSz2xe00JmYhuGzrxdlqoPRho7fnb6+4vpMksmB/JrQe91TOlVDZlzpF83Flw0vp/
	 Bb/P0SmLdoNxWIBL/0tVzD9FMwOKPSmf3/O2lTWZJTfhnXZQxn1qcH/xCMO/WgS91T+i5
	 UbKtWRbyr4YJuqV+CrsijPPsp0/TpudHHEvcbrUQ899LmHnVtojsN7PgMEa/1peU+EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521481;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=t/X6HYubv1PXqFt3KdzrYTRsDThfZg6ZMUqKpu2PLNQ=;
	b=w4JcA1T+Xj6h9iKMwCF0gddifzWyfFlAq6LAnvauif7Ktm7c9exT4tlJDivO7fkqFm6K
	 AS3kpJ+PdFWvEq912KZh64eMtxXc1lRrwoBVhX/ixFLwPHAN1hl6ZgCPCmkSyocr3Uzg/
	 VPh0DWh0LV18eW6oFbEzF6KyDU5E3JZNMMa2koNsygVWdaXQ8hTmm6Rjk5Z+8/cK/jsdI
	 6OMIhZBt7AgXqDnPue+jR2g7GoWgdjKecH5P7bcoD42iw/5Y2iD2rdbTqKaV1BVgi9hli
	 qM3oORtN+DYh0SORXXRqoXI9NcsINaI+ZceRCjb+khJttR3NhpYZ0qA3x7LgQF6pMXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NOi+FJEe;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3B606A31A
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 18:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NOi+FJEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792521480; x=1824057480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5It84XmfgFr5afBWYfoq9kYMFtb8xLHHetx7LdR9zs=;
  b=NOi+FJEeVGxr0+qXtyYll18ptlAxLaaxGviv7ueE4hyFYOaACQx36rDb
   LRU7UvTb7+GH+bHFNM7K3YOMvb1ihRYCwWdtYLCTmcN/i9jLfKUj5Gq0C
   nUetya0tPZTWlI9t13sA3qQ0k619sIhgMhtzA++g2rGe6ZU7zoSd+eXl3
   4tLuQFhzE4g7KqY0XbwuQZQNAWdlT913hBozGLmv3hC0SJ35xpLk4iaOS
   4B6z8T6ZJw29sB06Mn3U0QKGM/0tkUE9d/Bccp5jWFOUkG2NLZcWw31Qj
   4rq/IPFgo+fV32zjcv3oMhf0YZuGmXpIbF+anOiBgeFv9V10W5JZcID4U
   Q==;
X-CSE-ConnectionGUID: j9aPTIxVT9mpVjC6Dy5/cg==
X-CSE-MsgGUID: ZVptBpz5Qo2t2rL6Lf3n8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1138269"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1138269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:37:59 -0700
X-CSE-ConnectionGUID: RaRIQQcgRqGUw8VNQUslQg==
X-CSE-MsgGUID: m6eX3/lvSJ23rK9RulV20A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3286643"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:37:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:37:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 11:37:58 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:37:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlwiaMUvtRVUM9t7bnSrfnUdQIgzwl0IH7A+/f6UHzSzOmHy/OzTyvFTrFvmgnfH+zi4BgtyS/U1/dwHSWryaoRmzQocDPBx4u8GLirNMqtT0PFnjYxBLjEJOO/0xhUnrV4KDOMF3anfJjWVoXPfYDIUakENdtV97jMCqLS/GEdRC2ggwjM0Vh8Qcmg+YFaD8RuVTrbP4hHYrYHroKGsF5VOxvpWOuCgS1p/9EGT8WPv+KwIjXmmvyPH1fKE7540gM1UsY32D+LT4Vmx8z5bGHzVDlbVO4DuhvKfXJWxI48Lj+wjd9YyfEbBVohQ0CV6wkNb02oPTOTBYQmWbMC96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/X6HYubv1PXqFt3KdzrYTRsDThfZg6ZMUqKpu2PLNQ=;
 b=oO891VUgRamcs5ht6PJrm53zPN3yQvxXmahj53zI2mnaKLPzET7nIygmVe9nZ03yTDHMEpVHdjyOJ4HzD0KkJbDNV4sSD1PIwtnTAaLeu3yNavNFQhGcP5AibFoHrS9aJs8SVxNh/JxdGCMjl+Tx8zFqjgNeH0OV9hUIXdH2/Kq7JH74xnSf+3sYrh2x9hFGVjMMzvzafpD57jSzzJjtwE+/1We06DjQHOfxz7B9R3yD8Lsy2LgrX1YBxuyu+qJQrWhrxaLrrxqY9r+VZ6AtWtd3pquqKb4gr+/TQelGa4QuD01d6ykJ82UFNtOBu8YB/tAt6sNJXlJLgDv7j3PxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 18:37:56 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:37:55 +0000
Message-ID: <49444078-0777-4318-9f8b-0d582d8a29ad@intel.com>
Date: Tue, 20 Oct 2026 11:37:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Albert Ou
	<aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, <guo.wenjia23@zte.com.cn>, James Morse
	<james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <liu.qingtao2@zte.com.cn>, "Liu
 Zhiwei" <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Luck
	<tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, yunhui cui
	<cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-doc@vger.kernel.org>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a3857-a8c6-4dc0-dac9-08df2ed941cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|56012099006|4143699003|261009223027099003|11063799006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: W7IeX/CXK7H0u6TxIbru1eCx1WWfnuDc5f4+WZzm5UkNtQ/Nu1cJITQCRNCBUiI1bh5nNbo6Pdwh9EgMdX8C5fE1hgad8Bqz5qWLBPFxUJ/FgmwKRlSmaB4Toab8Dih3ruD0JKJJbWpTK98xnWeJF6lH0eM7OqqiT/RO1DdF0ansHGFZAo5dqmzZ1K9kEAYKVVPiwDHSWsHtTRD8jskxeqx+UvhqN2TqLtiRuS4FPhjLnvWRyIjX2oFXSLqIQiOfUlOp5tK0OpEW6M3b+VPrF2eTxdPR9eem8xwX2N0U1v7sD2tBmxCjzRKJ7yB60E5zhqyKh1Z3sTmF5e5AUnw/5wgnUeXxZKmRwUFMxYuRCBVevKjjuzhxKHxaIa9R/v3hLQptNS1jFswfKuZjfGB+SR8Nz8XhSiSmdLUHOwnLyJs/NpcPHmJZ//gP0eFgnKavmUIyBgD+cRrjFO1BNwj5MJQGzRphJTxqmU1v/VMOFvbFPuEhUo23a2kqbdGbCErNv4iS5F13VBGbkQZ2njdazXQw+fBACQI6kU3sTLFMes2ZOEfLbGZHagy2Jyzxyf+F1dp1b3vmmbSbtLRc3TG/j2/RsDA+5lvtCt5fB4hSpbt4ibxgmnsuXGsb69lTkVHHsJw4ran5timmfZPAe2s//CNW2ZuHlNc5eCwnBGxgpH6ExFzxL9qZ5AuvroFk3/zocZWpU31UIM51U6pGcKTnCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(56012099006)(4143699003)(261009223027099003)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFkY0lkN1FoSkZ6QmN5b2NnMVBRYmxBMDNqdlIwTVNMV0ZZWlV2SFl2MjYr?=
 =?utf-8?B?RExZTEYxcnduc3hKdVlHUE1aaHBOYkhybXJ4eXlyanZ3Um0ydDNrMHkzODRj?=
 =?utf-8?B?bC9KTTdNanZNMXlzMVUwSlEwZXNvNTNEcHhTODMrWFBSQ2FjY1ByZTVvZFJl?=
 =?utf-8?B?Y0hoVjBjRlQrMWdnK2NBbjk4c3pQV2c0UkRKQVFxaDNHd2NBdUpnR2IzV3g1?=
 =?utf-8?B?VDkwWjNSNGxxSUtpNXZNVmRzUE5tY2pVYmxLSndZM3k5aHJscFpkbW8zWVND?=
 =?utf-8?B?TFY1KzMvSjVHNGhqdFNvb3dZdk43WjNXQnBFaUR3RVgxL3BXdlJXV29kbXow?=
 =?utf-8?B?aWRTalFqVnVGdksvbHRKblJnbEF2eHptNVI2Qlp1QU9yaWVPb3dZRXNrWi9a?=
 =?utf-8?B?SUE4Z1pLa0tqa1JxOURmUUZiTWNZWXh0ZXhCR0Uxd3RJeUxHNmpQMjhGVFVJ?=
 =?utf-8?B?SEsyc1o3SnlmTU94UjI5NnBUdFBlVlZRNWhkOUVycHJUZkhKUWtrNE41SlBt?=
 =?utf-8?B?Zm4zOHRJak5MTjJRSncwMlc0SWJjc3FWM1BFNXFxL3JFcnpRTHgxVVl0Kzlo?=
 =?utf-8?B?VkJLMEx4blNmNnJjc2svUTV2WkIyeWVTR3dVOTZMVzU5M3dhNkhrVVRuRFZD?=
 =?utf-8?B?d1lOU1EvSTd0K0J5NWszektlamFwdnJTZmJKY0lCNHd5UVFZQXExcHZqYldQ?=
 =?utf-8?B?cHhJWjhrUk4vNjl2TnZYOXM3NEpFMm9uNEhTV05mdW15emhoTlAzb3p1Tzc5?=
 =?utf-8?B?Nk41RE43cFJDaXVMblZVd09SOUlTejJXQ3NIZTJDNFJZdmNRY0tNdjFMaDVx?=
 =?utf-8?B?dTVuQ01iOC9uTVBLSWNnS3Fic2JBL21seHRWdzVrWFRLbHUyeUxYMzQvLytj?=
 =?utf-8?B?d050cDZlUEdROHZtd3FzZVVtdGlMc1pZOHdQQmFKRkN3bkdkRkVBNzhqR1c3?=
 =?utf-8?B?Vlp6c1BaREtxN01XOVJac2ZPQlVIZG9PSms3SFNKZFVsNzExaEVkSkd3ZXVD?=
 =?utf-8?B?T01ZMGo0bUVnTjlSVVhXd3FpUUZUL3JVOVVYSnNLQ285RXhOeDZPblVGY1Qv?=
 =?utf-8?B?b2wrZkc3V0o1Vk5jSTNQV2VrejZYSE9IaXRkNXcrMlB5Nmd2YmZ1R3A1VWZa?=
 =?utf-8?B?WVB3NmFwTnlNRzBNM1hDNmZLRVFWMEt0cW9JbDl5RnljemhNcURvRkxFbVJH?=
 =?utf-8?B?bVJ5WUMwL2laUEdHYno2R1NZdnBSbEZjazlFUlZERDFIT3ovYWRrRVFBZE93?=
 =?utf-8?B?WDM4bmNZVzVmOEVSZGdJbkJXNkdVNFloYkZITXlRalRhYkdobWIwLzhEUjRm?=
 =?utf-8?B?aWRvdVlkSU1Qc3lsMG5XSU4ra0tSWnc2UjJCMHBoZjhkNG1BVFJ5OXFjeWtv?=
 =?utf-8?B?UmdOUkhjN25VNHM5b0crTkVFdE5WemxyVXg4MFFaNFlwbDcrV01mVXFYQ2hD?=
 =?utf-8?B?RlNZNzhXVC9qaHdGZWIyamxOaG9CWWEyc0FNS0dSak5TTXlrOFhWVmlnREZu?=
 =?utf-8?B?UVhIOERTTE1OTm4xWDdDWFNtV0dSVTFGUFBPT3REbklSTmtUc3ZneVByQ1FD?=
 =?utf-8?B?T284cWlob1cwS3lzanVvRTE5NjZSWjJ4SGYyUHlla2c4WUFYQklObUVyNGlV?=
 =?utf-8?B?RThJa01ueGkwR0ZWb0NWYTYyRWxpRlFTS3Vja0s5ajFPRm1NSFlmby9yVi9R?=
 =?utf-8?B?WXpXQ0ZOeTdyYVhHT0JmbWdBcDlKbmFUT3htTjZmVi9md2RQWnpJOXZXRVRE?=
 =?utf-8?B?Um1oMFY2R1VoM0paY0ExOUQvK3kzb0JjdFpqK2F0Y2tBUzFpZ1dSZmFtVXhY?=
 =?utf-8?B?Q2pPd2JnMGFFdG9hOHR2S3ZYbm93YWNNczJ4NTZjQ3UxZHk3WU0zd3ZQN05R?=
 =?utf-8?B?dzhmakdFcVZSdFNZMHhMWjB1bHJ0Yk95YnVXSFhiZ1FvNVRkZ2RWYTNNYVVP?=
 =?utf-8?B?amc4bVFGblh4ZWh0R2tIQmc1Ry9BUUtMOGpocWNuak12dEs0WjNuNFVUdkVY?=
 =?utf-8?B?UXVCaWlhUkJCbWFMdTlqdjdybDR0U0dsd0h2dzhhZHZ5bE5hT3hWYlM5UFJy?=
 =?utf-8?B?M3hiMURwMDJFV2cvSFk2aThJTEo5RHN3SVgzaGxzT2h1SXBYTnMvSGtNMUgx?=
 =?utf-8?B?cENnbmIvclBjaFhrRHRRTlpmR0NFN0tQTzR2cVlFWWZ5YkVhV2ZZYmExUGF4?=
 =?utf-8?B?WWswMlBjWXlmWHlQSHVnV2oxNTNNN1hmVDZSTSszQTgyRmlhVGdyb255TzVM?=
 =?utf-8?B?bnJtVThNeWhVaXJrUlZmQzFUTC94K1VkZkpMK3g2UWZDNStqNUU5eDM5S1pk?=
 =?utf-8?B?azdrVFZtVXliVTk2TkdZUk9pMnlEVUZPdjhjT3dBQVJzdjV2QnNacm42MmZF?=
 =?utf-8?Q?J1U2WmCiCfrIR584=3D?=
X-Exchange-RoutingPolicyChecked: Sf4juE++NV2jjTrlNo24jcr4yOg4y4K2WTlWxOp2mKpkGYKBP9gv7VQNMkItbf2Y1bGxF6TzEWVQfo1jM4/I4scX04OGgo3tD2U08uhRnYc/GPq3gkhyQunC9mOjBGw9apdCFbRJMDqt3cohYHnHoGnF0UI4g9USX+RiEUSSjyj1OIVq1Nym+QYMnKboV/U7ZfEtQb5z/HxMquJ21ePO+l1FHpepGXbDwQuYbqpFOuZJqyreOsISMdEMFyV0HZgdR2xap8lVgseD/4ZgvxCnS/2RdXRd/hIVn93Aw5tpGeeA6bziPK+2DGvKha2zbrxdPUsOmdyRzApxeksxkZvv3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a3857-a8c6-4dc0-dac9-08df2ed941cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:37:55.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGGYvMhh14vklTrMV3kzvM8rob56nqASxQiGaWJvo/YIYB/QElTXTTPt/1xcyaWPbo9S/2By7h912eKj95xpVln8XF/QT6RhqjQqRNU1gTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

Hi Drew,

On 10/3/26 12:12 AM, Drew Fustini wrote:

...

> diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
> new file mode 100644
> index 000000000000..867db663d958
> --- /dev/null
> +++ b/arch/riscv/include/asm/resctrl.h

...

> +/**
> + * resctrl_arch_mon_ctx_alloc() - allocate per-monitor-event arch context
> + * @r:     resctrl resource being monitored
> + * @evtid: which monitor event needs context
> + *
> + * The CBQRI driver implements no monitoring events, so there is no per-event
> + * context to allocate and the stub returns NULL. fs/resctrl references it
> + * unconditionally before checking resctrl_arch_mon_capable().

The last sentence is unexpected. fs/resctrl only calls resctrl_arch_mon_ctx_alloc()
from mon_event_read(), __check_limbo() and mbm_update_one_event(), and none of these
can run on a system that does not support monitoring.


> + */
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_event_id evtid);
> +
> +/**

...

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> new file mode 100644
> index 000000000000..f10a24761b25
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c

...

> +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	struct rdt_ctrl_domain *d;
> +	enum resctrl_conf_type t;
> +	u32 default_ctrl;
> +	u32 i;
> +
> +	lockdep_assert_cpus_held();
> +
> +	if (!num_closid)
> +		return;
> +
> +	default_ctrl = resctrl_get_default_ctrl(r);
> +
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +		for (i = 0; i < num_closid; i++) {
> +			for (t = 0; t < CDP_NUM_TYPES; t++) {
> +				int rerr;
> +
> +				rerr = resctrl_arch_update_one(r, d, i, t, default_ctrl);
> +				if (rerr)
> +					pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
> +							   r->rid, i, t, rerr);
> +			}
> +		}


Above looks to be an open-code of cbqri_init_domain_ctrlval(). The loop
is unexpected here due to the duplicate writes impacting types not used by current
CDP mode that the comment within cbqri_init_domain_ctrlval() justifies.

> +	}
> +}
> +

...

> +
> +static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	enum resctrl_conf_type t;
> +	int err = 0;
> +	u32 i;
> +
> +	for (i = 0; i < num_closid; i++) {
> +		/*
> +		 * Seed both DATA and CODE staged slots so a later mount

nit: This seems to refer to d->staged_config[] that is only populated by resctrl fs.

> +		 * with -o cdp does not see stale CODE values.
> +		 * On non-AT controllers cbqri_cc_alloc_op() masks AT to 0
> +		 * so all three iterations land on the same hardware state.
> +		 * The redundant writes are harmless.
> +		 */
> +		for (t = 0; t < CDP_NUM_TYPES; t++) {
> +			err = resctrl_arch_update_one(r, d, i, t,
> +						      resctrl_get_default_ctrl(r));
> +			if (err)
> +				return err;
> +		}
> +	}
> +	return 0;
> +}
> +

...

> +/*
> + * Attach a CPU to the picked capacity controller at each cache level whose
> + * cache the CPU shares. On failure, detach the CPU from everything attached
> + * so far: the cpuhp core does not run this state's offline teardown when
> + * its startup fails, so a partial attach would otherwise leak into the
> + * domain cpu_masks. Caller holds cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	static const u32 levels[] = { 2, 3 };
> +	struct cbqri_resctrl_res *hw_res;
> +	struct cbqri_controller *ctrl;
> +	struct rdt_ctrl_domain *d;
> +	struct list_head *pos;
> +	struct cacheinfo *ci;
> +	int i, rid;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(levels); i++) {
> +		ci = get_cpu_cacheinfo_level(cpu, levels[i]);
> +		if (!ci)
> +			continue;
> +
> +		rid = cbqri_cache_level_to_rid(levels[i]);
> +		hw_res = &cbqri_resctrl_resources[rid];
> +		if (!hw_res->nr_ctrls)
> +			continue;
> +
> +		ctrl = cbqri_resctrl_find_ctrl(hw_res, ci->id);
> +		if (!ctrl) {
> +			pr_warn_once("no L%u controller for cache id %u, CPU %u is not controlled at this level\n",
> +				     levels[i], ci->id, cpu);
> +			continue;
> +		}
> +
> +		d = cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_domains,
> +					   ci->id, &pos);
> +		if (d) {
> +			cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +			continue;
> +		}
> +
> +		d = cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res, cpu,
> +					     ci->id, pos);
> +		if (IS_ERR(d)) {
> +			cbqri_detach_cpu_from_all_ctrls(cpu);
> +			return PTR_ERR(d);
> +		}

Should a failure to set up one domain prevent the CPU from coming online?

As I understand the driver already brings a CPU online without a domain (albeit
with a pr_warn_once()) at a level when its cache has no controller (the earlier
cbqri_resctrl_find_ctrl()), so I wonder if here (on domain creation failure) the
CPU could just be left without a domain at this level without failing the CPU
online entirely? It looks like cbqri_detach_cpu_from_all_ctrls() keeps the domains
consistent.

In the end this is a driver design question, so up to you.

I just have a few nits and a check-in on the design but all the resctrl filesystem 
interactions look good to me.

The one open is the coordination with Tony's series that moves the
resctrl_arch_alloc_capable() and resctrl_arch_mon_capable() work into
resctrl filesystem. Thanks for making the switch to use alloc_capable, that will
simplify the accompanying RISC-V changes.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
